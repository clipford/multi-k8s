git status
ls
docker build -t clipford7/multi-client:latest -t clipford7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t clipford7/multi-server:latest -t clipford7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t clipford7/multi-worker:latest -t clipford7/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push clipford7/multi-client:latest
docker push clipford7/multi-server:latest
docker push clipford7/mutli-worker:latest

docker push clipford7/multi-client:$SHA
docker push clipford7/multi-server:$SHA
docker push clipford7/mutli-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=clipford7/multi-server:$SHA
kubectl set image deployments/client-deployment client=clipford7/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=clipford7/multi-worker:$SHA