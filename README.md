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
replace ${variable} for their real values
