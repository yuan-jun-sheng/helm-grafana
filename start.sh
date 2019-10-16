#curl -L https://git.io/get_helm.sh | bash
#helm reset --force
kubectl apply -f helm/service-account.yml
kubectl apply -f helm/role-binding.yml
helm init --service-account tiller --wait
kubectl apply -f monitoring/namespace.yml
helm install stable/prometheus --namespace monitoring --name prometheus
kubectl apply -f monitoring/grafana/config.yml
helm install stable/grafana -f monitoring/grafana/values.yml --namespace monitoring --name grafana
kubectl get svc -n monitoring -l "app=grafana,release=grafana"  -o yaml > monitoring/grafana/grafana-svc.yml
sed -i 's/ClusterIP/NodePort/' monitoring/grafana/grafana-svc.yml
kubectl apply -f monitoring/grafana/grafana-svc.yml
echo "Please remember you login password for grafana dashboard admin user:"
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode 
echo
