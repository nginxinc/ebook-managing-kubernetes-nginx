#!/bin/bash

# get ip address of KIC
IC_IP=$(kubectl get svc -n nginx-ingress -o jsonpath="{.items[0].status.loadBalancer.ingress[0].ip}")
[ -z "$IC_IP" ] && IC_IP=$(kubectl get svc -n nginx-ingress -o jsonpath="{.items[0].status.loadBalancer.ingress[0].hostname}")

# send 300 requests to bookinfo
for i in $(seq 1 300);
do curl -I -k https://$IC_IP:443/productpage\?u=normal -H "host: bookinfo.example.com";
done