# Define la ruta del archivo CSV
$csvPath = "C:\alumnos.csv"

# Define el dominio base
$dominio = "DC=educacion,DC=edu"

# Ruta base donde se crearán las carpetas personales en la red
$rutaBaseCarpetas = "\\dc-edu\alumnos$"

# Contraseña por defecto
$pswd = ConvertTo-SecureString "Villabalter1" -AsPlainText -Force

# Importa los datos del CSV
$alumnos = Import-Csv -Path $csvPath -Delimiter ","

# Función para convertir "Primero" → "1" y "Segundo" → "2"
function ConvertirCurso($curso) {
    switch ($curso) {
        "Primero" { return "1" }
        "Segundo" { return "2" }
        default { return $curso }
    }
}

# Procesa cada alumno
foreach ($alumno in $alumnos) {
    # Guarda nombre, apellido, ciclo y curso del alumno
    $nombre = $alumno.Nombre
    $apellido1 = $alumno."Primer Apellido"
    $apellido2 = $alumno."Segundo Apellido"
    $ciclo = $alumno.Ciclo
    $curso = ConvertirCurso $alumno.Curso  # Convierte "Primero" -> "1" y "Segundo" -> "2"

    # Normaliza caracteres quitando tildes o cualquier tipo de acento
    $username = ($nombre.Substring(0,1) + $apellido1 + $ciclo + $curso) -replace '\s','' -replace '[áéíóúÁÉÍÓÚ]','a'

    # Define la UO donde se creará el usuario
    $ou = "OU=$curso$ciclo,OU=$ciclo,OU=Alumnos,$dominio"

    # Define los grupos de seguridad
    $grupoGeneral = "Grupo_Alumnos"
    $grupoEspecifico = "$ciclo$curso"

    # Ruta de la carpeta personal
    $rutaCarpeta = "$rutaBaseCarpetas\$username"

    # Verifica si el usuario existe
    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        Write-Host "El usuario $username ya existe. Se omite la creacion."
    } else {
        # Crear el usuario en AD, le asigna el script de inicio de sesión, la ruta de red con la letra a la que se conecta y el nombre para iniciar sesión
        New-ADUser -SamAccountName $username `
                   -UserPrincipalName "$username@educacion.edu" `
                   -Name "$nombre $apellido1 $apellido2" `
                   -GivenName $nombre `
                   -Surname "$apellido1 $apellido2" `
                   -DisplayName "$nombre $apellido1 $apellido2" `
                   -Path $ou `
                   -HomeDirectory $rutaCarpeta `
                   -HomeDrive "H:" `
                   -AccountPassword $pswd `
                   -Enabled $true `
                   -ScriptPath "conecta.bat" `
                   -PasswordNeverExpires $true `
                   -PassThru

        Write-Host "Usuario $username creado en $ou con HomeDirectory $rutaCarpeta asignado a H:"

        # Añade el usuario a los grupos
        Add-ADGroupMember -Identity $grupoGeneral -Members $username
        Add-ADGroupMember -Identity $grupoEspecifico -Members $username

        Write-Host "Usuario $username añadido a los grupos: $grupoGeneral y $grupoEspecifico"
    }

    # Crear la carpeta personal en el servidor validando si existe o no
    if (-not (Test-Path $rutaCarpeta)) {
        New-Item -Path $rutaCarpeta -ItemType Directory | Out-Null
        Write-Host "Carpeta personal creada en: $rutaCarpeta"

        # Cambiamos los permisos para la carpeta personal de cada usuario
        $acl = Get-Acl $rutaCarpeta
        $permiso = New-Object System.Security.AccessControl.FileSystemAccessRule($username, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $acl.SetAccessRule($permiso)
        Set-Acl -Path $rutaCarpeta -AclObject $acl

        Write-Host "Permisos asignados a $username en su carpeta personal."
    } else {
        Write-Host "La carpeta personal ya existe para $username. No se ha creado nuevamente."
    }
}

Write-Host "Proceso finalizado."

# Conecta.bat tiene el siguiente contenido: net use h: \\192.168.1.220\alumnos$