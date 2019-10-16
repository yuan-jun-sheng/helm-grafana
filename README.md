1. Install helm
   curl -L https://git.io/get_helm.sh | bash
2. helm reset --force
3. kubectl apply -f helm/service-account.yml
4. kubectl apply -f helm/role-binding.yml
5. Deploy tiller
   helm init --service-account tiller --wait
6. kubectl apply -f monitoring/namespace.yml
7. helm install stable/prometheus \
    --namespace monitoring \
    --name prometheus
8. kubectl apply -f monitoring/grafana/config.yml
9. helm install stable/grafana \
    -f monitoring/grafana/values.yml \
    --namespace monitoring \ 
    --name grafana
10. Get secret
   kubectl get secret \
    --namespace monitoring \
    grafana \
    -o jsonpath="{.data.admin-password}" \
    | base64 --decode
11. kubectl get svc -n monitoring -l "app=grafana,release=grafana" -o yaml > monitoring/grafana/grafana-svc.yml
12. Modify type from ClusterIP to NodePort
    sed -i 's/ClusterIP/NodePort/' monitoring/grafana/grafana-svc.yml
13. If you use ingress to expose grafana, you do not need to do 11 and 12.
14. Login grafana dashboard with username admin and password got from 10.
15. In grafana dashboard import page, imput dashboard ID 1860 and click Load.
