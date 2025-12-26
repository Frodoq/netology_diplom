
1. **Репозиторий с конфигурационными файлами Terraform и готовность продемонстрировать создание всех ресурсов с нуля.**

   - Каталог в этом репозитории: [terraform/infra](https://github.com/Frodoq/netology_diplom/tree/main/terraform/infra)
   - Содержит модули для VPC, подсетей, security groups и ВМ под Kubernetes‑кластер.
   - Команды для развёртывания:

     ```
     cd terraform/infra
     terraform init
     terraform plan
     terraform apply
     ```

2. **Пример pull request с комментариями Atlantis / снимки экрана из Terraform Cloud или CI‑CD‑terraform pipeline.**

   - В рамках проекта использовался локальный запуск Terraform. В качестве подтверждения прилагается скриншот консоли с выполнением `terraform plan` 
     <img width="2896" height="1810" alt="image" src="https://github.com/user-attachments/assets/bb6a9736-2e93-4945-8f91-883e607af636" />


3. **Репозиторий с конфигурацией Ansible, если был выбран способ создания Kubernetes‑кластера при помощи Ansible.**

   - Для развёртывания кластера используется Kubespray, который лежит в каталоге [`kubespray`](https://github.com/Frodoq/netology_diplom/tree/main/kubespray)
   - Основной inventory: [`kubespray/inventory/diplom/hosts.yaml`](https://github.com/Frodoq/netology_diplom/blob/main/kubespray/inventory/diplom/hosts.yaml)`.
   - Команда для запуска:

     ```
     cd kubespray
     ansible-playbook -i inventory/diplom/hosts.yaml \
       --user <ssh_user> \
       --private-key ~/.ssh/admin_vm_key_correct \
       --become --become-user=root \
       cluster.yml
     ```

   <img width="2204" height="828" alt="image" src="https://github.com/user-attachments/assets/f88b3c63-b470-4dbe-9b86-475580928456" />
   


4. **Репозиторий с Dockerfile тестового приложения и ссылка на собранный Docker image.**

   - Каталог приложения: [`app`](https://github.com/Frodoq/netology_diplom/tree/main/app)
     - Dockerfile: [`app/Dockerfile`](https://github.com/Frodoq/netology_diplom/blob/main/app/Dockerfile)
     - HTML‑страница: [`app/index.html`](https://github.com/Frodoq/netology_diplom/blob/main/app/index.html)
     - Kubernetes‑манифест приложения: [`app/k8s-app.yaml`](https://github.com/Frodoq/netology_diplom/blob/main/app/k8s-app.yaml)
   - Собранный образ: [`sokolkovnetology/netology-app:v1`](https://hub.docker.com/r/sokolkovnetology/netology-app) в Docker Hub

     Сборка и пуш:

     ```
     cd app
     docker build -t sokolkovnetology/netology-app:v1 .
     docker push sokolkovnetology/netology-app:v1
     ```

   - **Ссылка на образ**: https://hub.docker.com/r/sokolkovnetology/netology-app
   <img width="3350" height="1428" alt="image" src="https://github.com/user-attachments/assets/ad0f32da-dfbc-4e44-990e-ee08f11f0edb" />


5. **Репозиторий с конфигурацией Kubernetes‑кластера.**

   - Каталог с манифестами приложения: [`app/`](app/) и файл [`app/k8s-app.yaml`](app/k8s-app.yaml).
   - Конфигурация кластера Kubernetes разворачивается с помощью Kubespray и хранится в каталоге [`kubespray/`](kubespray/), основной inventory — [`kubespray/inventory/diplom/hosts.yaml`](kubespray/inventory/diplom/hosts.yaml).
   - Примеры команд:

     ```
     # приложение
     kubectl apply -f app/k8s-app.yaml
     ```
     <img width="2880" height="180" alt="image" src="https://github.com/user-attachments/assets/d2e9c824-b8c4-43c2-a103-ae6f04824905" />


6. **Ссылка на тестовое приложение и веб‑интерфейс Grafana с данными доступа.**

   - Тестовое приложение (NodePort 30081):

     ```
     http://130.193.37.196:30080/
     ```


   - Grafana (NodePort, выданный сервису `prometheus-grafana` в namespace `monitoring`):

     ```
     kubectl get svc -n monitoring prometheus-grafana
     ```

     URL:

     ```
     http://130.193.37.196:30000/login
     ```

   - Доступ в Grafana предоставил в комментарии к сдаче

     ```
     kubectl get secret -n monitoring prometheus-grafana -o jsonpath="{.data.admin-user}" | base64 --decode
     echo
     kubectl get secret -n monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
     echo
     ``` 

   - **страница тестового приложения в браузере**: 
     <img width="3442" height="1304" alt="image" src="https://github.com/user-attachments/assets/f2f703f1-75b7-4789-b03e-8ade02d8868f" />

   - **дашборд Kubernetes в Grafana с видимым URL**:
     <img width="3420" height="1858" alt="image" src="https://github.com/user-attachments/assets/0cf1d228-0a15-4e21-b2c4-4fabcdc408c5" />


7. **Все репозитории хранятся на одном ресурсе.**

   Вся конфигурация Terraform, Ansible, Kubernetes, приложение, мониторинг и CI/CD находятся в одном репозитории:
   https://github.com/Frodoq/netology_diplom
   Собранный образ: https://hub.docker.com/r/sokolkovnetology/netology-app
