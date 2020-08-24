.PHONY: all
all: gke-cluster

.PHONY: gke-cluster
gke-cluster:
	bash setup-cluster.sh

.PHONY: clean
clean: clean-gke-cluster

.PHONY: clean-gke-cluster
clean-gke-cluster:
    # Remember to implement: delete zeebe volumes first
	gcloud container clusters delete josh-benchmark --region asia-southeast1-a -y
	