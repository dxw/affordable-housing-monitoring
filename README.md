# Affordable Housing Monitoring

An alpha project for Southwark for monitoring affordable housing in the borough.

## Setting up the project

Project can either be run locally or via Docker Compose

### Local setup

Run the setup command. This drops and recreates the database, installs any
dependencies, runs the DB migrations, and builds the assets:

```
script/setup
```

To just update dependencies and database seeds, you can run the bootstrap
command:

```
script/bootstrap
```

## Running the application

```
script/server
```

## Running the tests

```
script/test

### Docker compose setup

Requirements: [Docker](https://docs.docker.com/docker-for-mac)

```bash
docker-compose up
```

---

In either setup, the server will be running on http://localhost:3000, and the default user is email@example.com with the password of 'password'
