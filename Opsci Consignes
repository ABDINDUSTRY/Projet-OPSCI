# Projet OPSCI: Infrastructure compl&egrave;te avec objets connect&eacute;s et architecture &eacute;v&eacute;nementielle

## Objectif g&eacute;n&eacute;ral
L'objectif de ce projet est de construire une architecture compl&egrave;te pour une plateforme de gestion de produits int&eacute;grant une base de donn&eacute;es, un syst&egrave;me d'&eacute;v&eacute;nements et des objets connect&eacute;s.

## Structure du projet
Le projet se compose de trois parties :
1. **D&eacute;ploiement de l'infrastructure de base** (Strapi, PostgreSQL, Frontend React)
2. **Mise en place d'une architecture &eacute;v&eacute;nementielle** (Kafka et gestion des flux de donn&eacute;es)



## Partie 1 : Infrastructure de base (Strapi, PostgreSQL, Frontend React)
### Objectif
D&eacute;ployer une infrastructure de gestion des produits avec une base de donn&eacute;es PostgreSQL, un CMS Strapi et un frontend React.

### T&acirc;ches
- D&eacute;ployer **Strapi** pour la gestion des produits
- Mettre en place une base de donn&eacute;es **PostgreSQL** pour stocker les donn&eacute;es
- Configurer et d&eacute;ployer un **frontend React** connect&eacute; &agrave; l'API de Strapi
- G&eacute;n&eacute;rer un **token API** pour s&eacute;curiser les &eacute;changes entre le frontend et Strapi

### Architecture

#### Strapi

La premi&egrave;re &eacute;tape pour d&eacute;ployer l'application est de cr&eacute;er un projet strapi.

```sh
yarn create strapi-app ${project-name}
```

Configurez l'application: choisissez le mode avanc&eacute; et s&eacute;l&eacute;ctionnez postgresql.

Une fois le projet cr&eacute;&eacute; (dans le dossier `project-name`) cr&eacute;ez un Dockerfile pour cr&eacute;er une image docker du projet.

Strapi nous fourni une documentation et un exemple de dockerfile : https://docs.strapi.io/dev-docs/installation/docker

Certaines de ces configurations doivent &ecirc;tre coh&eacute;rentes avec celle de la base de donn&eacute;es `Postgresql`.

##### R&eacute;sultat attendu:

Strapi est lanc&eacute; correctement :
<img src="https://www-npa.lip6.fr/~buixuan/files/opsci2024/img/runstrapi.png"/>

Se connecter avec un administrateur :
<img src="https://www-npa.lip6.fr/~buixuan/files/opsci2024/img/admin.png"/>

Cr&eacute;er la collection `product` :
<img src="https://www-npa.lip6.fr/~buixuan/files/opsci2024/img/cms.png"/>

_Attention! si la collection `product` n'est pas cr&eacute;&eacute; ou mal cr&eacute;&eacute; le frontend pourrait avoir des erreurs_

###### Product

name: short text
description: long text
stock_available: integer (default 0)
image: single media (only image)
barcode: short text

#### Postresql

Pour que Strapi fonctionne il faut lui fournir une base de donn&eacute;es.

Pour d&eacute;ployer cette base de donn&eacute;es nous allons utiliser docker.

Il y a quelques configuration &agrave; ajouter pour &ecirc;tre sur de correctement initialiser la base de donn&eacute;es :

`POSTGRES_PASSWORD` et `POSTGRES_USER`

Que l'ont peut communiquer &agrave; l'image postresql de cette fa&ccedil;on :

```sh
docker run -dit -p 5432:5432 -e POSTGRES_PASSWORD=safepassword -e POSTGRES_USER=strapi --name strapi-pg postgres
```

_NB: par d&eacute;faut une base postresql expose ses services sur le port 5432. Libre &agrave; vous de modifier cette configuration si besoin._

#### React

En addition avec le frontend administrateur de strapi un projet react vous est fourni et doit se connecter &agrave; l'API de strapi.

Vous devez r&eacute;cup&eacute;rer le code : https://github.com/arthurescriou/opsci-strapi-frontend.

Vous devez &eacute;galement configurer ce frontend et le compiler/minifier (cf readme).

_NB: pour se connecter &agrave; l'API de strapi, outre l'URL correct, il faut ajouter un `TOKEN` de s&eacute;curit&eacute;. Il est possible de g&eacute;n&eacute;rer ce token dans l'interface administateur. (https://docs.strapi.io/dev-docs/configurations/api-tokens)
Il faudra l'ajouter dans la configuration du frontend._

R&eacute;sultat attendu (les deux &eacute;l&egrave;ments sont des produits cr&eacute;&eacute; dans strapi):

<img src="https://www-npa.lip6.fr/~buixuan/files/opsci2024/img/react.png"/>

### Travail attendu

L'objectif de cette partie est de cr&eacute;er toute l'application d&eacute;crite ci-dessus.

Chacun des ces &eacute;l&eacute;ments devra &ecirc;tre d&eacute;ploy&eacute; &agrave; partir d'une image docker sur l'infrastructure fourni par l'UE.

Vous devrez configurer correctement les conteneurs pour qu'ils interagissent entre eux.

---

## Partie 2 : Architecture &eacute;v&egrave;nementielle avec Kafka
### Objectif
Int&eacute;grer un syst&egrave;me de gestion des &eacute;v&egrave;nements bas&eacute; sur **Kafka** pour traiter des flux de donn&eacute;es en temps r&eacute;el.

### Pr&eacute;requis

Pour facilier le lancement du premier projet vous pouvez utiliser ce docker-compose, ou directement votre travail.

Si vous utilisez votre travail il faudra modifier le type de `product` :
Ajouter un champs `status` de type `enumeration` : `safe|danger|empty`

Et cr&eacute;er un type event avec un champ `value` de type `string` et un champ `metadata` de type `JSON`.

Le projet initialise les formats des objets n&eacute;cessaire au projet 2. Il peut &ecirc;tre n&eacute;cessaire de reg&eacute;n&eacute;rer un API TOKEN.

```yaml
version: '3'
services:
  strapi:
    container_name: strapi
    image: arthurescriou/strapi:1.0.0
    restart: unless-stopped
    env_file: .env
    environment:
      DATABASE_CLIENT: ${DATABASE_CLIENT}
      DATABASE_HOST: strapiDB
      DATABASE_PORT: ${DATABASE_PORT}
      DATABASE_NAME: ${DATABASE_NAME}
      DATABASE_USERNAME: ${DATABASE_USERNAME}
      DATABASE_PASSWORD: ${DATABASE_PASSWORD}
      JWT_SECRET: ${JWT_SECRET}
      ADMIN_JWT_SECRET: ${ADMIN_JWT_SECRET}
      APP_KEYS: ${APP_KEYS}
      NODE_ENV: ${NODE_ENV}
      PORT: 8080
    ports:
      - '8080:8080'
    networks:
      - strapi
    depends_on:
      - strapiDB

  strapiDB:
    container_name: strapiDB
    restart: unless-stopped
    env_file: .env
    image: arthurescriou/strapi-pg:1.0.0
    environment:
      POSTGRES_USER: ${DATABASE_USERNAME}
      POSTGRES_PASSWORD: ${DATABASE_PASSWORD}
      POSTGRES_DB: ${DATABASE_NAME}

    ports:
      - '5432:5432'
    networks:
      - strapi

networks:
  strapi:
    name: Strapi
    driver: bridge
```

### T&acirc;ches
- D&eacute;ployer un **broker Kafka** et **Zookeeper**
- Cr&eacute;er plusieurs **topics** pour g&eacute;rer les flux de donn&eacute;es :
  - `product` : ajout de nouveaux produits
  - `event` : enregistrement d'&eacute;v&egrave;nements li&eacute;s aux produits
  - `stock` : gestion des mises &agrave; jour de stock
  - `error` : stockage des erreurs
- D&eacute;ployer des **producers et consumers** Kafka pour chaque flux
- Int&eacute;grer Strapi avec Kafka pour g&eacute;rer les mises &agrave; jour des produits

### Architecture

On souhaite cr&eacute;er un syst&egrave;me permettant d'int&eacute;grer de grande quantit&eacute; de donn&eacute;es venant de diff&eacute;rents flux avec beaucoup de r&eacute;silience &agrave; l'erreur.

Pour &ccedil;a on utilise un message broker: Kafka.

<img src="https://www-npa.lip6.fr/~buixuan/files/opsci2024/img/projet2.png"/>

#### Kafka

On veut lancer un kafka avec docker (ou kubernetes).

On utilise la m&ecirc;me solution qu'au TME7.

```yml
version: '3'
services:
  zookeeper:
    image: wurstmeister/zookeeper:latest
    container_name: zookeeper
    ports:
      - '2181:2181'
    expose:
      - '2181'

  kafka:
    image: wurstmeister/kafka:2.11-1.1.1
    container_name: kafka
    ports:
      - '9092:9092'
      - '9093:9093'
    environment:
      KAFKA_ADVERTISED_LISTENERS: INSIDE://localhost:9093,OUTSIDE://kafka:9092,
      KAFKA_AUTO_CREATE_TOPICS_ENABLE: 'true'
      KAFKA_DELETE_TOPIC_ENABLE: 'true'
      KAFKA_ADVERTISED_PORT: 9092
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKAJS_NO_PARTITIONER_WARNING: '1'
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      KAFKA_LISTENERS: INSIDE://0.0.0.0:9093,OUTSIDE://0.0.0.0:9092
      KAFKA_INTER_BROKER_LISTENER_NAME: INSIDE
      KAFKA_NO_LISTENER_AUTHENTICATION_PLAINTEXT: 'true'
      KAFKA_NO_LISTENER_AUTHENTICATION_SSL: 'true'
      KAFKA_BROKER_ID: 1
      KAFKA_LOG_RETENTION_HOURS: 168
      KAFKA_LOG_RETENTION_BYTES: 1073741824
      KAFKA_LOG_DIRS: /kafka/logs
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    depends_on:
      - zookeeper
```

#### Topics

Notre kafka va n&eacute;c&eacute;ssiter plusieurs topics :

- product : un topic d&eacute;di&eacute; &agrave; la cr&eacute;ation de nouveau produit en masse, venant de diff&eacute;rentes sources
- event : un topic d&eacute;di&eacute; &agrave; la cr&eacute;ation de nouveau produit en masse, venant de diff&eacute;rentes sources
- stock : un topic pour enregistrer et appliquer tous les mouvements de stocks de nos produits
- error : pour r&eacute;cup&eacute;rer les &eacute;v&egrave;nement ayant abouti &agrave; une erreur diverse

_Attention tous ces topics devront &ecirc;tre pr&eacute;cis&eacute;s dans les configurations des consumers et producers. Si le noms n'est pas le m&ecirc;me des deux cot&eacute;es la communication ne marchera pas._

#### Consumer et Producer

Pour utiliser ces topics plusieurs &eacute;l&egrave;ments sont &agrave; votre disposition sous la forme d'image docker ou de d&eacute;p&ocirc;t github (<a href="https://github.com/orgs/opsci-su/repositories">https://github.com/orgs/opsci-su/repositories</a>).

Il s'agit des consumers et producers pour les diff&eacute;rents &eacute;l&eacute;ments.

Pensez bien &agrave; lire les readme des diff&eacute;rents &eacute;l&egrave;ments pour bien configurer leurs variables d'environments.

##### product-producer

<a href="https://hub.docker.com/repository/docker/arthurescriou/product-producer/" > https://hub.docker.com/repository/docker/arthurescriou/product-producer/ </a>

Pour lancer la cr&eacute;ation de `product` ins&eacute;rez le <a href="https://www-npa.lip6.fr/~buixuan/files/opsci2024/assets/products.csv" >fichier</a> dans votre container et sp&eacute;cifiez sa position dans la configuration.

##### product-consumer

<a href="https://hub.docker.com/repository/docker/arthurescriou/product-consumer/" > https://hub.docker.com/repository/docker/arthurescriou/product-consumer/ </a>

##### event-producer

<a href="https://hub.docker.com/repository/docker/arthurescriou/event-producer/" > https://hub.docker.com/repository/docker/arthurescriou/event-producer/ </a>

Pour lancer la cr&eacute;ation de `event` ins&eacute;rez le <a href="./assets/events.csv" >fichier</a> dans votre container et sp&eacute;cifiez sa position dans la configuration.

##### event-consumer

<a href="https://hub.docker.com/repository/docker/arthurescriou/event-consumer/" > https://hub.docker.com/repository/docker/arthurescriou/event-consumer/ </a>

##### stock-producer

<a href="https://hub.docker.com/repository/docker/arthurescriou/stock-producer/" > https://hub.docker.com/repository/docker/arthurescriou/stock-producer/ </a>

Pour lancer l'update de `stocks` ins&eacute;rez le <a href="./assets/stocks.csv" >fichier</a> dans votre container et sp&eacute;cifiez sa position dans la configuration.

##### stock-consumer

<a href="https://hub.docker.com/repository/docker/arthurescriou/stock-consumer/" > https://hub.docker.com/repository/docker/arthurescriou/stock-consumer/ </a>

##### artificial-intelligence

---

## Rendu attendu
- **Vid&eacute;o de d&eacute;monstration** : Parcours complet du projet, de l'ajout d'un produit &agrave; sa mise &agrave; jour via Kafka.
- **D&eacute;p&ocirc;t Git** contenant :
  - Les fichiers de configuration (Dockerfiles, docker-compose.yml)
  - Les scripts de lancement et d'arr&ecirc;t des services
  - Le code source du frontend React
  - Un `readme.md` d&eacute;taillant le d&eacute;ploiement et l'utilisation de l'application.

---

### Envoi du rendu
- Uniquement via l'espace Moodle de l'UE.

---

### Date de rendu
- ** 31/03/2025 &agrave; 23h59**
- Travail en **bin&ocirc;me** avec les num&eacute;ros &eacute;tudiants mentionn&eacute;s dans le `readme.md`.

---
