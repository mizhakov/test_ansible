
# Документация для проекта с использованием Ansible

## Основные файлы:

1. **`clone_project.yml`**:
   - **Описание**: Этот плейбук отвечает за клонирование проекта для фронтенда и бэкенда из GitLab в нужную директорию на сервере.
   - **Задачи**:
     - Создание директорий для фронтенда и бэкенда.
     - Клонирование репозиториев для фронтенда и бэкенда.

2. **`setup_env_frontend.yml`**:
   - **Описание**: Отвечает за генерацию файла окружения (.env) для фронтенда.
   - **Задачи**:
     - Создание файла `.env` с необходимыми параметрами для работы фронтенда.

3. **`setup_env_backend.yml`**:
   - **Описание**: Генерирует файл окружения (.env) для бэкенда.
   - **Задачи**:
     - Создание файла `.env` с настройками для базы данных, API и других переменных окружения для бэкенда.

4. **`docker_compos_gen.yml`**:
   - **Описание**: Этот плейбук генерирует файл `docker-compose.yml` для запуска Docker-контейнеров фронтенда и бэкенда.
   - **Задачи**:
     - Создание `docker-compose.yml` с конфигурациями для работы различных сервисов, таких как база данных, Redis и другие микросервисы.

5. **`nginx_setup_remote.yml`**:
   - **Описание**: Отвечает за настройку Nginx на удаленном сервере для проксирования запросов на различные сервисы (фронтенд, бэкенд).
   - **Задачи**:
     - Настройка конфигураций Nginx для работы с различными доменами и проксирования на нужные контейнеры.

6. **`nginx_setup.yml`**:
   - **Описание**: Настраивает Nginx с SSL-сертификатами на удаленном сервере.
   - **Задачи**:
     - Проверка конфигурации Nginx.
     - Выпуск SSL-сертификатов с помощью Certbot.
     - Настройка конфигураций Nginx с SSL.

7. **`run_playbooks.sh`**:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<mark>Нужно дергать его</mark>
   - **Описание**: Bash-скрипт, который запускает все плейбуки последовательно.
   - **Задачи**:
     - Запуск плейбуков для клонирования проекта, генерации файлов `.env`, генерации `docker-compose.yml`, настройки Nginx и установки SSL-сертификатов.

## Шаги для установки проекта:

1. **Запуск установки**:
   - Выполни скрипт для автоматического запуска всех плейбуков:
     ```bash
     ./run_playbooks.sh <company_name> <inventory_file>
     ```
   - Пример:
     ```bash
     ./run_playbooks.sh demo inventory.ini
     ```

2. **Что делает скрипт**:
   - **Клонирует проект** (фронтенд и бэкенд).
   - **Генерирует файлы окружения** для фронтенда и бэкенда.
   - **Генерирует файл `docker-compose.yml`** для запуска контейнеров.
   - **Настраивает Nginx** для работы с проектом.
   - **Выпускает SSL-сертификаты** для доменов и настраивает HTTPS.

> Если какой-либо плейбук завершится с ошибкой, выполнение скрипта остановится, и будет выведено сообщение об ошибке.

***
**Основные шпаргалки**

```bash
ansible-playbook -i inventory.ini clone_project.yml --extra-vars "company_name=demo"
```
```bash
ansible-playbook -i inventory.ini setup_env_frontend.yml --extra-vars "company_name=demo"
```
```bash
ansible-playbook -i inventory.ini setup_env_backend.yml --extra-vars "company_name=demo"
```
```bash
ansible-playbook -i inventory.ini docker_compos_gen.yml --extra-vars "company_name=demo"
```
```bash
ansible-playbook -i inventory.ini nginx_setup_remote.yml --extra-vars "company_name=demo"
```
```bash
ansible-playbook -i hosts nginx_setup.yml --extra-vars "company_name=demo"
```

**Второстепенные шпаргалки**

```
ansible-playbook master_playbook.yml --extra-vars "company_name=demos"
```
```
ansible-playbook -i hosts setup_env_frontend.yml --extra-vars "company_name=demos"
```
```
ansible-playbook -i hosts setup_env_backend.yml --extra-vars "company_name=demos"
```
```
certbot certonly --nginx --staging -d {{ company_name }}.ismacloud.ru -d {{ company_name }}api.ismacloud.ru --non-interactive --agree-tos --email mizhakov21@mail.ru
```