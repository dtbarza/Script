
#!/bin/bash
echo ingrese el nombre del grupo que quiere crear
read nombre
sudo addgroup $nombre
echo grupo creado correctamente
