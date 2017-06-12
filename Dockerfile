FROM fluent/fluentd:v0.12.33-debian

USER root
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev libffi-dev" \
     && apt-get update \
     && apt-get install \
     -y --no-install-recommends \
     $buildDeps \
    && echo 'gem: --no-document' >> /etc/gemrc \
    && gem install fluent-plugin-elasticsearch \
    && gem install fluent-plugin-kubernetes_metadata_filter \
    && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
    && gem sources --clear-all \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# Copy conf files
COPY ./conf/fluent.conf /fluentd/etc/
COPY ./conf/app.conf /fluentd/etc/
COPY ./conf/kubernetes.conf /fluentd/etc/


# Environment variables
ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"


# Run Fluentd
CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
