FROM fluent/fluentd

# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache libmaxminddb-dev geoip geoip-dev
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
        && sudo gem install fluent-plugin-geoip \
                            fluent-plugin-elasticsearch \
                            fluent-plugin-kubernetes_metadata_filter \
                            fluent-plugin-remote-syslog \
                            fluent-plugin-s3 \
                            fluent-plugin-prometheus \
                            fluent-plugin-kafka \
                            fluent-plugin-copy_ex \
                            fluent-plugin-forest \
        && sudo gem sources --clear-all \
        && apk del .build-deps \
        && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

RUN mkdir -p /fluentd/etc/conf.d/ /fluentd/buffer/ /fluentd/log
RUN addgroup -S fluent && adduser -S fluent -G fluent -u 1000
RUN chown -Rf fluent. /fluentd/

ENV FLUENTD_CONF="fluent.conf"

ENV LD_PRELOAD=""
EXPOSE 24224 5140

USER fluent
CMD ["fluentd"]
