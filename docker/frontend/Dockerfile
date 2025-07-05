FROM nginx:mainline-alpine3.22
COPY build/ /srv/html/
COPY nginx.conf /etc/nginx/nginx.conf
COPY --chmod=100 change_global_ip_address.sh /docker-entrypoint.d/
