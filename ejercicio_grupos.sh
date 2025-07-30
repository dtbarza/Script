
#!/bin/bash
det=1
menu()(
echo 1. Crear grupo
echo 2. Modificar grupo
echo 3. Añadir usuario a grupo
echo 4. Quitar usuario de grupo
echo 5. Eliminar grupo
echo 6. Listar grupos del sistema 
echo ingrese 0 para salir
)
while [ $det -ne 0 ]
do
clear
menu
read det
case $det in
1)./altasgrupos.sh
read 2
;;
2)./modificargrupos.sh
read 2
;;
3)./añadiragrupo.sh
read 2
;;
4)./quitardegrupo.sh
read 2
;;
5)./eliminargrupos.sh
read 2
;;
6)./listargrupos.sh
read 2
;;
esac
done
