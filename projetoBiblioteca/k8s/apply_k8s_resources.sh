#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=300s

if [ $? -eq 0 ]; then
    kubectl apply -f internal-service.yaml
    kubectl apply -f configmap.yaml
    kubectl apply -f secrets.yaml
    kubectl apply -f postgres.yaml
    kubectl apply -f projeto-biblioteca.yaml
    kubectl apply -f ingress.yaml

    echo "Recursos do Kubernetes aplicados com sucesso!"
else
    echo "O Ingress Controller não está pronto. Verifique o estado do cluster."
fi
