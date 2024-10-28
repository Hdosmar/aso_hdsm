# PR0204: Programación de tareas con cron

Usaremos la máquina genérica de Ubuntu

```ruby
    vagrant init --minimal ubuntu/generic2204
    vagrant up
    vagrant ssh
```

## ¿Qué orden pondrías en crontab en los siguientes casos?


### La tarea se ejecuta cada hora

```bash
0 * * * * # comando

```

### La tarea se ejecuta los domingos cada 3 horas

```bash
0 */3 * * 0 # comando

```

### La tarea se ejecuta a las 12 de la mañana los días pares del mes.

```bash
0 12 */2 * * # comando
```

### La tarea se ejecuta el primer día de cada mes a las 8 de la mañana y a las 8 de la  tarde.
 
```bash
0 8,20 1 * * # comando
```

### La tarea se ejecuta cada media hora de lunes a viernes.

```bash
*/30 * * * 1-5 # comando
```

### La tarea se ejecuta cada cuarto de hora, entre las 3 y las 8, de lunes a viernes, durante todo el mes de agosto

```bash
*/15 3-8 * 8 1-5 # comando
```

### La tarea se ejecuta cada 90 minutos

```bash
0 0-21/3 * * * # comando
30 1-22/3 * * * # comando
```

## ¿Cómo compruebas si el servicio cron se está ejecutando?

Si al hacer un **sudo systemctl status {servicio}** te pone en **status (running)** significa que se está ejecutando.

```bash
vagrant@ubuntu2204:~$ sudo systemctl status cron
● cron.service - Regular background program processing daemon
     Loaded: loaded (/lib/systemd/system/cron.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-10-17 06:55:17 UTC; 22min ago
       Docs: man:cron(8)
   Main PID: 662 (cron)
      Tasks: 1 (limit: 2220)
     Memory: 12.6M
        CPU: 1.561s
     CGroup: /system.slice/cron.service
             └─662 /usr/sbin/cron -f -P

Oct 17 06:55:18 ubuntu2204.localdomain CRON[690]: pam_unix(cron:session): session closed for user root
Oct 17 06:55:22 ubuntu2204.localdomain CRON[689]: pam_unix(cron:session): session closed for user root
Oct 17 07:05:01 ubuntu2204.localdomain CRON[3054]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Oct 17 07:05:01 ubuntu2204.localdomain CRON[3055]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
Oct 17 07:05:01 ubuntu2204.localdomain CRON[3054]: pam_unix(cron:session): session closed for user root
Oct 17 07:15:01 ubuntu2204.localdomain CRON[3625]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Oct 17 07:15:01 ubuntu2204.localdomain CRON[3626]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
Oct 17 07:15:01 ubuntu2204.localdomain CRON[3625]: pam_unix(cron:session): session closed for user root
Oct 17 07:17:01 ubuntu2204.localdomain CRON[3630]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Oct 17 07:17:01 ubuntu2204.localdomain CRON[3630]: pam_unix(cron:session): session closed for user root
```

## ¿Cuál es el efecto de la siguiente línea crontab?

```bash
    */15 1,2,3 * * * who > /tmp/test
```

Cada 15 minutos durante las 1, 2, y 3 de la mañana mira los usuarios conectados y los redirige a ese archivo sobrescribiendo el contenido

## Indica la ruta del fichero crontab del sistema

```bash
/etc/crontab
```

## ¿Qué ficheros controlan los usuarios que pueden utilizar el crontab?

El **/etc/crontab.allow** y **/etc/crontab.deny**

## Excepcionalmente se debe iniciar una tarea llamada script.sh todos los lunes a las 07:30h antes de entrar en clase ¿Cómo lo harías?

En el fichero /etc/crontab

```bash
sudo nano /etc/crontab
```

Añadimos una línea que sea:

```bash
30 7 * * 1 script.sh
```

## Se ha cancelado la tarea. ¿Cómo listar y luego, suprimir la tarea?

Para listarlo:

```bash
vagrant@ubuntu2204:~$ crontab -l
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
vagrant@ubuntu2204:~$
```

Para suprimirlo:

```bash
crontab -e
```

Y borramos la tarea que queramos suprimir.

## Ejecuta el comando ps -ef para el usuario root cada 2 minutos y redirecciona el resultado a /tmp/ps_result sin sobrescribir los antiguos.

Editamos el archivo crontab y escribimos lo siguiente

```bash
crontab -e

*/2 * * * * ps -ef >> /tmp/ps_result

vagrant@ubuntu2204:~$ crontab -l
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
*/2 * * * * ps -ef >> /tmp/ps_result
vagrant@ubuntu2204:~$ 
```

## Espera unos minutos y comprueba el resultado en /tmp

```bash
vagrant@ubuntu2204:~$ cat /tmp/ps_result

# En la última línea veremos el ps -ef
vagrant     3729    3728  0 07:56 ?        00:00:00 ps -ef
vagrant@ubuntu2204:~$
```

## Crea el usuario asir2 y prohíbele utilizar el crontab.

```bash
vagrant@ubuntu2204:~$ sudo useradd asir2
vagrant@ubuntu2204:~$ sudo passwd asir2
New password: 
Retype new password:
passwd: password updated successfully
vagrant@ubuntu2204:~$ sudo nano /etc/cron.deny
# Dentro del archivo escribimos el nombre del usuario, en este caso "asir2"
```

## Verifica que el usuario asir2 realmente no puede utilizar crontab

```bash
vagrant@ubuntu2204:~$ su asir2
Password: 
$ whoami
asir2
$ crontab -e
You (asir2) are not allowed to use this program (crontab)
See crontab(1) for more information
$
```

## Programa crontab para que cada día a las 0:05 se eliminen todos los ficheros que se encuentran en el directorio /tmp.

```bash 
vagrant@ubuntu2204:~$ crontab -e
# Escribimos lo siguiente
5 0 * * * rm -rf /tmp/*
```

## Programa una tarea en el sistema que se lance de lunes a viernes a las 9 de la mañana durante los meses de verano (julio, agosto y septiembre) que escriba en un fichero la hora actual (comando date, aunque tienes que mirar la ayuda para elegir un formato comprensible) seguido del listado de usuarios que hay conectados en ese momento en el sistema (comando who)

```bash
vagrant@ubuntu2204:~$ crontab -e
# Introducimos esta línea
0 9 * 7,8,9 1-5 echo "$(date '+%Y-%m-%d %H:%M:%S')" >> log.txt && who >> log.txt
```

## El servicio cron se ayuda de una serie de ficheros y directorios que se encuentran en el directorio /etc. Explica la función de cada uno de los siguientes ficheros/directorios:

### cron.d:

Fichero de confgiuración del servicio

### cron.allow:

Contiene los usuarios que tienen el acceso permitido a crontab

### cron.deny:

Contiene los usuarios que no tienen acceso a crontab

### cron.daily:

Contiene las tareas que se ejecutan diariamente

### cron.hourly:

Contiene las tareas que se ejecutan cada hora

### cron.monthly:

Contiene las tareas que se ejecutan mensualente

[Volver](../../index.md)