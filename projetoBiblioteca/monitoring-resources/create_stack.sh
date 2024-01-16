#!/bin/bash

kubectl create ns monitoring
helm upgrade --install prom prometheus-community/kube-prometheus-stack -n monitoring --values values.yaml
kubectl apply -f servicemonitor.yaml