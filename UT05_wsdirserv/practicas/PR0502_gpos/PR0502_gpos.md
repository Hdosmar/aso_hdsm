## Creación de unidades organizativas

En el dominio Click Derecho -> Nuevo -> Unidad Organizativa, creamos Usuarios y Equipos, dentro de Usuarios creamos management y development

## Directiva 1

En el administrador de directivas de grupo en el panel de la izquierda nos dirigimos a Usuarios -> Management -> Click derecho -> Crear un GPO en este dominio y vincularlo aquí

Asignamos un nombre a la GPO y le damos Click Derecho -> Editar

Vamos a la siguiente directiva Configuración de usuario -> Directivas -> Plantillas administrativas -> Panel de Control -> Personalización -> Impedir cambiar el fondo de pantalla

Editamos esta directiva y la habilitamos

## Directiva 2

Creamos la GPO en development y buscamos la siguiente ruta Configuración de equipo -> Directivas -> Plantillas administrativas -> Componentes de Windows -> Windows Powershell -> Activar la ejecución de scripts y la habilitamos permitiendo todos los scripts

## Directiva 3

Creamos una nueva política en el dominio y nos dirigimos a Configuración de equipo -> Directivas -> Configuración de Windows -> Configuración de seguridad -> Windows Defender Firewall -> Perfil del dominio y activamos solo el perfil del dominio cambiando el estado a habilitado

Para excluirlo vamos a los Filtros WMI y la consulta que he usado es esta: **SELECT * FROM Win32_ComputerSystem WHERE Name != 'DEV-PC1'**

Ahora vamos a la GPO que queramos filtrar y abajo e

## Directiva 4

En el dominio creamos otra directiva mas

En esta ruta Configuración de equipo -> Directivas -> Plantillas administrativas -> Componentes de Windows -> Windows Update -> Configurar actualizaciones automáticas

Habilitamos la opción y le ponemos el horario en automático y lo actualizaremos los domingos

## Directiva 5

Modificaremos la GPO del ejercicio anterior

En la siguiente ruta Configuración de equipo -> Plantillas administrativas -> Sistema -> Acceso de almacenamiento extraíble

La opción de **Todas las clases de almacenamiento extraíble: denegar acceso** y habilitamos la opción para denegar el acceso a almacenamiento extraíble

## Directiva 6

Seguiremos modificando la misma GPO

En esta ruta Configuración de equipo -> Directivas -> Configuración de Windows -> Configuración de seguridad -> Directivas de cuenta -> Directiva de contraseñas -> Exigir historial de contraseñas

La activamos y le ponemos 10 contraseñas recientes

Haremos un filtro WMI a la GPO con la siguiente consulta **SELECT * FROM Win32_ComputerSystem WHERE NOT UserName = "HDSM-2019\\mgmt_director" AND NOT UserName = "HDSM-2019\\dvlp_directo"**

Y lo asignamos a la GPO

## Directiva 7

Hacemos en el dominio una GPO nueva

En la ruta Configuración de equipo -> Plantillas administrativas -> Sistema -> Administración de energía -> Especificar el tiempo de espera para la hibernación del sistema (con batería)

Y como está en segundos lo ponemos en 1800

Y hacemos el filtro y lo aplicamos a la GPO la consulta es esta: **SELECT * FROM Win32_Battery WHERE BatteryStatus > 0**


[Volver](../../index.md)