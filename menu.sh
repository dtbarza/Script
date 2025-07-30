#!/bin/bash
det=1
menu()(
echo 1-gestion de usuarios
echo 2-gestion de grupos
echo ingrese 0 para salir
)
while [ $det -ne 0 ]
do
clear
menu
read det
case $det in
1)./ejercicio.sh
;;
2)./ejercicio_grupos.sh
;;
esac 
done

