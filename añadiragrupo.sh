#!/bin/bash
echo ingrese el nombre del usuario que desea ingresar al grupo
read nombreUing
echo Ahora ingrese el nombre al cual desea añadir al usuario
read nombreGing
sudo usermod -aG $nombreGing $nombreUing
