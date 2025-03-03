FROM ubuntu:22.04

# Sistem paketlerini güncelle ve gerekli paketleri kur
RUN apt-get update && apt-get install -y \
    postfix \
    dovecot-imapd \
    dovecot-pop3d \
    opendkim \
    opendmarc \
    spamassassin \
    clamav \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Konfigürasyon dosyalarını kopyala
COPY config/postfix/main.cf /etc/postfix/
COPY config/dovecot/dovecot.conf /etc/dovecot/
COPY config/opendkim/opendkim.conf /etc/opendkim/
COPY config/supervisord.conf /etc/supervisor/conf.d/

# Gerekli dizinleri oluştur
RUN mkdir -p /var/mail /var/run/dovecot

# Supervisor ile servisleri başlat
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"] 