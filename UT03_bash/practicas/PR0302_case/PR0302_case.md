# PR0302 Comando Case

## 1.

### Nota: Se podría validar la división para que no se divida entre 0 con un if si el $n2 es distinto de 0

```bash
#!/bin/bash

echo "Elija la entre las siguiente opciones"
echo "1) Suma"
echo "2) Resta"
echo "3) División"
echo "4) Multiplicación"
read opcion

echo "Introduzca el primer número"
read n1

echo "Introduzca el segundo número"
read n2

case $opcion in
        1)
                r=$(($n1 + $n2)) ;;
        2)
                r=$(($n1 - $n2)) ;;
        3)
                r=$(($n1 / $n2)) ;;
        4)
                r=$(($n1 * $n2)) ;;
esac

echo "El resultado de la operación es $r"

vagrant@ubuntu2204:~$ ./ej1.sh
Elija la entre las siguiente opciones
1) Suma
2) Resta
3) División
4) Multiplicación
2
Introduzca el primer número
10
Introduzca el segundo número
5
El resultado de la operación es 5
```

## 2.

```bash
#!/bin/bash

echo "Inserte la extensión (.pdf, .txt, .jpg)"
read a

case $a in
        .txt)
                echo "Archivo de texto." ;;
        .jpg|.jpeg|.png|.gif)
                echo "Archivo de imagen." ;;
        .pdf)
                echo "Documento PDF." ;;
        .doc|.docx)
                echo "Documento de Word." ;;
        .xls|.xlsx)
                echo "Hoja de cálculo de Excel." ;;
        .ppt|.pptx)
                echo "Presentación de PowerPoint." ;;
        .mp3|.wav)
                echo "Archivo de audio." ;;
        .mp4|.avi|.mkv)
                echo "Archivo de video." ;;
        *)
                 echo "Tipo de archivo desconocido." ;;
esac

vagrant@ubuntu2204:~$ ./ej5.sh
Inserte la extensión (.pdf, .txt, .jpg)
.jpg
Archivo de imagen.
vagrant@ubuntu2204:~$ ./ej5.sh
Inserte la extensión (.pdf, .txt, .jpg)
.pdf
Documento PDF.
vagrant@ubuntu2204:~$ ./ej5.sh
Inserte la extensión (.pdf, .txt, .jpg)
.mp3
Archivo de audio.
```



## 3.

```bash
#!/bin/bash

echo "Inserte el tipo de cambio"
echo "1) M a KM"
echo "2) KM a M"
echo "3) FT a M"
echo "4) M a FT"

read op
read -p "Ingrese el valor: " valor

case $op in
        1)
                echo "$valor metros = $(echo "$valor / 1000" | bc -l) kilómetros" ;;
        2)
                echo "$valor kilómetros = $(echo "$valor * 1000" | bc -l) metros" ;;
        3)
                echo "$valor pies = $(echo "$valor * 0.3048" | bc -l) metros" ;;
        4)
                echo "$valor metros = $(echo "$valor / 0.3048" | bc -l) pies" ;;
esac
vagrant@ubuntu2204:~$ ./ej3.sh
Inserte el tipo de cambio
1) M a KM
2) KM a M
3) FT a M
4) M a FT
2
Ingrese el valor: 2
2 kilómetros = 2000 metros
```


## 4.

```bash
#!/bin/bash

echo "Elija la opción que desee"
echo "1) Apagar"
echo "2) Reiniciar"
echo "3) Cerrar sesión"
read op

case $op in
        1)
                sudo shutdown now ;;
        2)
                sudo reboot ;;
        3)
                gnome-session-quit --logout --no-prompt ;;
esac
vagrant@ubuntu2204:~$ ./ej4.sh
Elija la opción que desee
1) Apagar
2) Reiniciar
3) Cerrar sesión
2
Connection to 127.0.0.1 closed by remote host.
```

## 5.

```bash
#!/bin/bash

echo "Inserte un número entre el 1 y el 7 y te devolveré el día"
read num

case $num in
        1)
                echo "El $num es Lunes" ;;
        2)
                echo "El $num es Martes" ;;
        3)
                echo "El $num es Miércoles" ;;
        4)
                echo "El $num es Jueves" ;;
        5)
                echo "El $num es Viernes" ;;
        6)
                echo "El $num es Sábado" ;;
        7)
                echo "El $num es Domingo" ;;
esac
vagrant@ubuntu2204:~$ ./ej3.sh
Inserte un número entre el 1 y el 7 y te devolveré el día
4
El 4 es Jueves
vagrant@ubuntu2204:~$
```

## 6.

```bash
#!/bin/bash

echo "Inserte una nota entera del 1 al 10"
read nota

case $nota in
        0|1|2|3|4)
                echo "El $nota es un suspenso" ;;
        5)
                echo "El $nota es un suficente" ;;
        6)
                echo "El $nota es un bien" ;;
        7|8)
                echo "El $nota es un notable" ;;
        9|10)
                echo "El $nota es un sobresaliente" ;;
esac

vagrant@ubuntu2204:~$ ./ej3.sh
Inserte una nota entera del 1 al 10
2
El 2 es un suspenso
vagrant@ubuntu2204:~$ ./ej3.sh
Inserte una nota entera del 1 al 10
5
El 5 es un suficente
vagrant@ubuntu2204:~$ ./ej3.sh
Inserte una nota entera del 1 al 10
6
El 6 es un bien
vagrant@ubuntu2204:~$ ./ej3.sh
Inserte una nota entera del 1 al 10
7        
El 7 es un notable
vagrant@ubuntu2204:~$ ./ej3.sh
Inserte una nota entera del 1 al 10
9
El 9 es un sobresaliente
```
## 7.

```bash
#!/bin/bash

read -p "Introduzca un número entero" num

case $num in
        0)
                echo "El número es 0" ;;
        -*)
                echo "El número $num es negativo" ;;
        *)
                echo "El número $num es positivo" ;;
esac
vagrant@ubuntu2204:~$ ./ej7.sh
Introduzca un número entero: -52
El número -52 es negativo
vagrant@ubuntu2204:~$ ./ej7.sh
Introduzca un número entero: 2
El número 2 es positivo
vagrant@ubuntu2204:~$ ./ej7.sh
Introduzca un número entero: 0
El número es 0
```

## 8.

```bash
#!/bin/bash

echo "Introduzca el nombre del servicio (ej. apache2 nginx): "
read serv

echo "¿Qué desea hacer con el servicio?"
echo "1) Pararlo"
echo "2) Reiniciarlo"
echo "3) Iniciarlo"
read op

case $op in
        1)
                sudo systemctl stop "$servicio" ;;
        2)
                sudo systemctl restart "$servicio" ;;
        3)
                sudo systemctl start "$servicio" ;;
esac

if [ $? -eq 0 ] ;
then
        echo "El script se ha ejecutado correctamente"
else
        echo "El script no se ha ejecutado correctamente"
fi
```

[Volver](../../index.md)