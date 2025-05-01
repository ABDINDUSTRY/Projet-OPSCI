# Projet OPSCI

### Ce projet a été réalisé dans le cadre de l’UE OPSCI à Sorbonne Université, sous la supervision de :
 Arthur Escriou (https://github.com/arthurescriou) et Katia AMICHI (https://fr.linkedin.com/in/katia-amichi).

## Developpeurs :
- Deschamps Joseph 3802649
- Sacko Abdoul-Hakim 21213015

## Vidéo de présentation du projet : https://youtu.be/KDiF4dOgc7g

## 🎯 Objectif

Ce projet a pour but de mettre en place une infrastructure complète de gestion de produits connectés, intégrant les composants suivants :
- Un CMS (Strapi) avec PostgreSQL pour la gestion des données,
- Une interface utilisateur en React (via Vite),
- Une architecture événementielle avec Kafka,
- Une intégration IoT via MQTT.

---

## 📁 Arborescence du projet

```
Projet-OPSCI/
│
├── mqtt/                         # Broker MQTT (Mosquitto)
│   ├── docker-compose.yml
│   └── mosquitto.conf
│
├── kafka_producer/              # Producteurs Kafka
│   ├── docker-compose.yml
│   ├── events.csv
│   └── products.csv
│
├── mqtt-js-test-master/         # Simulateur MQTT (Node.js)
│   ├── main.js
│   ├── read.js
│   └── package.json
│
├── mqtt-kafka-connector/        # Connecteur MQTT ↔ Kafka
│   ├── .env
│   └── docker-compose.yml
│
├── script/                      # scripts de lancement et d'arrêt des services
│   ├── start.sh
│   └── stop.sh
├── strapi/                      # Backend CMS (Strapi)
│   ├── config/
│   ├── src/
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── opsci-strapi-frontend-master/ # Frontend utilisateur (React + Vite)
│   ├── public/
│   ├── src/
│   ├── Dockerfile
│   └── docker-compose.yml
```

---

# PARTIE 1 : Projet

---
## Architecture
<img src="https://www-npa.lip6.fr/~buixuan/files/opsci2024/img/projet2.png"/>
---

## 🏁 Déploiement étape par étape

🛠️ Création initiale du projet Strapi (si non existant)
⚠️ À faire uniquement si le dossier strapi/ n'existe pas encore. Sinon, passe à l'étape suivante.

Dans un terminal, exécute :

```bash
npx create-strapi-app strapi
```
Choisir la base de donnée, personnaliser ou poursuivre en spammant la touche Entrée.

### 1️⃣ Lancer l'infrastructure principale (Strapi + PostgreSQL + Frontend)

Depuis le **dossier parent**, exécutez :

```bash
docker-compose up -d
```

Cela démarre Strapi et PostgreSQL.

> 🔑 **Astuce** : récupérez le token d’authentification Strapi dans les paramètres une fois l’interface accessible.

---

### 2️⃣ Configuration de Strapi

Accédez à l'interface d'administration à l'adresse suivante :  
📍 `http://localhost:1337/admin/`

Créez un compte administrateur, puis configurez les collections suivantes :

#### 🗃️ Collection "Product"
- `name` : short text  
- `description` : long text  
- `stock_available` : integer (default: 0)  
- `image` : media (image)  
- `barcode` : short text  
- `product_status` : enumeration (`safe`, `danger`, `empty`)  

#### 🗃️ Collection "Event"
- `value` : string  
- `metadata` : JSON  

> ⚠️ N'oubliez pas de générer un **API Token** dans `Settings > API Tokens` pour permettre au frontend et aux producteurs Kafka d'accéder à l'API.

---

### 3️⃣ Lancer le Frontend

Dans le dossier `opsci-strapi-frontend-master/` :

1. Remplacez le token Strapi dans `src/conf.ts`.
2. Démarrez le conteneur :

```bash
docker-compose up -d
```
Accédez à l'adresse suivante :  
📍 `http://localhost:5173/`

---

### 4️⃣ Lancer Kafka et les producteurs

Dans `kafka_producer/` :

1. Ajoutez le token Strapi dans les scripts si nécessaire.
2. Lancez Kafka et les producteurs :

```bash
docker-compose up -d
```

> 🕒 Patientez quelques instants pour que **Zookeeper** et **Kafka** soient entièrement lancés.  
> Si des erreurs surviennent, arrêtez avec `Ctrl + C` puis relancez.

> 🎨 Pour accélérer les traitements côté frontend, vous pouvez supprimer des produits via Strapi.

---

# PARTIE 2 : TME_10_11

---
## Architecture 

<img src="https://www-npa.lip6.fr/~buixuan/files/opsci2024/img/mqtt-OPSCI.jpg"/>

---

### 5️⃣ Lancer le broker MQTT après l'éxécution de toutes les étapes précédentes

Dans le dossier `mqtt/` :

```bash
docker-compose up -d
```

---

### 6️⃣ Tester l'envoi MQTT

Dans `mqtt-js-test-master/` :

1. Installez les dépendances :

```bash
yarn install
```

2. Lancez les scripts dans deux terminaux séparés :

```bash
# Terminal 1
node read.js

# Terminal 2
node main.js
```

---

### 7️⃣ Lancer le connecteur MQTT ↔ Kafka

Dans `mqtt-kafka-connector/` :

```bash
docker-compose up -d
```

---

## ✅ Résultats attendus

- Création et modification de produits via Strapi.
- Propagation automatique vers Kafka via les producteurs.
- Simulation d'événements IoT via MQTT.
- Affichage dynamique des données dans le frontend.

---

## 📌 Remarques et limites

- Le champ `status` a été renommé en `product_status` pour éviter des conflits avec des mots réservés. Pensez à faire la mise à jour dans les `.svg` et dans `App.tsx`.
- L’affichage conditionnel des couleurs selon le statut du produit n’a pas fonctionné.
- La mise à jour automatique du stock via les événements Kafka n’a pas pu être finalisée malgré plusieurs tentatives.


---
