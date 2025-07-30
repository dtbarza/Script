#!/bin/bash
echo ingrese el nombre del grupo que quiere modificar 
read nombremod
echo ahora ingrese el nuevo nombre que le desea dar
read nombremodi
sudo groupmod -l $nombremodi $nombremod
echo grupo modificado
