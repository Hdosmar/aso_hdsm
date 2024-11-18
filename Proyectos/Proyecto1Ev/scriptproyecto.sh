#!/bin/bash

# Antes de ejecutar el script es necesario tener en la misma carpeta el archivo tcp.csv y tener net-tools instalado de lo contrario el servicio no lo va a agarrar y la MAC no la vas a poder ver
# La MAC del localhost no está soportada, pondrá entries

# Variable que cuenta lo que tarda en ejecutarse el script
SECONDS=0

# Variables en las que guardo los parámetros
cidr=$1
pi=$2
pfin=$3
archivo=$4

# Valida que hayas metido 4 variables y que el rango de los puertos sea válido
if [[ $# -eq 4 && $pi -gt 0 && $pfin -lt 65536 ]]
then
        # Separa la ip y la máscara
        ip=$(echo "$cidr" | awk -F'/' '{print $1}')
        mask=$(echo "$cidr" | awk -F'/' '{print $2}')

        # Separa la ip por octetos
        oct1=$(echo "$ip" | awk -F'.' '{print $1}')
        oct2=$(echo "$ip" | awk -F'.' '{print $2}')
        oct3=$(echo "$ip" | awk -F'.' '{print $3}')
        oct4=$(echo "$ip" | awk -F'.' '{print $4}')

        # Comprueba que los octetos estén en los rangos que tienen que estar
        if [[ $oct1 -lt 0 || $oct1 -gt 255 ]]  ||
        [[ $oct2 -lt 0 || $oct2 -gt 255 ]] ||
        [[ $oct3 -lt 0 || $oct3 -gt 255 ]] ||
        [[ $oct4 -lt 0 || $oct4 -gt 255 ]]
        then
                echo "La ip no es válida"
        else
                # Valida la máscara de 3 para que solo pueda meter /24 /16 /8
                if [[ $mask == 24 || $mask == 16 || $mask == 8 ]]
                then
                        # Una vez validado todo mira si el archivo está creado y si no lo está lo crea y le mete la cabecera del CSV
                        if [[ -e "$archivo.csv" ]]
                        then
                                echo "\"ip\",\"mac\",\"so\",\"puerto\",\"servicio\"" > "$archivo.csv"
                        else
                                touch "$archivo.csv"
                                echo "\"ip\",\"mac\",\"so\",\"puerto\",\"servicio\"" > "$archivo.csv"
                        fi
                        
                        # Dependiendo de la máscara hace un for mas para la dirección de red, /24 1 for, /16 2 for, /8 3 for
                        case $mask in
                        24)
                                for i in {1..254}
                                do
                                        if ping -W 1 -c 1 "$oct1.$oct2.$i.$c" > /dev/null 2>&1
                                        then
                                                # Si contesta el ping guarda el TTL y le hace un arp -a para guardar la MAC
                                                ttl=$(ping -W 1 -c 1 "$oct1.$oct2.$i.$c" | grep -o 'ttl=[0-9]*' | cut -d '=' -f 2)
                                                mac=$(arp -a "$oct1.$oct2.$i.$c" | awk -F ' ' '{print $4}')

                                                # Lo muestra en pantalla
                                                echo "El host $oct1.$oct2.$i.$c responde al ping"
                                                echo "  Mac = $mac"

                                                # Guarda la ip en una variable para guardarla en el csv mas tarde
                                                datos="$oct1.$oct2.$i.$c"

                                                # Comprueba si el host es linux o windows mediante el TTL
                                                if [[ $ttl -gt 64 ]]
                                                then
                                                        echo "  TTL = $ttl es Windows"
                                                        host="Windows"
                                                else
                                                        echo "  TTL = $ttl es Linux"
                                                        host="Linux"
                                                fi

                                                # Realiza un netcat a la ip y rango de puertos que le has pasado por parámetro
                                                for ((b=pi; b<=pfin; b++))
                                                do
                                                    if nc -zv "$oct1.$oct2.$i.$c" $b 2>/dev/null
                                                    then
                                                        # Si el nc contesta entra al archivo tcp.csv y saca el servicio, acto seguido lo muestra en pantalla con el puerto
                                                        servicio=$(grep ",$b," tcp.csv | awk -F',' '{print $3}' | tr -d '"')
                                                        echo "  Puerto $b OPEN  Servicio: $servicio"

                                                        # Una vez recopilado todos los datos los mete al CSV
                                                        datos="\"$datos\",\"$mac\",\"$host\",\"$b\",\"$servicio\""
                                                        echo "$datos" >> "$archivo.csv"
                                                    fi
                                                done 
                                        fi
                                done ;;
                        # La máscara 16 tiene el mismo código que la /24 solo que con un for mas para el tercer octeto 
                        16)
                                for i in {1..255}
                                do
                                        for c in {1..254}
                                        do
                                                if ping -W 1 -c 1 "$oct1.$oct2.$i.$c" > /dev/null 2>&1
                                        then
                                                ttl=$(ping -W 1 -c 1 "$oct1.$oct2.$i.$c" | grep -o 'ttl=[0-9]*' | cut -d '=' -f 2)
                                                mac=$(arp -a "$oct1.$oct2.$i.$c" | awk -F ' ' '{print $4}')
                                                echo "El host $oct1.$oct2.$i.$c responde al ping"
                                                echo "  Mac = $mac"
                                                datos="$oct1.$oct2.$i.$c"
                                                if [[ $ttl -gt 64 ]]
                                                then
                                                        echo "  TTL = $ttl es Windows"
                                                        host="Windows"
                                                else
                                                        echo "  TTL = $ttl es Linux"
                                                        host="Linux"
                                                fi
                                                for ((b=pi; b<=pfin; b++))
                                                do
                                                    if nc -zv "$oct1.$oct2.$i.$c" $b 2>/dev/null
                                                    then
                                                        servicio=$(grep ",$b," tcp.csv | awk -F',' '{print $3}' | tr -d '"')
                                                        echo "  Puerto $b OPEN  Servicio: $servicio"
                                                        datos="\"$datos\",\"$mac\",\"$host\",\"$b\",\"$servicio\""
                                                        echo "$datos" >> "$archivo.csv"
                                                    fi
                                                done
                                        fi
                                        done
                                done ;;
                        # La máscara 8 tiene el mismo código que la /24 solo que con 2 for mas para el tercer y segundo octeto
                        8)
                                for i in {1..255}
                                do
                                        for c in {1..255}
                                        do
                                                for d in {1..254}
                                                do
                                                        if ping -W 1 -c 1 "$oct1.$oct2.$i.$c.$d" > /dev/null 2>&1
                                        then
                                                ttl=$(ping -W 1 -c 1 "$oct1.$oct2.$i.$c.$d" | grep -o 'ttl=[0-9]*' | cut -d '=' -f 2)
                                                mac=$(arp -a "$oct1.$oct2.$i.$c.$d" | awk -F ' ' '{print $4}')
                                                echo "El host $oct1.$oct2.$i.$c.$d responde al ping"
                                                echo "  Mac = $mac"
                                                datos="$oct1.$oct2.$i.$c.$d"
                                                if [[ $ttl -gt 64 ]]
                                                then
                                                        echo "  TTL = $ttl es Windows"
                                                        host="Windows"
                                                else
                                                        echo "  TTL = $ttl es Linux"
                                                        host="Linux"
                                                fi
                                                for ((b=pi; b<=pfin; b++))
                                                do
                                                    if nc -zv "$oct1.$oct2.$i.$c.$d" $b 2>/dev/null
                                                    then
                                                        servicio=$(grep ",$b," tcp.csv | awk -F',' '{print $3}' | tr -d '"')
                                                        echo "  Puerto $b OPEN  Servicio: $servicio"
                                                        datos="\"$datos\",\"$mac\",\"$host\",\"$b\",\"$servicio\""
                                                        echo "$datos" >> "$archivo.csv"
                                                    fi
                                                done &
                                        fi
                                                done
                                        done
                                done ;;
                        esac
                else
                        # En caso de que la máscara no sea válida lo señala
                        echo "La máscara no es válida pero la ip si"
                fi
        fi
        # Muestra por pantalla los segundos que ha tardado en ejecutarse
        echo "El script tardó $SECONDS en ejecutarse"
else
        # En caso de que los parámetros no sean correctos o no se hayan introducido lo avisará y te dará instrucciones
        echo "Los parámetros son inválidos o no existen"
        echo ""
        echo "El script debe ejecutarse con los siguientes parámetros: "
        echo "IP/Máscara PuertoInicio PuertoFin NombreArchivo"
        echo "La ip tiene que ser válida, el rango de puertos tiene que ser entre 1-65535 y asegura que el archivo no tiene extensión"
fi