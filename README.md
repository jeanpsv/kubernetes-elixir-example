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
