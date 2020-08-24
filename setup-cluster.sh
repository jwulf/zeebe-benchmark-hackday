#!/bin/sh
gcloud config set project camunda-researchanddevelopment
gcloud container clusters create josh-benchmark \
  --region asia-southeast1-a \
  --num-nodes=1 \
  --enable-autoscaling --max-nodes=128 --min-nodes=1 \
  --machine-type=n1-standard-16 \
  --maintenance-window=1:00

# later or not needed any more? kubectl apply -f zeebe-benchmark-role-binding.yaml
kubectl apply -f ssd-storageclass.yaml

until helm install metrics stable/prometheus-operator --atomic -f prometheus-operator-values.yml --set prometheusOperator.tlsProxy.enabled=false | grep -m 1 "The Prometheus Operator has been installed"
do
	printf .
	sleep 1
done

kubectl apply -f grafana-load-balancer.yml

kubectl port-forward svc/metrics-grafana-loadbalancer :80

# later or not needed any more? kubectl apply -f service-monitor.yaml