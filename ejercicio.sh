
#!/bin/bash
det=1
menu()(
echo 1. Crear usuario
echo 2. Modificar usuario
echo 3. Eliminar usuario
echo 4. Listar usuarios del sistema
echo ingrese 0 para salir
)
while [ $det -ne 0 ]
do
clear
menu
read det
case $det in
1)./altas.sh
read 2
;;
2)./modificar.sh
echo ingrese enter para continuar
read 2
;;
3)./eliminar.sh
echo ingrese enter para continuar
read 2
;;
4)./listar.sh
echo ingrese enter para continuar 
read 2
;;
esac
done
