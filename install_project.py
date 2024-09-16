import ansible_runner
import sys

def run_ansible_playbook(playbook, company_name, inventory):
    r = ansible_runner.run(
        playbook=playbook,
        extravars={"company_name": company_name},
        inventory=inventory  # Указываем файл инвентаря
    )
    if r.status == "failed":
        print(f"Плейбук {playbook} завершился с ошибкой.")
    else:
        print(f"Плейбук {playbook} успешно выполнен.")
    return r.rc

# Получаем имя компании и файл инвентаря из аргументов командной строки или используем значения по умолчанию
if len(sys.argv) > 2:
    company_name = sys.argv[1]
    inventory_file = sys.argv[2]
else:
    company_name = "demo"  # Значение по умолчанию
    inventory_file = "inventory.ini"  # Значение по умолчанию для инвентаря

# Запуск плейбуков
playbooks = [
    "/srv/ansible/clone_project.yml",
    "/srv/ansible/setup_env_frontend.yml",
    "/srv/ansible/setup_env_backend.yml",
    "/srv/ansible/docker_compos_gen.yml",
    "/srv/ansible/nginx_setup_remote.yml",
    "/srv/ansible/nginx_setup.yml"
]

for playbook in playbooks:
    result_code = run_ansible_playbook(playbook, company_name, inventory_file)
    if result_code != 0:
        print(f"Ошибка при выполнении {playbook}. Остановка.")
        break
