helm del --purge grafana
helm del --purge prometheus
kubectl delete -f monitoring/grafana/config.yml
kubectl delete -f helm/role-binding.yml
kubectl delete -f helm/service-account.yml
helm reset --force
