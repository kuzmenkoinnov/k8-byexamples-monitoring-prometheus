<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

# Fluentd Log Collection & Transport (via DaemonSet)

> k8 by example -- straight to the point, simple execution.

## Examples

```sh
$ make install

    configmap "prometheus-core" created
    clusterrolebinding "prometheus" created
    clusterrole "prometheus" created
    serviceaccount "prometheus-k8s" created
    configmap "prometheus-rules" created
    deployment "prometheus-core" created
    service "prometheus" created
    daemonset "prometheus-node-exporter" unchanged
    service "prometheus-node-exporter" unchanged
    daemonset "node-directory-size-metrics" created
    serviceaccount "kube-state-metrics" created
    deployment "kube-state-metrics" created
    service "kube-state-metrics" created
```

Check it out

```sh
$ kubectl get pod,svc --namespace infra-monitoring -o=wide

NAME                                     READY     STATUS    RESTARTS   AGE       IP            NODE
po/kube-state-metrics-694fdcf55f-gdmg4   1/1       Running   0          1m        10.12.1.71    gke-cluster-2-default-pool-25ca6a7e-w6pv
po/node-directory-size-metrics-fq7d6     2/2       Running   0          1m        10.12.0.70    gke-cluster-2-default-pool-25ca6a7e-3532
po/node-directory-size-metrics-rs5s8     2/2       Running   0          1m        10.12.1.70    gke-cluster-2-default-pool-25ca6a7e-w6pv
po/prometheus-core-5cf65c7b68-pzvqg      1/1       Running   0          1m        10.12.0.69    gke-cluster-2-default-pool-25ca6a7e-3532
po/prometheus-node-exporter-99lxf        1/1       Running   0          5m        10.138.36.6   gke-cluster-2-default-pool-25ca6a7e-3532
po/prometheus-node-exporter-c8vqc        1/1       Running   0          5m        10.138.36.5   gke-cluster-2-default-pool-25ca6a7e-w6pv

NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE       SELECTOR
svc/grafana                    ClusterIP   10.15.242.142   <none>        3000/TCP       3h        app=grafana
svc/kube-state-metrics         ClusterIP   10.15.247.85    <none>        8080/TCP       1m        app=kube-state-metrics
svc/prometheus                 NodePort    10.15.240.185   <none>        80:30792/TCP   1m        app=prometheus,component=core
svc/prometheus-node-exporter   ClusterIP   None            <none>        9100/TCP       5m        app=prometheus,component=node-exporter
```
