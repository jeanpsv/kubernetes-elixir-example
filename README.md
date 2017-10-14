# kubernetes-elixir-example
Elixir application into Kubernetes Cluster

### Create project
```
mix phx.new kubernetes-elixir-example --app kubernetes_elixir_example --database postgres --no-brunch --no-html --binary-id
```

### Set up your database configuration
1. copy dev secret template file
```
cp config/dev.secret.exs.example config/dev.secret.exs
```
2. update username and password to authorize your database connection


### Run application
```
REPLACE_OS_VARS=true \
PORT=4000 \
HOST=example.com \
SECRET_KEY_BASE=${secret_key_base} \
DB_USERNAME=${db_username} \
DB_PASSWORD=${db_password} \
DB_NAME=${db_name} \
DB_HOSTNAME=${db_hostname} \
_build/prod/rel/kubernetes_elixir_example/bin/kubernetes_elixir_example foreground
```
replace ```${variable}``` for their real values

### Prepare Kubernetes (Minikube)
Before generating your application images, start Minikube (``` minikube start```) and run ```eval $(minikube docker-env)``` to reuse Docker daemon.

### Generate Docker images
```
mix docker.build
mix docker.release
```

### Run application with Docker
```
docker run -it -p 8000:8000 \
-e "HOST=example.com" \
-e "SECRET_KEY_BASE=${secret_key_base}" \
-e "DB_USERNAME=${db_username}" \
-e "DB_PASSWORD=${db_password}" \
-e "DB_NAME=${db_name}" \
-e "DB_HOSTNAME=${db_hostname}" \
--rm jeanpsv/kubernetes-elixir-example:release foreground
```

Run ```minikube ip``` to discover the IP address of Minikube VM and access your application in:
```
http://<minikube ip>:8000
```

### Run application on Kubernetes using Minikube
1. Copy ```k8s/secrets.yml.example``` to ```k8s/secrets.yml```
```
cp k8s/secrets.yml.example k8s/secrets.yml
```
2. Replace ```<secret_key_base_here>``` to your real value and do the same for ```<db_password_here>```.
3. Apply secrets: ```kubectl create -f k8s/secrets.yml```
4. Apply deployment: ```kubectl create -f k8s/deployment.yml```
5. Apply service: ```kubectl create -f k8s/service.yml```

Type ```minikube service kubernetes-elixir-example-service``` open your application on browser and know the IP address.

### Furthermore

I followed that tutorials:

- [A Complete Guide to Deploying Elixir & Phoenix Applications on Kubernetes — Part 1: Setting up Distillery](https://blog.polyscribe.io/a-complete-guide-to-deploying-elixir-phoenix-applications-on-kubernetes-part-1-setting-up-d88b35b64dcd)
- [A Complete Guide to Deploying Elixir & Phoenix Applications on Kubernetes — Part 2: Docker and Minikube](https://blog.polyscribe.io/a-complete-guide-to-deploying-elixir-phoenix-applications-on-kubernetes-part-2-docker-and-81e934c3fceb)
- [A Complete Guide to Deploying Elixir & Phoenix Applications on Kubernetes — Part 3: Deploying to Kubernetes](https://blog.polyscribe.io/a-complete-guide-to-deploying-elixir-phoenix-applications-on-kubernetes-part-3-deploying-to-bd5b1fcbef87)
- [A Complete Guide to Deploying Elixir & Phoenix Applications on Kubernetes — Part 4: Secret Management](https://blog.polyscribe.io/a-complete-guide-to-deploying-elixir-phoenix-applications-on-kubernetes-part-4-secret-f851d575bdd1)
