FROM node:10-alpine

# Configure variables
ENV ORACLE_MAJOR_VER=12
ENV ORACLE_MINOR_VER=1

# HTTPS configure

# For more mirrors : https://mirrors.alpinelinux.org/
RUN printf "https://uk.alpinelinux.org/alpine/v3.9/main\nhttps://uk.alpinelinux.org/alpine/v3.9/community\n" > /etc/apk/repositories
# RUN printf "https://ams.edge.kernel.org/alpine/v3.9/main\nhttps://ams.edge.kernel.org/alpine/v3.9/community\n" > /etc/apk/repositories
# RUN printf "https://ewr.edge.kernel.org/alpine/v3.9/main\nhttps://ewr.edge.kernel.org/alpine/v3.9/community\n" > /etc/apk/repositories

RUN apk add --no-cache libaio libc6-compat

# Oracle Client configure
ENV ORACLE_BASE /usr/lib/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}
ENV LD_LIBRARY_PATH /usr/lib/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}
ENV TNS_ADMIN /usr/lib/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}
ENV ORACLE_HOME /usr/lib/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}

COPY oracle/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}.zip ./

RUN unzip instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}.zip && \
    mv instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}/ /usr/lib/ && \
    rm instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}.zip

RUN ln /usr/lib/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}/libclntsh.so.${ORACLE_MAJOR_VER}.1 /usr/lib/libclntsh.so && \
    ln /usr/lib/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}/libocci.so.${ORACLE_MAJOR_VER}.1 /usr/lib/libocci.so && \
    ln /usr/lib/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}/libociei.so /usr/lib/libociei.so && \
    ln /usr/lib/instantclient_${ORACLE_MAJOR_VER}_${ORACLE_MINOR_VER}/libnnz${ORACLE_MAJOR_VER}.so /usr/lib/libnnz${ORACLE_MAJOR_VER}.so