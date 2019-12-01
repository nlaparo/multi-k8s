# build out images, tag, push to docker hub (implicit tag is latest)

docker build -t nlaparo/multi-client:latest -t nlaparo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nlaparo/multi-server:latest -t nlaparo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nlaparo/multi-worker:latest -t nlaparo/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push nlaparo/multi-client:latest
docker push nlaparo/multi-server:latest
docker push nlaparo/multi-worker:latest
ocker push nlaparo/multi-client:$SHA
docker push nlaparo/multi-server:$SHA
docker push nlaparo/multi-worker:$SHA

# apply all configs in the k8s folder
kubectl apply -f k8s

# imperatively set latest images on each deployment
kubectl set image deployments/client-deployment client=nlaparo/multi-client:$SHA
kubectl set image deployments/server-deployment server=nlaparo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nlaparo/multi-worker:$SHA
