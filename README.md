# Containers

Starting my approach of provisioning [Alfresco Community](https://community.alfresco.com/docs/DOC-7050-alfresco-community-edition-201707-ga-file-list) using [docker-compose](https://docs.docker.com/compose/) with:
* one tomcat container based on [tomcat:8.5.20-jre8-alpine](https://hub.docker.com/r/library/tomcat/tags/)
* with Alfresco Community **Repository**
* and Alfresco Community **Share UI** on top
* [Jolokia](https://jolokia.org) WAR Agent - alternative to JSR-160 connectors
* `TBD - SOLR search`
  
>You will have the possibility to choose between any Alfresco Community distribution zip files - following the [start.sh](start.sh) helper script.

Help Needed: 
* email: paul.brodner@gmail.com

![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `! Prerequisites` 
- [x] [docker](https://docs.docker.com/engine/installation/)
- [x] [docker-compose](https://docs.docker.com/compose/)
- [x] access to one Alfresco Community [distribution ZIPs](https://community.alfresco.com/community/ecm) Release
- [x] Unix based operating system

# Starting Alfresco Community

### a) clone project

```bash
$ git clone https://github.com/paulbrodner/alfresco-community-deployment.git
```

> In root folder we have [docker-compose.yml](docker-compose.yml) file that will start Alfresco Community Edition with the distribution zip that you will provide - _see bellow_

### b) create .env file

Create a new `.env` file in root folder based on `.env.example`

### c) run start.sh

>in root folder you will find [start.sh](start.sh) - a helper script that will:
* download for you the Alfresco Community Edition to [tomcat/distribution](tomcat/distribution)
* start the docker-compose for you

```bash
$ ./start.sh

 _____                _     _
 |  __ \              (_)   (_)
 | |__) | __ _____   ___ ___ _  ___  _ __
 |  ___/ '__/ _ \ \ / / / __| |/ _ \| '_ \
 | |   | | | (_) \ V /| \__ \ | (_) | | | |
 |_|   |_|  \___/ \_/ |_|___/_|\___/|_| |_| by paul.brodner@gmail.com
   ------------------------------------------

1) Download Distributions  
2) Start
3) Quit
Choose your option (1-3):
``````bash
$ ./start.sh

 _____                _     _
 |  __ \              (_)   (_)
 | |__) | __ _____   ___ ___ _  ___  _ __
 |  ___/ '__/ _ \ \ / / / __| |/ _ \| '_ \
 | |   | | | (_) \ V /| \__ \ | (_) | | | |
 |_|   |_|  \___/ \_/ |_|___/_|\___/|_| |_| by paul.brodner@gmail.com
   ------------------------------------------

1) Download Distributions  
2) Start
3) Quit
Choose your option (1-3):
```

* choose first **1** to download the distro
* run again the script and choose **2** to start the entire solution.

### d) login to Alfresco
* access `http://localhost:8080/alfresco` for Alfresco Repository
* access `http://localhost:8080/share` for Alfresco with Share UI

---
![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `! Hint` 
* at any time you can download another Alfresco Community Edition and place it under tomcat/distribution folder

* make sure you update the [.env](.env) file with `COMMUNITY_DISTRIBUTION=distribution/<your-alfresco-community-distribution-201707.zip>`

* or just `export COMMUNITY_DISTRIBUTION=distribution/<your-alfresco-community-distribution-201707.zip` in bash file before `docker-compose up --build`