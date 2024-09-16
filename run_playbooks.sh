#!/bin/bash

# Устанавливаем переменные
COMPANY_NAME=$1
INVENTORY=$2

if [ -z "$COMPANY_NAME" ]; then
    echo "Имя компании не указано. Используем значение по умолчанию 'demo'."
    COMPANY_NAME="demo"
fi

if [ -z "$INVENTORY" ]; then
    echo "Файл инвентаря не указан. Используем значение по умолчанию 'inventory.ini'."
    INVENTORY="inventory.ini"
fi

# Запускаем плейбуки по очереди
ansible-playbook -i $INVENTORY /srv/ansible/clone_project.yml --extra-vars "company_name=$COMPANY_NAME"
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении clone_project.yml"
    exit 1
fi

ansible-playbook -i $INVENTORY /srv/ansible/setup_env_frontend.yml --extra-vars "company_name=$COMPANY_NAME"
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении setup_env_frontend.yml"
    exit 1
fi

ansible-playbook -i $INVENTORY /srv/ansible/setup_env_backend.yml --extra-vars "company_name=$COMPANY_NAME"
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении setup_env_backend.yml"
    exit 1
fi

ansible-playbook -i $INVENTORY /srv/ansible/docker_compos_gen.yml --extra-vars "company_name=$COMPANY_NAME"
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении docker_compos_gen.yml"
    exit 1
fi

ansible-playbook -i $INVENTORY /srv/ansible/nginx_setup_remote.yml --extra-vars "company_name=$COMPANY_NAME"
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении nginx_setup_remote.yml"
    exit 1
fi

ansible-playbook -i $INVENTORY /srv/ansible/nginx_setup.yml --extra-vars "company_name=$COMPANY_NAME"
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении nginx_setup.yml"
    exit 1
fi

echo "Все плейбуки успешно выполнены."
