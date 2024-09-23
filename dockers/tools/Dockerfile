FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update && apk add --no-cache \
    npm \
    dbmate

# Définir le répertoire de travail
WORKDIR /app

# Commande par défaut
CMD ["bash"]
