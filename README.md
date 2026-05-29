## 🚀 Next.js-app DevOps Deployment with Docker, GitHub Actions, Kubernetes(Minikube or Kind) 

🧰 Prerequisites for this project
   
   - Node.js (v18+)
   
   - Docker

   - GitHub account

   - kubectl

   - minikube or kind

   - GitHub CLI

## 📦 Project Structure

     nextjs-devops-app/
       ├──.github/
       |  └── workflows/
       |    └── docker-ghcr.yml
       |
       ├── k8s/
       |  └──namespace.yml
       |  └── deployment.yaml
       |  └── service.yaml
       |
       ├── src/app
       ├── public
       └── package.json

## ⚙️ Local run

   🧰 Prerequisites

    -- Node.js

   🧱 Setup Instructions

   -- Clone the repository:

         git clone https://github.com/ankus04/next.js-devops-app.git
         cd nextjs-devops-app

   -- Install dependencies:

         npm install

   -- Run locally:

         npm run dev

   -- Visit http://localhost:3000


## 🐳 Docker Instructions

   -- Build Docker Image Locally

         docker build -t nextjs-devops-app .

   -- Run Docker Container

         docker run -p 3000:3000 nextjs-devops-app
      


## ⚙️ GitHub Actions CI/CD

   Workflow: `.github/workflows/docker-ghcr.yml`

   -- Triggers on push to `main`

   -- Builds Docker image

   -- Tags it as `ghcr.io/ankus04/next.js-devops-app:latest`

   -- Pushes to GitHub Container Registry

## ☸️ Kubernetes Deployment (Minikube)

   -- install kubectl

   -- install minikube

   -- Start Minikube

   -- Apply Kubernetes Manifests
         
         kubectl apply -f k8s/namespace.yml
         kubectl apply -f k8s/deployment.yaml
         kubectl apply -f k8s/service.yaml

   -- Verify Deployment

         kubectl get pods -n next.js-app
         kubectl get services -n next.js-app

   -- Expose the service using Minikube:

         minikube service nextjs-app-service -n nextjs-app
   
   
## ☸️ Kubernetes Deployment (kind)

   -- install kubectl

   -- install kind

   -- Create cluster

         kind create cluster

   -- Apply Kubernetes Manifests
         
         kubectl apply -f k8s/namespace.yml
         kubectl apply -f k8s/deployment.yaml
         kubectl apply -f k8s/service.yaml

   -- Verify Deployment

         kubectl get pods -n next.js-app
         kubectl get services -n next.js-app

   -- Port forward:

         sudo -E kubectl port-forward service/nextjs-app-service -n nextjs-app 8080:8080 --address=0.0.0.0
   
## 📄 Kubernetes Manifests Overview

   `deployment.yaml`
      
   -- Deploys 2 replicas

   -- Uses GHCR image 

   `service.yaml`        

   -- Exposes app via NodePort

   -- Maps port 3000 to container port 3000
