#!/bin/bash
echo ingrese el nombre del usuario que desea eliminar
read nombredel
sudo userdel $nombredel
echo usuario eliminado
