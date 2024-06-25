# Rapport de projet
### Panorama du cloud & déploiement AWS


## Lancement du script

pour lancer le script launch.sh il suffit d'effectuer cette commande :

```sh
./launch.sh
```
## Terraform et Ansible
### Connexion
1. Récupérer l'**access key** et la **secret key** de votre compte AWS.
2. recuperer la **key pair** depuis l'interface AWS nommé **"myKey"** pour se connecter à l'instance EC2. inserez le fichier `.pem` à la racine du projet.

### Terraform

Commandes à exécuter : 

```sh
cd terraform

echo 'aws_access_key = "XXX"\naws_secret_key = "XXX"' > variables.tfvars

docker container run -it --rm -v $PWD:$PWD -w $PWD hashicorp/terraform init

docker build -t terraform .
docker run --rm -w /workspace terraform apply -auto-approve
```

### Ansible

```sh
docker image build -t ansible:2.16 . 
docker container run --rm ansible:2.16 ansible-playbook -i inventory.ini playbook.yml
```

### Jenkins

Pour lancer et tester Jenkins en local:
```sh
docker run -p 8080:8080 -p 50000:50000 --restart=on-failure jenkins/jenkins:2.430-jdk21
```