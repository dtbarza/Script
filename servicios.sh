#!/bin/bash
echo -e "ESTADO DE APACHE:" $(systemctl status apache2 | grep Active|cut -f 1 -d";") "\nESTADO DE MySQL:" $(systemctl status mysql| grep Active|cut -f 1 -d";") "\nESTADO DE SSH:" $(systemctl status ssh| grep Active|cut -f 1 -d";") 
cat servicios.txt
echo "" > servicios.txt


