#! /bin/bash





















# Creo un pod per inserire all'interno i servizi
podman pod create --name TKBI-JasperServer -p 8090:8080

# Creo un rete dedicata
podman network create TKBI-JasperServer

# Creo un volume dedicato per rendere persistente MariaDB

podman volume create mariadb_data

# Creo il container con MariaDB

podman run -d --name mariadb --pod=TKBI-JasperServer  -e ALLOW_EMPTY_PASSWORD=yes -e MARIADB_USER=bn_jasperreports -e MARIADB_DATABASE=bitnami_jasperreports --net TKBI-JasperServer --volume  mariadb_data:/bitnami bitnami/mariadb:latest

#####

# Creo un volume dediato per rendere persistente JasperServer

podman volume create jasperreports_data
podman run -d --name jasperreports --pod=TKBI-JasperServer  -p 8080:8080 -e ALLOW_EMPTY_PASSWORD=yes -e JASPERREPORTS_DATABASE_USER=bn_jasperreports -e JASPERREPORTS_DATABASE_NAME=bitnami_jasperreports --net TKBI-JasperServer --volume jasperreports_data:/bitnami bitnami/jasperreports:latest

