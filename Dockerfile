FROM quay.io/ukhomeofficedigital/docker-centos-base:latest

ENV PG_MAJOR 9.4
ENV PG_VERSION 9.4.4-1.pgdg80+1
ENV LANG en_US.utf8
ENV LC_ALL $LANG
ENV PATH /usr/pgsql-9.4/bin/:$PATH
ENV PGDATA /var/lib/postgresql/data

RUN groupadd -r postgres && useradd -r -g postgres postgres && \
    mkdir /docker-entrypoint-initdb.d && \
    yum install -y \
    http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-redhat94-9.4-1.noarch.rpm && \
    yum install -y postgresql94-server postgresql94-contrib && \
    curl -L https://github.com/tianon/gosu/releases/download/1.1/gosu -o /usr/local/sbin/gosu && \
    chmod 0755 /usr/local/sbin/gosu && \
    mkdir -p /var/run/postgresql && \
    chown -R postgres /var/run/postgresql && \
    yum clean all

VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
