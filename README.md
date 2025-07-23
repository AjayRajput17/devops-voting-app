# Example Voting App


## Project Report
📄 **[Click here to view the full project report](./voting-app-report.pdf)**

## Project Overview
The Example Voting App is a distributed microservices-based web application that demonstrates fundamental DevOps practices. It showcases the orchestration and deployment of containerized services using Docker, Docker Swarm, and Kubernetes, with CI/CD pipelines implemented for automation.

This application is composed of five main components:

•	A Python-based frontend voting app

•	Redis message queue for vote handling

•	A .NET Core worker service to process the votes

•	A Postgres database for persistent storage

•	A Node.js-based result app for real-time vote display

## Technologies Used

•	Frontend: Python (Vote App), Node.js (Results App)

•	Backend Worker: .NET Core

•	Database: PostgreSQL

•	Messaging Queue: Redis

•	Containerization: Docker, Docker Compose

•	Orchestration: Docker Swarm & Kubernetes

•	CI/CD Tool: GitHub Actions + ArgoCD

•	Cloud Platform: Microsoft Azure (AKS Cluster)

A simple distributed application running across multiple Docker containers.

## Getting started

Download [Docker Desktop](https://www.docker.com/products/docker-desktop) for Mac or Windows. [Docker Compose](https://docs.docker.com/compose) will be automatically installed. On Linux, make sure you have the latest version of [Compose](https://docs.docker.com/compose/install/).

This solution uses Python, Node.js, .NET, with Redis for messaging and Postgres for storage.

Run in this directory to build and run the app:

```shell
docker compose up
```

The `vote` app will be running at [http://localhost:8080](http://localhost:8080), and the `results` will be at [http://localhost:8081](http://localhost:8081).

Alternately, if you want to run it on a [Docker Swarm](https://docs.docker.com/engine/swarm/), first make sure you have a swarm. If you don't, run:

```shell
docker swarm init
```

Once you have your swarm, in this directory run:

```shell
docker stack deploy --compose-file docker-stack.yml vote
```

## Run the app in Kubernetes

The folder k8s-specifications contains the YAML specifications of the Voting App's services.

Run the following command to create the deployments and services. Note it will create these resources in your current namespace (`default` if you haven't changed it.)

```shell
kubectl create -f k8s-specifications/
```

The `vote` web app is then available on port 31000 on each host of the cluster, the `result` web app is available on port 31001.

To remove them, run:

```shell
kubectl delete -f k8s-specifications/
```

## Architecture

![Architecture diagram](architecture.excalidraw.png)

* A front-end web app in [Python](/vote) which lets you vote between two options
* A [Redis](https://hub.docker.com/_/redis/) which collects new votes
* A [.NET](/worker/) worker which consumes votes and stores them in…
* A [Postgres](https://hub.docker.com/_/postgres/) database backed by a Docker volume
* A [Node.js](/result) web app which shows the results of the voting in real time

This project demonstrates the complete lifecycle of a microservices-based application, including development, containerization, orchestration, and deployment on cloud infrastructure. It also integrates modern DevOps practices such as CI/CD pipelines and GitOps via ArgoCD.




