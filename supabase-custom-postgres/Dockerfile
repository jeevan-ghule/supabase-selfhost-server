FROM postgres:13.2

RUN apt-get update && apt-get -y install git build-essential postgresql-server-dev-13

RUN git clone https://github.com/michelp/pgjwt.git 
RUN cd pgjwt && make && make install

RUN cd /

RUN git clone https://github.com/eulerto/wal2json.git 
RUN cd wal2json && make && make install

RUN cd / && \
    rm -rf /pgjwt && \
    rm -rf /wal2json && \
    apt-get remove -y git build-essential postgresql-server-dev-13 && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    apt-get purge

# COPY ./init-db /docker-entrypoint-initdb.d