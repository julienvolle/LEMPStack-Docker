# LEMP Stack Docker

Stack docker with Nginx, PHP 7.4, MySQL 8 & optional tools.  

## Install

1. Create `.env` file from `.env.dist`.
   

2. Define your local parameters:
    - `VHOST_TDL`: top level domain (`.local` by default = `<your_domain>.local`)
    - `VHOST_ROOT`: app public root folder (`public` by default = `./app/<your_domain>/public/`)
    - `LOCAL_PORT_*`: localhost ports used
    - `DB_*`: database name, user and password
   

3. Run `docker-compose up -d` to build & start docker containers.

## Makefile

Docker shortcuts. Run `make` to see the available tasks:  
```
up            docker-compose up -d --build --remove-orphans
stop          docker-compose stop
restart       docker-compose restart
down          docker-compose down -v
reset         docker-compose down -v && docker-compose up -d --build --remove-orphans
list          docker-compose ps -a
perf          docker stats -a
log           docker-compose logs -ft [container=php]
ssh           docker-compose exec -u [user=root] [container=php] /bin/sh -l
exec          docker-compose exec -u [user=root] [container=php] [cmd="php --version"]
```

## Domain Names

1. Define `<your_domain>.<vhost_tdl>` in your host file (example: `127.0.0.1 my-website.local`)
2. Create folder `./app/<your_domain>/<vhost_root>/` (example: `./app/my-website/public/`)
3. Check in your browser `http://<your_domain>.<vhost_tdl>`   

## Certificates SSL

I am using the Nginx docker image from the [Devilbox](http://devilbox.org/) projet ([devilbox/docker-nginx-stable](https://github.com/devilbox/docker-nginx-stable)) to be able to use valid SSL certificates.

To enable secure HTTPS, add [in your browser](https://devilbox.readthedocs.io/en/latest/intermediate/setup-valid-https.html#import-the-ca-into-your-browser) the Devilbox certificate available here:  
`./docker/nginx/volumes/ca/devilbox-ca.crt`

Check in your browser `https://<your_domain>.<vhost_tdl>`  

## Volumes  

- `./docker/nginx/volumes/log` = Logs (HTTP & PHP)  
- `./docker/nginx/volumes/ca` = Certificates SSL  
- `./docker/php/volumes/conf/php.ini` = Custom PHP configuration  

## Tools

To be able to use the tools, create `docker-compose.override.yml` file from `docker-compose.override.yml.example` and (re)start install.  

Database Manager / [phpMyAdmin](https://github.com/phpmyadmin/docker)  
> http://localhost:8081

Cache Manager / [phpMemcachedAdmin](https://github.com/jacksoncage/phpmemcachedadmin-docker)
> http://localhost:8082

Docker Manager / [Portainer](https://github.com/portainer/portainer)  
> http://localhost:8083

## Example with Symfony  

Install project:  
`cd ./app`  
`composer create-project symfony/skeleton:"^4.4" julienvolle.fr`  

Add in host file:  
`127.0.0.1 julienvolle.fr.local`  
`127.0.0.1 *.julienvolle.fr.local`  

Add the certificate SSL in browser and let's go:  
> https://www.julienvolle.fr.local
