#!/bin/bash

# Renk tanımlamaları
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Mail Server Kurulum Scripti"
echo "=========================="

# Docker kontrolü
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker bulunamadı. Kurulum yapılıyor...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Docker Compose kontrolü
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Docker Compose bulunamadı. Kurulum yapılıyor...${NC}"
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Gerekli dizinleri oluştur
mkdir -p config/postfix config/dovecot config/opendkim
mkdir -p data/mail data/db
mkdir -p secrets

# Rastgele şifre oluştur
openssl rand -base64 32 > secrets/db_password.txt

# Environment dosyasını oluştur
cat > .env << EOF
POSTGRES_PASSWORD=$(cat secrets/db_password.txt)
DOMAIN_NAME=
ADMIN_EMAIL=
EOF

echo -e "${GREEN}Kurulum tamamlandı!${NC}"
echo "Lütfen .env dosyasını düzenleyerek domain ve email bilgilerinizi girin." 