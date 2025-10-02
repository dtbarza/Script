Manual Técnico
1. Introducción
Este manual documenta el uso y funcionamiento de un conjunto de scripts Bash diseñados para realizar tareas
administrativas básicas en un sistema Linux, relacionadas con la gestión de usuarios y grupos. Está dirigido a
administradores del sistema, técnicos o estudiantes que buscan automatizar procesos mediante el uso de shell scripts.

2. Estructura de Archivos

Gestión de usuarios:
- altas.sh
- modificar.sh
- eliminar.sh
- listar.sh
- ejercicio.sh (menú de usuarios)

Gestión de grupos:
- altasgrupos.sh
- modificargrupos.sh
- eliminargrupos.sh
- añadiragrupo.sh
- quitardegrupo.sh
- listargrupos.sh
- ejercicio_grupos.sh (menú de grupos)

Menú principal:
- menu.sh

3. Requisitos del Sistema
- Sistema operativo Linux.
- Permisos de superusuario (sudo) para ejecutar los comandos administrativos.
- Shell Bash instalado.
- Permisos de ejecución sobre los scripts: chmod +x *.sh

4. Detalle de Scripts
4.1 altas.sh - Crear usuario
#!/bin/bash
echo ingrese el nombre del usuario que quiere crear
read nombre
sudo adduser $nombre
echo usuario creado correctamente
echo ingrese enter para continuar
Explicación:
- Solicita el nombre del nuevo usuario.
  - Usa adduser para crearlo.
- Muestra confirmación.

4.2 modificar.sh 
- Modificar nombre de usuario
#!/bin/bash
echo ingrese el nombre del usuario que quiere modificar
read nombremod
echo ahora ingrese el nuevo nombre que le desea dar
read nombremodi
sudo usermod -l $nombremodi $nombremod
echo usuario modificado

Explicación:
- Cambia el nombre de un usuario usando usermod -l.

4.3 eliminar.sh
- Eliminar usuario
#!/bin/bash
echo ingrese el nombre del usuario que desea eliminar
read nombredel
sudo userdel $nombredel
echo usuario eliminado
Nota: Este comando no elimina el directorio personal. Para eliminarlo completamente:
sudo userdel -r $nombredel

4.4 listar.sh
- Listar usuarios
#!/bin/bash
cat /etc/passwd | awk -F : '{print $1}'
sleep 10

Explicación:
- Muestra todos los nombres de usuarios del sistema.
- Espera 10 segundos antes de cerrar.

4.5 ejercicio.sh
- Menú de gestión de usuarios
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
1)./altas.sh; read 2;;
2)./modificar.sh; echo ingrese enter para continuar; read 2;;
3)./eliminar.sh; echo ingrese enter para continuar; read 2;;
4)./listar.sh; echo ingrese enter para continuar; read 2;;
esac
done

4.6 altasgrupos.sh
- Crear grupo
#!/bin/bash
echo ingrese el nombre del grupo que quiere crear
read nombre
sudo addgroup $nombre
echo grupo creado correctamente

4.7 modificargrupos.sh
- Modificar nombre de grupo
#!/bin/bash
echo ingrese el nombre del grupo que quiere modificar
read nombremod
echo ahora ingrese el nuevo nombre que le desea dar
read nombremodi
sudo groupmod -l $nombremodi $nombremod
echo grupo modificado

4.8 eliminargrupos.sh 
- Eliminar grupo
#!/bin/bash
echo ingrese el nombre del grupo que desea eliminar
read grupodel
sudo groupdel $grupodel
echo grupo eliminado

4.9 añadiragrupo.sh 
- Añadir usuario a grupo
#!/bin/bash
echo ingrese el nombre del usuario que desea ingresar al grupo
read nombreUing
echo Ahora ingrese el nombre al cual desea añadir al usuario
read nombreGing
sudo usermod -aG $nombreGing $nombreUing

4.10 quitardegrupo.sh 
- Quitar usuario de grupo
#!/bin/bash
echo ingrese el nombre del usuario que desea retirar del grupo
read nombreUdel
echo Ahora ingrese el nombre del grupo del que lo desea retirar
read nombreGdel
sudo deluser $nombreUdel $nombreGdel

4.11 listargrupos.sh
- Listar grupos
#!/bin/bash
cat /etc/group | awk -F: '$4 > 0 {printf "%s: %s\n", $1, $4} $4 < 1 {printf "%s: %s\n", $1, "vacío"}'
sleep 10

Explicación:
- Muestra los grupos y sus miembros (o indica si están vacíos).

4.12 ejercicio_grupos.sh 
- Menú de gestión de grupos
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
1)./altasgrupos.sh; read 2;;
2)./modificargrupos.sh; read 2;;
3)./añadiragrupo.sh; read 2;;
4)./quitardegrupo.sh; read 2;;
5)./eliminargrupos.sh; read 2;;
6)./listargrupos.sh; read 2;;
esac
done

4.13 menu.sh 
- Menú principal
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
1)./ejercicio.sh;;
2)./ejercicio_grupos.sh;;
esac
done
4.14 servicios.sh  

Visualizar servicios  
echo -e "ESTADO DE APACHE:" $(systemctl status apache2 | grep Active | cut -f 1 -d";") \
"\nESTADO DE MySQL:" $(systemctl status mysql | grep Active | cut -f 1 -d";") \
"\nESTADO DE SSH:" $(systemctl status ssh | grep Active | cut -f 1 -d";") 
cat servicios.txt
echo "" > servicios.txt

Explicación:
- Comprueba si los servicios principales (Apache2, MySQL y SSH) están activos o inactivos.
- Permite al administrador detectar rápidamente si alguno de ellos dejó de funcionar.


4.15 firewall.sh
Visualizar estado del firewall
#!/bin/bash
sudo ufw status
Explicación:
- Muestra si el firewall (UFW) está activo o inactivo.
- Le permite al administrador verificar la seguridad básica del sistema.

5. Conclusiones
El uso de scripts Bash como los presentados en este manual permite automatizar tareas administrativas comunes,
ahorrar tiempo y reducir errores humanos. Este sistema es ideal para:
- Entornos educativos.
- Gestión de múltiples usuarios o grupos.
- Introducción a la administración de sistemas Linux.
