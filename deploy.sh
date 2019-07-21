docker build -t kfclts/multi-client:latest -t kfclts/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kfclts/multi-server:latest -t kfclts/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kfclts/multi-worker:latest -t kfclts/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kfclts/multi-client:latest
docker push kfclts/multi-server:latest
docker push kfclts/multi-worker:latest

docker push kfclts/multi-client:$SHA
docker push kfclts/multi-server:$SHA
docker push kfclts/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kfclts/multi-server:$SHA
kubectl set image deployments/client-deployment client=kfclts/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kfclts/multi-worker:$SHA