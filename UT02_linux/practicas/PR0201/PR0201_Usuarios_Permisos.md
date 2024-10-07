# Obtención de la MV

Usaremos la máquina que nos da Ubuntu

```
vagrant box add generic/ubuntu2204
```
Y realizamos el vagrant init

```
vagrant init --minimal generic/ubuntu2204
```
E iniciamos la máquina y nos conectamos con

```
vagrant ssh
```

# 1. Permisos de usuarios

## 1.

```bash

    vagrant@ubuntu2204:~$ cd /home/vagrant/
    
    vagrant@ubuntu2204:~$ mkdir pr0201

    vagrant@ubuntu2204:~$ mkdir pr0201/dir1

    vagrant@ubuntu2204:~$ mkdir pr0201/dir2

    vagrant@ubuntu2204:~$ ls -l pr0201/
    total 8

    drwxrwxr-x 2 vagrant vagrant 4096 Oct  1 06:50 dir1

```
Los permisos indican que el usuario, y el grupo tienen permisos de lectura, escritura y ejecución y otros solo tienen el de ejecución y lectura
## 2.

```bash
    vagrant@ubuntu2204:~$ chmod a-w pr0201/dir2/
    vagrant@ubuntu2204:~$ ls -l pr0201/
    total 8
    drwxrwxr-x 2 vagrant vagrant 4096 Oct  1 06:50 dir1
    dr-xr-xr-x 2 vagrant vagrant 4096 Oct  1 06:50 dir2
```

## 3.

```bash
    vagrant@ubuntu2204:~$ chmod 551 pr0201/dir2/
    
```

## 4.

```bash
    vagrant@ubuntu2204:~$ ls -l pr0201/
    total 8
    drwxrwxr-x 2 vagrant vagrant 4096 Oct  1 06:50 dir1
    dr-xr-x--x 2 vagrant vagrant 4096 Oct  1 07:08 dir2
```

## 5.

```bash
    vagrant@ubuntu2204:~$ mkdir pr0201/dir2/dir21
    mkdir: cannot create directory ‘pr0201/dir2/dir21’: Permission denied
```

## 6.

```bash
    vagrant@ubuntu2204:~$ chmod u+w pr0201/dir2/
    vagrant@ubuntu2204:~$ ls -l pr0201/
    total 8
    drwxrwxr-x 2 vagrant vagrant 4096 Oct  1 06:50 dir1
    drwxr-x--x 2 vagrant vagrant 4096 Oct  1 07:08 dir2
    vagrant@ubuntu2204:~$ mkdir pr0201/dir2/dir21
    vagrant@ubuntu2204:~$ ls pr0201/dir2/
    dir21
```

# 2.Notación octal y simbólica

## 1. Simbólica

rwxrwxr-x :

```bash
    vagrant@ubuntu2204:~$ chmod g+w file
    vagrant@ubuntu2204:~$ chmod a+x file
    vagrant@ubuntu2204:~$ ls -l file
    -rwxrwxr-x 1 vagrant vagrant 0 Oct  1 07:16 file
```

rwxr--r-- :

```bash
    vagrant@ubuntu2204:~$ chmod a-x file
    vagrant@ubuntu2204:~$ chmod u+x file
    vagrant@ubuntu2204:~$ chmod g-w file
    vagrant@ubuntu2204:~$ ls -l file
    -rwxr--r-- 1 vagrant vagrant 0 Oct  1 07:16 file
```

r--r----- :

```bash
    vagrant@ubuntu2204:~$ chmod u-w,u-x,o-r file
    vagrant@ubuntu2204:~$ ls -l file
    -r--r----- 1 vagrant vagrant 0 Oct  1 07:16 file
```

(He aprendido en hacerlo en una linea)

rwxr-xr-x :

```bash
    vagrant@ubuntu2204:~$ chmod a+x,u+w,o+r file
    vagrant@ubuntu2204:~$ ls -l file
    -rwxr-xr-x 1 vagrant vagrant 0 Oct  1 07:16 file
```

r-x--x--x :

```bash
    vagrant@ubuntu2204:~$ chmod a-w,a+x,a-r,u+r file
    vagrant@ubuntu2204:~$ ls -l file
    -r-x--x--x 1 vagrant vagrant 0 Oct  1 07:16 file
```

-w-r----x :

```bash
    vagrant@ubuntu2204:~$ chmod a-w,a-x,a-r,u+w,g+r,o+x file
    vagrant@ubuntu2204:~$ ls -l file
    --w-r----x 1 vagrant vagrant 0 Oct  1 07:16 file
```

-----xrwx :

```bash
    vagrant@ubuntu2204:~$ chmod u-w,g-r,g+x,o+r,o+w file
    vagrant@ubuntu2204:~$ ls -l file
    ------xrwx 1 vagrant vagrant 0 Oct  1 07:16 file
    vagrant@ubuntu2204:~$
```

r---w---x :

```bash
    vagrant@ubuntu2204:~$ chmod o-r,o-w,g-x,u+r,g+w,o+x file
    vagrant@ubuntu2204:~$ ls -l file
    -r---w---x 1 vagrant vagrant 0 Oct  1 07:16 file
    vagrant@ubuntu2204:~$
```

-w------- :

```bash
    vagrant@ubuntu2204:~$ chmod o-x,g-w,u-r,u+w file
    vagrant@ubuntu2204:~$ ls -l file
    --w------- 1 vagrant vagrant 0 Oct  1 07:16 file
    vagrant@ubuntu2204:~$ 
```

rw-r----- :

```bash
    vagrant@ubuntu2204:~$ chmod u+rg+r file
    vagrant@ubuntu2204:~$ ls -l file
    -rw-r----- 1 vagrant vagrant 0 Oct  1 07:16 file
```

rwx--x--x :

```bash
    vagrant@ubuntu2204:~$ chmod g-r,a+x file
    vagrant@ubuntu2204:~$ ls -l file
    -rwx--x--x 1 vagrant vagrant 0 Oct  1 07:16 file
```

## 2.Octal

rwxrwxrwx :

```bash
    vagrant@ubuntu2204:~$ chmod 777 file
    vagrant@ubuntu2204:~$ ls -l file 
    -rwxrwxrwx 1 vagrant vagrant 0 Oct  1 07:16 file
```

--x--x--x :

```bash
    vagrant@ubuntu2204:~$ chmod 111 file
    vagrant@ubuntu2204:~$ ls -l file
    ---x--x--x 1 vagrant vagrant 0 Oct  1 07:16 file
```

r---w---x :

```bash
    vagrant@ubuntu2204:~$ chmod 421 file
    vagrant@ubuntu2204:~$ ls -l file
    -r---w---x 1 vagrant vagrant 0 Oct  1 07:16 file
```

-w------- :

```bash
    vagrant@ubuntu2204:~$ chmod 200 file
    vagrant@ubuntu2204:~$ ls -l file
    --w------- 1 vagrant vagrant 0 Oct  1 07:16 file
```

rw-r----- :

```bash
    vagrant@ubuntu2204:~$ chmod 640 file
    vagrant@ubuntu2204:~$ ls -l file
    -rw-r----- 1 vagrant vagrant 0 Oct  1 07:16 file
```

rwx--x--x :

```bash
    vagrant@ubuntu2204:~$ chmod 711 file
    vagrant@ubuntu2204:~$ ls -l file
    -rwx--x--x 1 vagrant vagrant 0 Oct  1 07:16 file
```

rwxr-xr-x :

```bash
    vagrant@ubuntu2204:~$ chmod 755 file
    vagrant@ubuntu2204:~$ ls -l file
    -rwxr-xr-x 1 vagrant vagrant 0 Oct  1 07:16 file
```

r-x--x--x :

```bash
    vagrant@ubuntu2204:~$ chmod 511 file
    vagrant@ubuntu2204:~$ ls -l file
    -r-x--x--x 1 vagrant vagrant 0 Oct  1 07:16 file
```

-w-r----x :

```bash
    vagrant@ubuntu2204:~$ chmod 241 file
    vagrant@ubuntu2204:~$ ls -l file
    --w-r----x 1 vagrant vagrant 0 Oct  1 07:16 file
```

-----xrwx :

```bash
    vagrant@ubuntu2204:~$ chmod 017 file
    vagrant@ubuntu2204:~$ ls -l file
    ------xrwx 1 vagrant vagrant 0 Oct  1 07:16 file
```

# 3. El bit setgid

## 1.

Creamos el grupo y los usuarios y metemos a los usuarios en el grupo

```bash
vagrant@ubuntu2204:~$ sudo groupadd asir
vagrant@ubuntu2204:~$ sudo useradd -m -G asir hdsm1
vagrant@ubuntu2204:~$ sudo useradd -m -G asir hdsm2
```

## 2.

En la carpeta  creamos la carpeta /compartido

```bash
vagrant@ubuntu2204:/$ sudo mkdir compartido
vagrant@ubuntu2204:/$ sudo chown root:asir compartido/
vagrant@ubuntu2204:/$ ls -l
total 2097224
2 root asir       4096 Oct  1 11:02 compartido
```

## 3.

Y le asignamos los permisos deseados

```bash
vagrant@ubuntu2204:/$ sudo chmod u+rwx,g+rwx,o-rwx compartido/
vagrant@ubuntu2204:/$ ls -ls
drwxrwx---   2 root asir       4096 Oct  1 11:02 compartido
```

## 4.

Establecemos el bit SETGID

```bash
vagrant@ubuntu2204:/$ sudo chmod g+s compartido/
vagrant@ubuntu2204:/$ ls -ld compartido/
drwxrws--- 2 root asir 4096 Oct  1 11:02 compartido/
```

La s en los permisos significa que está activo

## 5.

```bash
vagrant@ubuntu2204:~$ sudo su - hdsm1
$ whoami
hdsm1
$ touch fichero1
$ echo "Texto aleatorio en el fichero1 puesto por el usuario hdsm1" > fichero1               
$ cat fichero1
Texto aleatorio en el fichero1 puesto por el usuario hdsm1
$ ls -l fichero1
-rw-rw-r-- 1 hdsm1 asir 59 Oct  1 11:44 fichero1
```

## 6.

```bash
$ su - hdsm2
Password: 
$ whoami
hdsm2
$ cd /
$ cd compartido
$ cat fichero1
Texto aleatorio en el fichero1 puesto por el usuario hdsm1
# Puedo acceder al contenido
$ echo "Texto escrito por hdsm2" >> fichero1
$ cat fichero1
Texto aleatorio en el fichero1 puesto por el usuario hdsm1
Texto escrito por hdsm2
# Y también puedo cambiarlo
```

## 7.

### ¿Qué ventajas tiene usar el bit setgid en entornos colaborativos?

Tiene ventajas para poder acceder y modificar ficheros y directorios desde cualquier usuario en el grupo

### ¿Qué sucede si no se aplica el bit setgid en un entorno colaborativo?

Que los ficheros y directorios creados por un usuario solo serían modificables por ese usuario y no por el grupo

## 8.

```bash
vagrant@ubuntu2204:/$ sudo rm -rf compartido/
vagrant@ubuntu2204:/$ sudo userdel -r hdsm1
userdel: hdsm1 mail spool (/var/mail/hdsm1) not found
vagrant@ubuntu2204:/$ sudo userdel -r hdsm2
userdel: hdsm2 mail spool (/var/mail/hdsm2) not found
vagrant@ubuntu2204:/$ sudo groupdel asir
# Y comprobamos que no exista ninguno de los usuarios
vagrant@ubuntu2204:/$ cat /etc/passwd | grep hdsm1tu2204:/$ cat /etc/passwd | grep hdsm2
vagrant@ubuntu2204:/$ cat /etc/group | grep asir
vagrant@ubuntu2204:/$ ls / | grep compartido
vagrant@ubuntu2204:/$ 
```

# 4. Sticky bit

## 1.

```bash
vagrant@ubuntu2204:~$ cd /
vagrant@ubuntu2204:/$ mkdir compartido
vagrant@ubuntu2204:/$ sudo mkdir compartido
vagrant@ubuntu2204:/$ sudo chmod 777 compartido/
vagrant@ubuntu2204:/$ ls -l
total 2097224
lrwxrwxrwx   1 root root          7 Aug 10  2023 bin -> usr/bin
drwxr-xr-x   4 root root       4096 Jan 11  2024 boot
drwxrwxrwx   2 root root       4096 Oct  2 11:02 compartido
```

## 2.

```bash
vagrant@ubuntu2204:/$ sudo useradd -m hdsm1
vagrant@ubuntu2204:/$ sudo useradd -m hdsm2
vagrant@ubuntu2204:~$ sudo passwd hdsm1
New password: 
Retype new password:
passwd: password updated successfully
vagrant@ubuntu2204:~$ sudo passwd hdsm2
New password: 
Retype new password:
passwd: password updated successfully
```

## 3.

```bash
# Creación del fichero

vagrant@ubuntu2204:~$ su - hdsm1
Password: 
$ whoami
hdsm1
$ cd /
$ cd compartido/
$ touch ficherohdsm1
$ ls
ficherohdsm1
$

# Borrado del fichero

$ su - hdsm2
Password: 
$ whoami
hdsm2
$ cd /
$ cd compartido/
$ rm -f ficherohdsm1
$ ls
$
```

## 4.

```bash
vagrant@ubuntu2204:/$ sudo chmod +t compartido/
vagrant@ubuntu2204:/$ ls -ld compartido/
drwxrwxrwt 2 root root 4096 Oct  3 07:38 compartido/
vagrant@ubuntu2204:/$
# La t de los permisos significa que el sticky bit está activado
```

## 5.

```bash
# Creación del fichero
vagrant@ubuntu2204:/$ su - hdsm1
Password: 
$ whoami
hdsm1
$ cd / 
$ cd compartido/
 touch ficherohdsm1
$ ls
ficherohdsm1

# Borrado del fichero

vagrant@ubuntu2204:/$ su - hdsm2
Password: 
$ cd/
$ cd compartido/
$ rm ficherohdsm1
rm: remove write-protected regular empty file 'ficherohdsm1'? y
rm: cannot remove 'ficherohdsm1': Operation not permitted
$ ls -l
total 0
-rw-rw-r-- 1 hdsm1 hdsm1 0 Oct  3 07:57 ficherohdsm1
```

No nos deja eliminarlo por el sticky bit

## 6.

### ¿Qué efecto tiene el sticky bit en un directorio?

El sticky bit en un directorio impide que los usuarios que no son dueños de un archivo lo eliminen o renombren, aunque tengan permisos de escritura en el directorio. Solo el propietario del archivo, el propietario del directorio o el usuario root pueden eliminar o modificar los archivos en ese directorio.

### Si tienes habilitado el sticky bit, ¿cómo tendrías que hacer para eliminar un fichero dentro del directorio?

Si el sticky bit está habilitado en un directorio, solo podrías eliminar un fichero dentro del mismo si cumples con una de estas condiciones:

- Eres el propietario del archivo.
- Eres el propietario del directorio.
- Eres el usuario root.



[Volver](../../index.md)