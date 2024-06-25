# Lancer manuellement Docker Swarm

## Installer multipass :

Linux:

```
sudo snap install multipass
```

Macos:

```
brew install multipass
```

Windows:
[Download](https://multipass.run/download/windows)

## Créer les instances :

```
multipass launch --name master
multipass launch --name worker1
multipass launch --name worker2
```

## Installer Docker sur l'instance master :

```
multipass shell master
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

## Ajouter le répertoire Apt sources:

```
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
 $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

## Ou lancer une instance multipass directement à partir de l'image docker
```
multipass launch --name master docker
```

## Verifier le bon fonctionnement de Docker :

```
sudo docker run hello-world
```

## Installer Docker sur chaque workers:

```
multipass shell worker1
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

## Mettre à jour / Apt sources:

```
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
 $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

## Verifier le bon fonctionnement de Docker :

```
sudo docker run hello-world
```

⚠️ IMPORTANT: Faire de même pour le worker2

## Dans master, init Docker Swarm

```
docker swarm init --advertise-addr 192.168.69.7
```

## Puis dans chaque worker, lié ces derniers au master

```
docker swarm join --token <join_token> <ip_master>:2377
```

## Ajouter le docker-compose.yml (dans le dossier swarm) dans l'instance master ou faites un git clone

```
git clone https://github.com/EFREI-M1-Dev/AWS-Project-FLMP.git
```

## Créer un nouveau registry

```
sudo docker service create --name registry -p 5000:5000 registry
```

## Build les images docker se trouvant dans server/ or client/ (à partir des Dockerfile).

```
sudo docker image build -t 127.0.0.1:5000/server_image:latest -f Dockerfile .
sudo docker image build -t 127.0.0.1:5000/client_image:latest -f Dockerfile .
```

## Pousser ces images docker

```
sudo docker image push 127.0.0.1:5000/server_image:latest
sudo docker image push 127.0.0.1:5000/client_image:latest
```

## Deployé votre stack docker via le docker-compose.yml

```
sudo docker stack deploy -c docker-compose.yml mon_projet
```

## Verifier le bon fonctionnement des services

```
sudo docker stack services mon_projet
```

Vous devriez avoir ceci :

<img  src="../images/image_swarm_services.png" />
