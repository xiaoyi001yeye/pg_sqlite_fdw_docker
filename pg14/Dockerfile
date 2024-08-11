FROM postgres:14.13 as sqlite-fdw-builder
ARG SQLITE_FDW_VERSION=v2.4.0
ARG SQLITE_FDW_URL=https://github.com/pgspider/sqlite_fdw/archive/refs/tags/${SQLITE_FDW_VERSION}.tar.gz
RUN apt-get update \
    && apt-get install -y --no-install-recommends pgxnclient wget ca-certificates make g++ cmake pkg-config postgresql-server-dev-14 libsqlite3-dev \
    && mkdir -p /tmp/sqlite_fdw \
    && wget -O - ${SQLITE_FDW_URL} | tar -zx --strip-components=1 -C /tmp/sqlite_fdw \
    && cd /tmp/sqlite_fdw \
    && USE_PGXS=1 LIBDIR=/usr/lib make \
    && USE_PGXS=1 LIBDIR=/usr/lib make install

FROM postgres:14.13
## sqlite-fdw
COPY --from=sqlite-fdw-builder /usr/lib/postgresql/14/lib/ /usr/lib/postgresql/14/lib/
COPY --from=sqlite-fdw-builder /usr/share/postgresql/14/extension/ /usr/share/postgresql/14/extension/

RUN su postgres -c "pg_ctl -D /var/lib/pgsql/${PGMAJOR}/data start" && \
    psql -c "create extension sqlite_fdw" postgres postgres && \
    psql -c "CREATE SERVER sqlite_server FOREIGN DATA WRAPPER sqlite_fdw options (database '/tmp/call_log.db');" postgres postgres && \
    psql -c "GRANT USAGE ON FOREIGN SERVER sqlite_server TO postgres" postgres postgres