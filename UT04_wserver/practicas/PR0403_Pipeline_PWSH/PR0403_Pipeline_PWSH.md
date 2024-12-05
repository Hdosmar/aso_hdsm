# 1. El comando Get-Date muestra la fecha y hora actual. Muestra por pantalla únicamente el año en que estamos.

```powershell
PS C:\WINDOWS\system32> Get-Date -Format yyyy
2024

PS C:\WINDOWS\system32> 
```

# 2. Uno de los requisitos de Windows 11 es que es procesador tenga TPM habilitado. Powershell dispone del comando Get-TPM que nos muestra información sobre este módulo. Muestra por pantalla, en formato tabla, las propiedades TpmPresent, TpmReady, TpmEnabled y TpmActivated.

```powershell
PS C:\WINDOWS\system32> Get-Tpm | Select-Object TpmPresent, TpmReady, TpmEnabled, TpmActivated

TpmPresent TpmReady TpmEnabled TpmActivated
---------- -------- ---------- ------------
      True     True       True         True



PS C:\WINDOWS\system32> 
```

# 3. Muestra por pantalla el número de ficheros y directorios que hay en ese directorio.

```powershell
PS C:\WINDOWS\system32> (Get-ChildItem C:\Windows\System32).Count
4854

PS C:\WINDOWS\system32> 
```

# 4. Los objetos devueltos por el comando anterior tienen una propiedad denominada Extension, que indica la extensión del archivo. Calcula el número de ficheros en el directorio que tienen la extensión .dll.

```powershell
PS C:\WINDOWS\system32> Get-ChildItem C:\Windows\System32 | Where {$_.Extension -like ".dll"}


    Directorio: C:\Windows\System32


Mode                 LastWriteTime         Length Name                                                                                                                  
----                 -------------         ------ ----                                                                                                                  
-a----        08/10/2024     14:15          25960 07409496-a423-4a3e-b620-2cfb01a9318d_HyperV-ComputeNetwork.dll                                                        
-a----        07/05/2022      7:19          25968 0ae3b998-9a38-4b72-a4c4-06849441518d_Servicing-Stack.dll                                                              
-a----        07/05/2022      7:20          25952 4545ffe2-0dc4-4df4-9d02-299ef204635e_hvsocket.dll                                                                     
-a----        07/05/2022      7:19          25952 69fe178f-26e7-43a9-aa7d-2b616b672dde_eventlogservice.dll                                                              
-a----        22/12/2023     13:30          25968 6bea57fb-8dfb-4177-9ae8-42e8b3529933_RuntimeDeviceInstall.dll                                                         
-a----        23/10/2024     11:20         442368 aadauthhelper.dll                                                                                                     
-a----        23/10/2024     11:20         929792 aadcloudap.dll                                                                                                        
-a----        17/09/2024      9:35          94208 aadjcsp.dll                                                                                                           
-a----        23/10/2024     11:20        1481728 aadtb.dll                                                                                                             
```

# 5. Muestra los ficheros del directorio con extensión .exe que tengan un tamaño superior a 50000 bytes.

```powershell
PS C:\WINDOWS\system32> Get-ChildItem C:\Windows\System32 | Where {$_.Extension -like ".exe"} | Where {$_.Length -gt 5KB}


    Directorio: C:\Windows\System32


Mode                 LastWriteTime         Length Name                                                                                                                  
----                 -------------         ------ ----                                                                                                                  
-a----        22/12/2023     13:30          36864 agentactivationruntimestarter.exe                                                                                     
-a----        17/09/2024      9:36        1175552 AgentService.exe                                                                                                      
-a----        23/10/2024     11:21         311296 AggregatorHost.exe                                                                                                    
-a----        23/10/2024     11:21        3249776 aitstatic.exe                                                                                                         
-a----        07/05/2022      7:19         110592 alg.exe                                                                                                               
-a----        22/08/2024      0:54        2921664 amd-smi.exe                                                                                                           
-a----        13/06/2023      8:41         600048 amdfendrsr.exe                                                                                                        
-a----        22/08/2024      0:53         471336 amdlogum.exe                                                                                                          
-a----        17/09/2024      9:35         143360 AppHostRegistrationVerifier.exe                                                                                       
-a----        23/10/2024     11:21          77824 appidcertstorecheck.exe                                                                                               
-a----        17/09/2024      9:35         155648 appidpolicyconverter.exe                                                                                              
-a----        23/10/2024     11:21          45056 appidtel.exe                                                                                                          
```

# 6. Muestra los ficheros de este directorio que tengan extensión .dll, ordenados por fecha de creación y mostrando únicamente las propiedades de fecha de creación (CreationTime), último acceso (LastAccessTime) y nombre (Name).

```powershell
PS C:\WINDOWS\system32> Get-ChildItem C:\Windows\System32 | Where {$_.Extension -like ".dll"} | Sort-Object -Property CreationTime | Select-Object CreationTime, LastAccessTime, Name

CreationTime        LastAccessTime      Name                                                                   
------------        --------------      ----                                                                   
01/02/2002 18:02:02 05/12/2024 8:37:37  vcruntime140_1.dll                                                     
01/02/2002 18:02:02 05/12/2024 9:03:16  concrt140.dll                                                          
01/02/2002 18:02:02 05/11/2024 8:45:09  msvcr100.dll                                                           
01/02/2002 18:02:02 18/11/2024 9:31:01  msvcp140_codecvt_ids.dll                                               
01/02/2002 18:02:02 03/12/2024 8:40:33  msvcp140_atomic_wait.dll                                               
01/02/2002 18:02:02 18/11/2024 9:31:01  msvcp140_2.dll                                                         
01/02/2002 18:02:02 28/11/2024 8:40:54  msvcp140_1.dll
```

# 7. Muestra el tamaño (Length) y nombre completo (FullName) de todos los ficheros del directorio ordenados por tamaño en sentido descendente.

```powershell
PS C:\WINDOWS\system32> Get-ChildItem C:\Windows\System32 | Where {$_.Extension -like ".dll"} | Sort-Object -Property Length -Descending | Select-Object Length, FullName

   Length FullName                                                                                   
   ------ --------                                                                                   
110283072 C:\Windows\System32\amd_comgr_2.dll                                                        
105432768 C:\Windows\System32\amd_comgr.dll                                                          
 27983960 C:\Windows\System32\mfxplugin64_hw.dll                                                     
 27082752 C:\Windows\System32\edgehtml.dll                                                           
 25260032 C:\Windows\System32\Hydrogen.dll                                                           
 23150592 C:\Windows\System32\mshtml.dll
```

# 8. Muestra el tamaño y nombre completo de todos los ficheros del directorio que tengan un tamaño superior a 10MB (10000000 bytes) ordenados por tamaño.

```powershell
PS C:\WINDOWS\system32> Get-ChildItem C:\Windows\System32 | Where {$_.Length -gt 10MB} | Select-Object Length, FullName

   Length FullName                               
   ------ --------                               
 21762480 C:\Windows\System32\amdhip64.dll       
 20438320 C:\Windows\System32\amdhip64_6.dll     
113337584 C:\Windows\System32\amdxc64.so         
105432768 C:\Windows\System32\amd_comgr.dll      
110283072 C:\Windows\System32\amd_comgr_2.dll    
 27082752 C:\Windows\System32\edgehtml.dll       
 19492864 C:\Windows\System32\HologramWorld.dll  
 25260032 C:\Windows\System32\Hydrogen.dll       
 27983960 C:\Windows\System32\mfxplugin64_hw.dll 
202035632 C:\Windows\System32\MRT.exe            
 23150592 C:\Windows\System32\mshtml.dll         
 11212272 C:\Windows\System32\ntkrla57.exe       
 12060152 C:\Windows\System32\ntoskrnl.exe       
 50312608 C:\Windows\System32\OneDriveSetup.exe  
 10514432 C:\Windows\System32\twinui.pcshell.dll 
 15578616 C:\Windows\System32\vmfirmwarehcl.dll  
 14829024 C:\Windows\System32\vmms.exe           
 19186440 C:\Windows\System32\Windows.UI.Xaml.dll
 11661312 C:\Windows\System32\wmp.dll            



PS C:\WINDOWS\system32> 
```

# 9. Muestra el tamaño y nombre completo de todos los ficheros del directorio que tengan un tamaño superior a 10MB y extensión .exe ordenados por tamaño.

```powershell
PS C:\WINDOWS\system32> Get-ChildItem C:\Windows\System32 | Where {$_.Length -gt 10MB} | Where {$_.Extension -like ".exe"} | Select-Object Length, FullName

   Length FullName                             
   ------ --------                             
202035632 C:\Windows\System32\MRT.exe          
 11212272 C:\Windows\System32\ntkrla57.exe     
 12060152 C:\Windows\System32\ntoskrnl.exe     
 50312608 C:\Windows\System32\OneDriveSetup.exe
 14829024 C:\Windows\System32\vmms.exe         



PS C:\WINDOWS\system32> 
```

# 10. Muestra todos los procesos que tienen el estado Responding puesto a False, es decir, todos los procesos del sistema que se hayan colgado.

```powershell
PS C:\WINDOWS\system32> Get-Process | Where-Object {$_.Responding -eq $false}

Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName                                                                                                   
-------  ------    -----      -----     ------     --  -- -----------                                                                                                   
   2174      74    89984       4080       0,34  16664   1 SystemSettings                                                                                                



PS C:\WINDOWS\system32> 
```

# 11. Muestra todos los ficheros de C:\Windows que hayan sido creados con fecha posterior al 15 de octubre de este año.

```powershell
PS C:\WINDOWS\system32>> Get-ChildItem C:\Windows -File | Where-Object {$_.CreationTime -gt '2024-10-15'}



    Directorio: C:\Windows


Mode                 LastWriteTime         Length Name                                                                                                                  
----                 -------------         ------ ----                                                                                                                  
-a----        13/11/2024     10:23         122880 bfsvc.exe                                                                                                             
-a----        23/10/2024     11:20        5550800 explorer.exe                                                                                                          
-a----        23/10/2024     11:21        1089536 HelpPane.exe                                                                                                          
-a----        22/10/2024     13:11     1461960189 MEMORY.DMP                                                                                                            
-a----        23/10/2024     11:21         598016 regedit.exe                                                                                                           
-a----        23/10/2024     11:20         192512 splwow64.exe                                                                                                          



PS C:\WINDOWS\system32>> 
```

[Volver](../../index.md)