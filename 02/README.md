# Домашнее задание к занятию «Базовые объекты K8S»

## Задание 1. Создать Pod с именем hello-world

Создан манифест Pod `hello-world` с образом `gcr.io/kubernetes-e2e-test-images/echoserver:2.2`.

[Манифест hello-world](./02/01-hello-world.yaml)

Проверка состояния Pod:

```bash
kubectl get pods
```

![task1-pods](./02/img/task1-pods.png)

Для подключения к Pod выполнен проброс порта:

```bash
kubectl port-forward pod/hello-world 8080:8080
```

Проверка подключения:

```bash
curl http://localhost:8080
```

![task1-curl](./02/img/task1-curl.png)

---

## Задание 2. Создать Service и подключить его к Pod

Создан Pod `netology-web` с образом `gcr.io/kubernetes-e2e-test-images/echoserver:2.2`.

[Манифест netology-web](./02/02-netology-web.yaml)

Для доступа к Pod создан Service `netology-svc`.

[Манифест netology-svc](./02/02-netology-svc.yaml)

Проверка Pod и Service:

```bash
kubectl get pods
kubectl get svc
```

![task2-podsvc](./02/img/task2-podsvc.png)

Для локального подключения к Service выполнен проброс порта:

```bash
kubectl port-forward service/netology-svc 8080:80
```

Проверка подключения:

```bash
curl http://localhost:8080
```

![task2-curl](./02/img/task2-curl.png)
