cluster-init:
	kind create cluster --name=submariner

gen-keys:
	./bin/gen-keys.sh ./keys

deploy:
	CA_BUNDLE_B64="$(base64 ./keys/ca.crt)"
	sed -e 's@${CA_BUNDLE_B64}@'"$CA_BUNDLE_B64"'@g' <"./manifests/03-mutatingwebhookconfig.yaml" \
    | kubectl create -f -
	kubectl apply -f ./manifests/
