# PR0203: Configuración de SSH para varios usuarios

## 1. Config Vagrantfile

Configuramos el vagrantfile para que los demás se puedan conectar a ti, voy a usar la misma máquina que la PR0202 solo hay que cambiar los 2 vagrantfiles

```ruby
Vagrant.configure("2") do |config|
  # Configuración del Ubuntu Server
  config.vm.define "ubuntuserver" do |ubuntuserver|
    ubuntuserver.vm.box = "generic/ubuntu2204"
    ubuntuserver.vm.box = "hdsm_server"
    ubuntuserver.vm.network "public_network", ip: "172.16.0.56", netmask: "255.255.0.0"
  end
end
```

## 2. Creación de usuarios

Creamos los usuarios y les asignamos contraseña

```bash
vagrant@ubuntu2204:~$ sudo useradd -s /bin/bash hugo -m
vagrant@ubuntu2204:~$ sudo passwd hugo
New password: 
Retype new password: 
passwd: password updated successfully
vagrant@ubuntu2204:~$ sudo useradd -s /bin/bash alex -m
vagrant@ubuntu2204:~$ sudo passwd alex
New password: 
Retype new password:
passwd: password updated successfully
vagrant@ubuntu2204:~$ sudo useradd -s /bin/bash diego -m
vagrant@ubuntu2204:~$ sudo passwd diego
New password: 
Retype new password:
passwd: password updated successfully
vagrant@ubuntu2204:~$ sudo useradd -s /bin/bash david -m
vagrant@ubuntu2204:~$ sudo passwd david
New password: 
Retype new password:
passwd: password updated successfully

# Y también abrimos el puerto 22 para permitir la conexión SSH

vagrant@ubuntu2204:~$ sudo ufw allow 22/tcp
Rules updated
Rules updated (v6)
```

# Conexión a otros equipos

Ahora para conectarnos a otros equipos nos ponemos en su usuario y generamos la clave

```bash
vagrant@ubuntu2204:~$ su alex
Password: 
alex@ubuntu2204:/home/vagrant$ cd /home/alex/

alex@ubuntu2204:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/alex/.ssh/id_rsa): 
Created directory '/home/alex/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/alex/.ssh/id_rsa
Your public key has been saved in /home/alex/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:J7BNH2pEtniBYHfhzLVimktnH8hPl4rkuIGpBcGW218 alex@ubuntu2204.localdomain
The key's randomart image is:
+---[RSA 3072]----+
|    o...*..      |
| . o ..O + .     |
|  =   o @ o      |
| . +   % = . .   |
|  o . = E = o    |
|   . = X B +     |
|    + = o +      |
|   o   o         |
|  .   .          |
+----[SHA256]-----+
```

El servidor también tiene que generar su clave en tu usuarios para que se cree el directorio ssh en su equipo

Una vez generada hay que pasársela con el comando scp{ruta de tu clave} usuario@ipserver:{su directorio ssh de tu usuario}

```bash
hugo@ubuntu2204:/$ scp /home/hugo/.ssh/id_rsa.pub hugo@172.16.0.57:/home/hugo/.ssh/
The authenticity of host '172.16.0.57 (172.16.0.57)' can't be established.
ED25519 key fingerprint is SHA256:EnZf3d0kjYhfy0uGUoi4BptDgTe9VLE2qyX2Y9ScGPY.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '172.16.0.57' (ED25519) to the list of known hosts.
hugo@172.16.0.57's password: 
scp: /home/hugo/.ssh/: Is a directory
```
Una vez hecho esto te conectas por ssh poniendo el usuario@ipserver

```bash
hugo@ubuntu2204:/home/vagrant$ ssh hugo@172.16.0.57
hugo@ubuntu2204:~$ 
```

# Actuar de servidor

Las 2 únicas cosas que hay que hacer son:

1- Crear la clave de ssh con el usuario que quieras que se pueda conectar en el directorio home

```bash
vagrant@ubuntu2204:~$ su diego
Password: 
diego@ubuntu2204:/home/vagrant$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/diego/.ssh/id_rsa): 
Created directory '/home/diego/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/diego/.ssh/id_rsa
Your public key has been saved in /home/diego/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:DSoAmqHuHyUd+E72zIvlFIxvkSeevij7TXSD6qA8xSQ diego@ubuntu2204.localdomain
The key's randomart image is:
+---[RSA 3072]----+
|o                |
|o+  .            |
Your public key has been saved in /home/diego/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:DSoAmqHuHyUd+E72zIvlFIxvkSeevij7TXSD6qA8xSQ diego@ubuntu2204.localdomain
The key's randomart image is:
+---[RSA 3072]----+
|o                |
|o+  .            |
The key fingerprint is:
SHA256:DSoAmqHuHyUd+E72zIvlFIxvkSeevij7TXSD6qA8xSQ diego@ubuntu2204.localdomain
The key's randomart image is:
+---[RSA 3072]----+
|o                |
|o+  .            |
The key's randomart image is:
+---[RSA 3072]----+
|o                |
|o+  .            |
+---[RSA 3072]----+
|o                |
|o+  .            |
|o+  .            |
|+ .. .  .        |
|+ .. .  .        |
|.E oo +.oo       |
| .+..B.OS+.      |
|.E oo +.oo       |
| .+..B.OS+.      |
|.  o*.O B .      |
|.  o*.O B .      |
| ..o o %         |
|..o.+ @ .        |
| ..o o %         |
|..o.+ @ .        |
| o.o+= *.        |
+----[SHA256]-----+
+----[SHA256]-----+
```

2- Cuando te pasen la clave por scp tienes que copiar el archivo y pasarlo a authorized_keys

```bash
diego@ubuntu2204:~/.ssh$ cp id_rsa.pub authorized_keys
```

[Volver](../../index.md)