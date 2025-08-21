#!/bin/bash

# =====================================================
# Script de carga de CSV a la base de datos Proyecto
# =====================================================

DB_NAME="Proyecto"
DB_USER="root"
DB_PASS="SecretPass"
CSV_DIR="/home/equipo/csv"  # Carpeta donde están los CSV

# Listar todos los CSV
for file in $CSV_DIR/*.csv
do
    TABLE_NAME=$(basename "$file" .csv)
    
    echo "Importando $file a la tabla $TABLE_NAME..."
    
    mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "
    LOAD DATA LOCAL INFILE '$file'
    INTO TABLE $TABLE_NAME
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '\"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;"
    
    echo "Importación de $TABLE_NAME completada."
done

