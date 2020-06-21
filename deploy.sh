docker build -t maigret/multi-client:latest -t maigret/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maigret/multi-server:latest -t maigret/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maigret/multi-worker:latest -t maigret/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push maigret/multi-client:latest
docker push maigret/multi-server:latest
docker push maigret/multi-worker:latest

docker push maigret/multi-client:$SHA
docker push maigret/multi-server:$SHA
docker push maigret/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maigret/multi-server:$SHA
kubectl set image deployments/client-deployment client=maigret/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maigret/multi-worker:$SHA
