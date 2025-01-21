Instalamos el Windows Server 2022 Core

Añadimos el adaptador solo anfitrión

Y cambiamos la configuración de red del adaptador añadido anteriormente para que esté en la misma red que los demás

```powershell
New-NetIPAddress -InterfaceIndex 10 -IPAddress 172.25.56.4 -PrefixLength 16
```

Comprobamos pings entre el nuevo equipo de la red y los que ya estaban

## Cambio de hostname

```powershell
Rename-Computer -NewName "HDSM-CORE-2019"
Rename-Computer -NewName "HDSM-2019"
Rename-Computer -NewName "HDSM-CORE-2022"
```

Reiniciamos el equipo después del cambio

```powershell
Restart-Computer
```

y comprobamos el hsotname con hostname

```powershell
hostname
HDSM-CORE-2022
```

Vamos a configurar la administración remota

En los equipos tenemos que habilitar el remoto

```powershell
Enable-PSRemoting -Force
```

Ahora añadimos los trusted hosts en el cliente con la ip de los servidores

```powershell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "172.25.56.3,172.25.56.4"
```

Y comprobamos que se haya aplicado el Trusted Hosts

```powershell
winrm get winrm/config/client
```

Nos conectamos desde el cliente al servidor

```powershell
Enter-PSSesion -ComputerName 172.25.56.3 -Credential ( Get-Credential )
Enter-PSSesion -ComputerName 172.25.56.4 -Credential ( Get-Credential )
```

Ahora crearemos el usuario de forma remota, hay que conectarse en ambos Cores

Guardamos la contraseña deseada en una variable

```powershell
$Password = Read-Host -AsSecureString
```

Y creamos el usuario

```powershell
New-LocalUser "HDSM" -Password $Password -FullName "Hugo Dos Santos" -Description "Usuario para uso personal"
```

Lo añadimos al grupo de administradores

```powershell
Add-LocalGroupMember -Group "Administradores" -Member "HDSM"
```

Creamos el certificado en los servidores

```powershell
New-SelfSignedCertificate -DnsName "172.25.56.4" -CertStoreLocation Cert:\LocalMachine\My -KeyLength 2048
```

Creamos el Listener de WinRM para HTTPS

```powershell
New-Item -Path WSMan:\localhost\Listener -Transport HTTPS -Address * -CertificateThumbPrint 29EE1FC6BED7ED050AE41E4F446D78F0C18A69BA
```

El firewall ya estaba desactivado pero para crear la regla sería:

```powershell
netsh advfirewall firewall add rule name="WinRM HTTPS" protocol=TCP dir=in localport=5986 action=allow
```

Exportamos el certificado a un archivo

```powershell
Export-Certificate -Cert Cert:\LocalMachine\My\29EE1FC6BED7ED050AE41E4F446D78F0C18A69BA -FilePath C:\cert.cer
```

Creamos la carpeta compartida

```powershell
New-Item -Path "C:\CarpetaCert" -ItemType Directory
New-SmbShare -Name "CarpetaCert" -Path "C:\CarpetaCert" -FullAccess "HDSM-CORE-2022\Administrador"
```

Copiamos el certificado a la carpeta compartida y lo copiamos del servidor al cliente

```powershell
Copy-Item -Path "\\172.25.56.4\CarpetaCert\cert.cer" -Destination "C:\"
dir


    Directorio: C:\


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       15/09/2018      9:19                PerfLogs
d-r---       21/11/2024      9:56                Program Files
d-----       21/11/2024      9:44                Program Files (x86)
d-r---       21/11/2024      9:44                Users
d-----       21/11/2024     10:03                Windows
-a----       17/12/2024      9:15            802 cert.cer
```

Importamos el Certificado

```powershell
Import-Certificate -FilePath "C:\cert.cer" -CertStoreLocation Cert:\LocalMachine\Root\


   PSParentPath: Microsoft.PowerShell.Security\Certificate::LocalMachine\Root

Thumbprint                                Subject
----------                                -------
29EE1FC6BED7ED050AE41E4F446D78F0C18A69BA  CN=172.25.56.4
```

Ahora nos intentamos conectar de nuevo pero forzando la conexión HTTPS con -UseSSL

```powershell
PS C:\Users\Administrador> Enter-PSSession -ComputerName 172.25.56.4 -Credential ( Get-Credential ) -UseSSL

cmdlet Get-Credential en la posición 1 de la canalización de comandos
Proporcione valores para los parámetros siguientes:
Credential
[172.25.56.4]: PS C:\Users\Administrador\Documents>
```

[Volver](../../index.md)
