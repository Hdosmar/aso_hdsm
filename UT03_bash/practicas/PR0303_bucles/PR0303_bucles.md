# PR0303 Bucles condicionales

## 1.

```bash
#!/bin/bash

for i in {1..10}
do
echo $i
done
vagrant@ubuntu2204:~$ ./ej1.sh
1
2
3
4
5
6
7
8
9
10
```
## 2.

```bash
#!/bin/bash

resu=0

for i in {1..50}
do
        resu=$((resu + i))
done

echo "La suma es: $resu"
vagrant@ubuntu2204:~$ ./ej2.sh
La suma es: 1275
```

## 3.

```bash
#!/bin/bash

read -p "Introduzca un número: " num

for i in {1..10}
do
        sum=$((num * i))
        echo "$num por $i es igual a $sum"
done
vagrant@ubuntu2204:~$ ./ej3.sh
Introduzca un número: 23
23 por 1 es igual a 23
23 por 2 es igual a 46
23 por 3 es igual a 69
23 por 4 es igual a 92
23 por 5 es igual a 115
23 por 6 es igual a 138
23 por 7 es igual a 161
23 por 8 es igual a 184
23 por 9 es igual a 207
23 por 10 es igual a 230
```

## 4.

```bash
vagrant@ubuntu2204:~$ sudo cat ej4.sh 
#!/bin/bash

read -p "Introduce una palabra: " palabra

for letra in $(echo $palabra | fold -w1)
do
        echo "$letra"
done
vagrant@ubuntu2204:~$ ./ej4.sh
Introduce una palabra: hola
h
o
l
a
```

## 5.

```bash
#!/bin/bash

num=2

while [ $num -le 20  ]
do
        echo $num
        num=$((num + 2))
done
vagrant@ubuntu2204:~$ ./ej5.sh
2
4
6
8
10
12
14
16
18
20
```

## 6.

```bash
#!/bin/bash

read -p "Ingresa un número: " numero
suma=0

while [ $numero -gt 0 ]; do
    digito=$((numero % 10))
    suma=$((suma + digito))
    numero=$((numero / 10))
done

echo "La suma de los dígitos es: $suma"
vagrant@ubuntu2204:~$ ./ej6.sh
Ingresa un número: 4123
La suma de los dígitos es: 10
```

## 7.

```bash
#!/bin/bash

read -p "Introduzca un número: " num

until [ $num -eq 0 ]; do
        echo "$num"
        num=$(($num - 1))
done
vagrant@ubuntu2204:~$ ./ej7.sh
Introduzca un número: 10
10
9
8
7
6
5
4
3
2
1
```

## 8.

```bash
#!/bin/bash

directorio="/home/vagrant"

for archivo in "$directorio"/*; do
    if [[ $archivo == *.txt ]]; then
        echo "$archivo"
    fi
done
vagrant@ubuntu2204:~$ ./ej8.sh 
/home/vagrant/arch1.txt
/home/vagrant/arch2.txt
/home/vagrant/arch3.txt
```

## 9.

```bash
sudo cat ej9.sh 
#!/bin/bash

read -p "Ingresa un número: " numero

factorial=1

for (( i=1; i<=numero; i++ )); do
    factorial=$((factorial * i))
done

echo "El factorial de $numero es: $factorial"
vagrant@ubuntu2204:~$ ./ej9.sh 
Ingresa un número: 5
El factorial de 5 es: 120
```

## 10.

```bash
#!/bin/bash

passwd="1234contraseña"

until [[ $passwd == $intento ]]; do
        read -p "Inserte contraseña: " intento
        if [[ $passwd != $intento ]]; then
                echo "La contraseña es incorrecta"
        fi
done

echo "La contraseña es correcta"
vagrant@ubuntu2204:~$ ./ej10.sh
Inserte contraseña: 1239
La contraseña es incorrecta
Inserte contraseña: 1234contraseña
La contraseña es correcta
```

## 11.

```bash
#!/bin/bash

numcorr=1

while [[ $numcorr != $num ]]; do
        read -p "Intente adivinar el número: " num
        if [[ $numcorr != $num ]]
        then
                echo "El número es incorrecto"
        fi
done

echo "El número es correcto"
vagrant@ubuntu2204:~$ ./ej11.sh
Intente adivinar el número: 3
El número es incorrecto
Intente adivinar el número: 2
El número es incorrecto
Intente adivinar el número: 1
El número es correcto
```

## 12.

```bash
#!/bin/bash

read -p "Dame un número: " n

for (( i=1; i<=n; i++)); do
        date
done
vagrant@ubuntu2204:~$ ./ej12.sh 
Dame un número: 5
Sun Nov 10 04:16:43 PM UTC 2024
Sun Nov 10 04:16:43 PM UTC 2024
Sun Nov 10 04:16:43 PM UTC 2024
Sun Nov 10 04:16:43 PM UTC 2024
Sun Nov 10 04:16:43 PM UTC 2024
```

## 13.

```bash
#!/bin/bash

suma=0
contador=0

while true; do
    read -p "Ingresa un número (o escribe 'fin' para terminar): " entrada
    if [ "$entrada" == "fin" ]; then
        break
    fi
    suma=$((suma + entrada))
    contador=$((contador + 1))
done

if [ $contador -gt 0 ]; then
    echo "El promedio es: $((suma / contador))"
else
    echo "No se ingresaron números."
fi
vagrant@ubuntu2204:~$ ./ej13.sh
Ingresa un número (o escribe 'fin' para terminar): 3
Ingresa un número (o escribe 'fin' para terminar): 2
Ingresa un número (o escribe 'fin' para terminar): 5
Ingresa un número (o escribe 'fin' para terminar): 3
Ingresa un número (o escribe 'fin' para terminar): 5
Ingresa un número (o escribe 'fin' para terminar): 1
Ingresa un número (o escribe 'fin' para terminar): 2
Ingresa un número (o escribe 'fin' para terminar): fin
El promedio es: 3
```

## 14.

```bash
#!/bin/bash

read -p "Ingresa una frase: " frase

contador=0
for palabra in $frase; do
    contador=$((contador + 1))
done

echo "La frase tiene $contador palabras."
vagrant@ubuntu2204:~$ ./ej14.sh
Ingresa una frase: Hola esto es una prueba
La frase tiene 5 palabras.
```

## 15.

```bash
#!/bin/bash

numero_aleatorio=$((RANDOM % 100 + 1))
adivinanza=0

while [ "$adivinanza" -ne "$numero_aleatorio" ]; do
    read -p "Adivina el número entre 1 y 100: " adivinanza

    if [ "$adivinanza" -lt "$numero_aleatorio" ]; then
        echo "El número es mayor. Intenta de nuevo."
    elif [ "$adivinanza" -gt "$numero_aleatorio" ]; then
        echo "El número es menor. Intenta de nuevo."
    fi
done

echo "¡Felicidades! Has adivinado el número $numero_aleatorio."
vagrant@ubuntu2204:~$ ./ej15.sh
Adivina el número entre 1 y 100: 40
El número es mayor. Intenta de nuevo.
Adivina el número entre 1 y 100: 90
El número es menor. Intenta de nuevo.
Adivina el número entre 1 y 100: 60
El número es mayor. Intenta de nuevo.
Adivina el número entre 1 y 100: 70
El número es mayor. Intenta de nuevo.
Adivina el número entre 1 y 100: 80
El número es mayor. Intenta de nuevo.
Adivina el número entre 1 y 100: 85
El número es mayor. Intenta de nuevo.
Adivina el número entre 1 y 100: 89
El número es menor. Intenta de nuevo.
Adivina el número entre 1 y 100: 88
¡Felicidades! Has adivinado el número 88.
```

## 16.

```bash
#!/bin/bash

> directorios.txt

for dir in */; do
    echo "$dir" >> directorios.txt
done
vagrant@ubuntu2204:~$ sudo mkdir dir1
vagrant@ubuntu2204:~$ sudo mkdir dir2
vagrant@ubuntu2204:~$ sudo mkdir dir3
vagrant@ubuntu2204:~$ sudo mkdir dir4
vagrant@ubuntu2204:~$ ./ej16.sh
vagrant@ubuntu2204:~$ cat directorios.txt 
dir1/
dir2/
dir3/
dir4/
```

## 17.

```bash
#!/bin/bash

read -p "Dame un número: " num

for (( i=1; i<=num; i++ )); do
        sudo touch archivo$i.txt
done
vagrant@ubuntu2204:~$ ./ej17.sh
Dame un número: 2
vagrant@ubuntu2204:~$ ls
archivo1.txt  archivo2.txt
```

## 18.

```bash
#!/bin/bash

read -p "Ingresa una cadena: " cadena

contador=0

for (( i=0; i<${#cadena}; i++ )); do
    letra="${cadena:$i:1}"
    if [[ "$letra" =~ [aeiouAEIOU] ]]; then
        contador=$((contador + 1))
    fi
done

echo "La cadena contiene $contador vocales."
vagrant@ubuntu2204:~$ ./ej18.sh
Ingresa una cadena: Hola esto tiene 10 vocales
La cadena contiene 10 vocales.
```

## 19.

```bash
until [[ "$numero" -ge 1 && "$numero" -le 10 ]]; do
    read -p "Ingresa un número entre 1 y 10: " numero
done

echo "Número válido ingresado: $numero"
vagrant@ubuntu2204:~$ ./ej19.sh
Ingresa un número entre 1 y 10: 18
Ingresa un número entre 1 y 10: 80
Ingresa un número entre 1 y 10: 2
Número válido ingresado: 2
```

## 20.

```bash
#!/bin/bash

mkdir -p backup

for archivo in *; do
    if [[ -f "$archivo" && "$archivo" == *.txt ]]; then
        cp "$archivo" backup/
        echo "Copia de seguridad de '$archivo' realizada."
    fi
done
vagrant@ubuntu2204:~$ ./ej20.sh
Copia de seguridad de 'arch1.txt' realizada.
Copia de seguridad de 'arch2.txt' realizada.
Copia de seguridad de 'arch3.txt' realizada.
Copia de seguridad de 'archivo1.txt' realizada.
Copia de seguridad de 'archivo2.txt' realizada.
Copia de seguridad de 'directorios.txt' realizada.
vagrant@ubuntu2204:~$ ls backup/
arch1.txt  arch2.txt  arch3.txt  archivo1.txt  archivo2.txt  directorios.txt
```

[Volver](../../index.md)