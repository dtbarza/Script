#!/bin/bash

# =====================================================
# Script de respaldo con política incremental optimizada
# =====================================================

# --- CONFIGURACIÓN ---
BACKUP_DIR="/backups"
SOURCE_DIRS="/var/spool/cron /home/equipo/documentacion"

# Fecha actual
DATE=$(date +%Y-%m-%d)

# Directorios de respaldo
FULL_DIR="$BACKUP_DIR/full"
INCR_DIR="$BACKUP_DIR/incremental"
LOG_FILE="$BACKUP_DIR/backup.log"

# Archivo de referencia para control de incrementales
SNAPSHOT_FILE="$BACKUP_DIR/backup.snar"

# Crear directorios si no existen
mkdir -p "$FULL_DIR" "$INCR_DIR"

# --- FUNCIÓN PARA LOGS ---
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# --- RESPALDO COMPLETO ---
full_backup() {
    log "Iniciando respaldo COMPLETO"
    tar --listed-incremental="$SNAPSHOT_FILE" -czf "$FULL_DIR/full-$DATE.tar.gz" $SOURCE_DIRS
    log "Respaldo COMPLETO finalizado: $FULL_DIR/full-$DATE.tar.gz"
}

# --- RESPALDO INCREMENTAL ACUMULATIVO ---
incremental_backup() {
    log "Iniciando respaldo INCREMENTAL"
    tar --listed-incremental="$SNAPSHOT_FILE" -czf "$INCR_DIR/incr-$DATE.tar.gz" $SOURCE_DIRS
    log "Respaldo INCREMENTAL finalizado: $INCR_DIR/incr-$DATE.tar.gz"
}

# --- DETERMINAR SI HOY TOCA COMPLETO O INCREMENTAL ---
# Día de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
DAY_OF_WEEK=$(date +%w)

# Semana del mes (1 a 5 aprox.)
WEEK_NUM=$(( ($(date +%-d) - 1) / 7 + 1 ))

# Cada 15 días (domingo impar → semana 1, 3, 5, ...)
if [ "$DAY_OF_WEEK" -eq 0 ] && [ $((WEEK_NUM % 2)) -ne 0 ]; then
    full_backup
else
    incremental_backup
