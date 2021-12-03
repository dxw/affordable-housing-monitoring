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

## Making changes

When making a change, update the changelog using the Keep a Changelog 1.0.0 format. Pull requests should not be merged before any relevant updates are made.

## Releasing changes

When making a new release, update the changelog in the release pull request.

Pull requests merged into `main` will be deployed to the production environment

To create a production deployment:

1. Create a branch release/xxx
1. Update changelog for the release
1. Commit and push
1. Open PRs from that branch to both main and develop
1. Get sign off on any other changes in the release, and approval on the PRs
1. Tag the HEAD of the PR release-xxx and push the tag
1. Merge both PRs
1. Watch production and smoke test when deployed
