FROM nginx:1.27-alpine

COPY deploy/nginx-orcamento.conf /etc/nginx/conf.d/default.conf
COPY deploy/orcamento-index.html /usr/share/nginx/html/orcamento/index.html
COPY empresas/ /usr/share/nginx/html/orcamento/
