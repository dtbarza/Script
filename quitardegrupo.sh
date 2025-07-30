#!/bin/bash
echo ingrese el nombre del usuario que desea retirar del grupo
read nombreUdel
echo Ahora ingrese el nombre del grupo del que lo desea retirar 
read nombreGdel
sudo deluser $nombreUdel $nombreGdel

