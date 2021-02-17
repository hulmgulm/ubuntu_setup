FROM nginx:alpine

ARG HTTP_PROXY
ENV HTTP_PROXY ${HTTP_PROXY}
ENV HTTPS_PROXY ${HTTP_PROXY}

COPY default.conf /etc/nginx/template.conf
COPY nginx.sh /

RUN set -ex && \
  apk add openssl

CMD /nginx.sh
