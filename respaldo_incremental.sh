#!/bin/bash

# =====================================================
# Script de respaldo con política incremental + DB
# =====================================================

# --- CONFIGURACIÓN ---
BACKUP_DIR="/backups"
SOURCE_DIRS="/var/spool/cron /home/equipo/documentacion"

# Fecha actual
DATE=$(date +%Y-%m-%d)

# --- CONFIG BASE DE DATOS ---
DB_NAME="Correbosco_qubir"
DB_USER="root"
DB_PASS="12345"
DB_BACKUP_DIR="$BACKUP_DIR/db"
DB_FILE="$DB_BACKUP_DIR/db-$DATE.sql.gz"

# Directorios de respaldo
FULL_DIR="$BACKUP_DIR/full"
INCR_DIR="$BACKUP_DIR/incremental"
LOG_FILE="$BACKUP_DIR/backup.log"

# Archivo .snar para incrementales
SNAPSHOT_FILE="$BACKUP_DIR/backup.snar"

# Crear directorios si no existen
mkdir -p "$FULL_DIR" "$INCR_DIR" "$DB_BACKUP_DIR"

# --- FUNCIÓN PARA LOGS ---
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# --- RESPALDO BASE DE DATOS ---
db_backup() {
    log "Iniciando respaldo de BASE DE DATOS: $DB_NAME"

    mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" 2>>"$LOG_FILE" \
        | gzip > "$DB_FILE"

    if [ $? -eq 0 ]; then
        log "Backup de DB completado: $DB_FILE"
    else
        log "ERROR en el backup de la base de datos"
    fi
}

# --- RESPALDO COMPLETO ---
full_backup() {
    db_backup
    log "Iniciando respaldo COMPLETO"
    tar --listed-incremental="$SNAPSHOT_FILE" -czf "$FULL_DIR/full-$DATE.tar.gz" \
        $SOURCE_DIRS "$DB_BACKUP_DIR"
    log "Respaldo COMPLETO finalizado: $FULL_DIR/full-$DATE.tar.gz"
}

# --- RESPALDO INCREMENTAL ACUMULATIVO ---
incremental_backup() {
    db_backup
    log "Iniciando respaldo INCREMENTAL"
    tar --listed-incremental="$SNAPSHOT_FILE" -czf "$INCR_DIR/incr-$DATE.tar.gz" \
        $SOURCE_DIRS "$DB_BACKUP_DIR"
    log "Respaldo INCREMENTAL finalizado: $INCR_DIR/incr-$DATE.tar.gz"
}

# --- DETERMINAR SI HOY TOCA COMPLETO O INCREMENTAL ---
# Día de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
DAY_OF_WEEK=$(date +%w)

# Semana del mes (1–5)
WEEK_NUM=$(( ($(date +%-d) - 1) / 7 + 1 ))

# Cada 15 días (domingo impar → semanas 1, 3, 5…)
if [ "$DAY_OF_WEEK" -eq 0 ] && [ $((WEEK_NUM % 2)) -ne 0 ]; then
    full_backup
else
    incremental_backup
fi

