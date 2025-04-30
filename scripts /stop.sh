#!/bin/bash

echo " Arrêt de l'infrastructure OPSCI..."

# Arrêter tous les docker-compose par dossier
docker-compose -f strapi/docker-compose.yml down
docker-compose -f opsci-strapi-frontend-master/docker-compose.yml down
docker-compose -f kafka_producer/docker-compose.yml down
docker-compose -f mqtt/docker-compose.yml down
docker-compose -f mqtt-kafka-connector/docker-compose.yml down

echo " Tous les services sont arrêtés."
