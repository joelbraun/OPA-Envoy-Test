#!/bin/zsh

kubectl delete configmap proxy-config
kubectl create configmap proxy-config --from-file envoy.yaml

kubectl delete secret opa-policy
kubectl create secret generic opa-policy --from-file newpolicy.rego

kubectl delete deployment example-app
kubectl apply -f appdeployment.yaml

kubectl delete deployment example-policy-app
kubectl apply -f policydeployment.yaml

kubectl delete service example-app-service
kubectl expose deployment example-app --type=NodePort --name=example-app-service  --port=8080

kubectl delete service example-policy-service
kubectl expose deployment example-policy-app --type=NodePort --name=example-policy-service  --port=8081

export SERVICE_PORT=$(kubectl get service example-app-service -o jsonpath='{.spec.ports[?(@.port==8080)].nodePort}')
export SERVICE_HOST=$(minikube ip)
export SERVICE_URL=$SERVICE_HOST:$SERVICE_PORT
echo $SERVICE_URL

export POLICY_SERVICE_PORT=$(kubectl get service example-policy-service -o jsonpath='{.spec.ports[?(@.port==8081)].nodePort}')
export POLICY_SERVICE_HOST=$(minikube ip)
export POLICY_SERVICE_URL=$POLICY_SERVICE_HOST:$POLICY_SERVICE_PORT
echo $POLICY_SERVICE_URL