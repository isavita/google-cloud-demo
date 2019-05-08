# Google Cloud Demo

### Create a Dockerfile for production build

  `docker build -t <IMAGE-NAME> .`

  e.g. `docker build -t google-cloud-demo-app .`

### Configure docker to use gcloud authorization

  `gcloud auth configure-docker --quiet`

### Get the `PROJECT_ID`

  `gcloud config get-value project`

  e.g.
  ```shell
    PROJECT_ID=$(gcloud config get-value project)
    echo $PROJECT_ID
  ```

### Change to a different project

  `gcloud config set project <PROJECT-ID>`

  e.g. `gcloud config set project myproject-app-123456`

### Add the registry name as a tag to the container image

  `docker tag <IMAGE-NAME>:<VERSION> gcr.io/<PROJECT-ID>/<IMAGE-NAME>`

  e.g. `docker tag google-cloud-demo-app:latest gcr.io/$PROJECT_ID/google-cloud-demo-app`

### Push the image to google cloud container registry

  `docker push gcr.io/<PROJECT-ID>/<IMAGE-NAME>`

  e.g. `docker push gcr.io/$PROJECT_ID/google-cloud-demo-app`

### Store project secrets in secret object on google cloud

  `kubectl create secret generic <SECRET-PROJECT-NAME> --from-literal=<KEY>=<VALUE>`

  e.g.
  ```shell
    kubectl create secret generic google-cloud-demo-app-credentials \
      --from-literal=user="$DATABASE_USER" \
      --from-literal=password="$DATABASE_PASSWORD" \
      --from-literal secret_key_base="$SECRET_KEY_BASE"
  ```

### Migrate data from Heroku Postgres to Cloud SQL with a streaming migration

  ```shell
  heroku pg:pull <HEROKU-DATABASE-URL> \
    postgres://<GC-DATABASE-USER>@<GC-DATABASE-HOST>/<GC-DATABASE-NAME> \
    --app <HEROKU-APP>
  ```

### Useful links

  * [How to migrate rails project from heroku to google cloud](https://cloud.google.com/solutions/migrating-ruby-on-rails-apps-on-heroku-to-gke)
