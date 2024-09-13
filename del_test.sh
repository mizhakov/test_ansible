rm -r /etc/nginx/sites-enabled/demo*
rm -r /etc/nginx/sites-available/demo*
sudo certbot delete --cert-name demo.ismacloud.ru --non-interactive