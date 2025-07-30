
#!/bin/bash
echo ingrese el nombre del usuario que quiere modificar 
read nombremod
echo ahora ingrese el nuevo nombre que le desea dar
read nombremodi
sudo usermod -l $nombremodi $nombremod
echo usuario modificado
