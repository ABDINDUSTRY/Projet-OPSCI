#!/bin/bash

echo " Lancement de l'infrastructure OPSCI..."

# Lancer Strapi + PostgreSQL + Frontend
echo " Démarrage de Strapi et du frontend..."
docker-compose -f strapi/docker-compose.yml up -d
docker-compose -f opsci-strapi-frontend-master/docker-compose.yml up -d

# Lancer Kafka + Producer
echo " Démarrage de Kafka et des producteurs..."
docker-compose -f kafka_producer/docker-compose.yml up -d

# Lancer Mosquitto
echo " Démarrage du broker MQTT..."
docker-compose -f mqtt/docker-compose.yml up -d

# Lancer le connecteur MQTT ↔ Kafka
echo " Démarrage du connecteur MQTT-Kafka..."
docker-compose -f mqtt-kafka-connector/docker-compose.yml up -d

echo " Tous les services sont lancés !"
