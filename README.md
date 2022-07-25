# Supabase Docker

This is a minimal Docker Compose setup for self-hosting Supabase. Follow the steps [here](https://supabase.com/docs/guides/hosting/docker) to get started.


To build a Docker Compose for self-hosting Supabase 
1. Create a Custom Docker for postgres
  Go to supabase-custom-postgres folder
  #build the docker image

  docker build -t "custom-postgres" .

  #run the postgres docker image 

  docker-compose -f docker-compose.yml up


2. After creating and running the postgres docker image
  To Run supabase self-hosting docker

  a. First create the ANON_KEY and SERVICE_ROLE_KEY with  JWT_SECRET
     https://supabase.com/docs/guides/hosting/overview#api-keys

     Replace the anon key and service key in .env as well as kong.yml file (volume/api/kong.yml)
     
  b. Go to root folder

  docker-compose -f docker-compose.yml up
