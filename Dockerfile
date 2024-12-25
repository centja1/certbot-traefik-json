FROM alpine
RUN apk --update --no-cache add bash jq

ADD *.sh /
ADD certbot-cron /etc/cron.d/

RUN chmod 0744 /*.sh
RUN chmod 0644 /etc/cron.d/certbot-cron

RUN crontab /etc/cron.d/certbot-cron

RUN touch /var/log/cron.log

CMD ["/entrypoint.sh"]

