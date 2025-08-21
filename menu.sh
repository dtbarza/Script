#!/bin/bash
det=1

menu() {
    echo "===== MENU PRINCIPAL ====="
    echo "1 - Gestión de usuarios"
    echo "2 - Gestión de grupos"
    echo "3 - Carga de CSV a la base de datos"
    echo "4 - Respaldo con política incremental"
    echo "0 - Salir"
    echo "=========================="
    echo -n "Seleccione una opción: "
}

while [ $det -ne 0 ]
do
    clear
    menu
    read det
    case $det in
        1) ./ejercicio.sh ;;
        2) ./ejercicio_grupos.sh ;;
        3) ./cargar_csv.sh ;;          # Script de carga de CSV
        4) ./respaldo_incremental.sh ;; # Script de respaldo incremental
        0) echo "Saliendo...";;
        *) echo "Opción no válida"; sleep 2;;
    esac 
done

