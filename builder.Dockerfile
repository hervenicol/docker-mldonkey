#./configure
#make
#make utils
#cp -rp distrib ../
#cp -p mlnet mld_hash make_torrent get_range dp500 copysources subconv svg_converter ../distrib
#cd ../distrib
#ln -s ../incoming incoming
#ln -s ../temp/ temp
#cp -rp ../distrib_060630/*.ini .
#cd ..
#chown -R mldonkey:users distrib

FROM debian:jessie

MAINTAINER Herve Nicol

RUN apt-get update && apt-get install -y bzip2 make gcc ocaml zlib1g-dev libbz2-dev libmagic-dev wget g++ libgd-dev libupnp-dev libnatpmp-dev libminiupnpc-dev
RUN adduser --uid 1001 mldonkey


ENV ML_VER=3.1.5
ENV DISTRIB_DIR=/distrib

ADD http://downloads.sourceforge.net/project/mldonkey/mldonkey/${ML_VER}/mldonkey-${ML_VER}.tar.bz2 /mldonkey.tar.bz2
RUN tar xvjpf /mldonkey.tar.bz2 && \
    mv /mldonkey-${ML_VER} /mldonkey && \
    chown -R mldonkey:users /mldonkey

WORKDIR /mldonkey
CMD ./configure --enable-upnp-natpmp && \
    make mlnet.static && \
    cp mlnet.static /output && \
    cp --parents -r \
       /lib/x86_64-linux-gnu/libresolv-2.19.so \
       /lib/x86_64-linux-gnu/libresolv.so.2 \
       /lib/x86_64-linux-gnu/libnss_dns-2.19.so \
       /lib/x86_64-linux-gnu/libnss_dns.so.2 \
       /lib/x86_64-linux-gnu/ld-2.19.so \
       /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 \
       /lib/x86_64-linux-gnu/libc-2.19.so \
       /lib/x86_64-linux-gnu/libc.so.6 \
       /lib/x86_64-linux-gnu/libnss_files-2.19.so \
       /lib/x86_64-linux-gnu/libnss_files.so.2 \
       /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache \
       /usr/share/misc \
       /usr/share/file \
       ${DISTRIB_DIR} && \
    mkdir -p ${DISTRIB_DIR}/etc ${DISTRIB_DIR}/tmp && \
    chmod 1775 ${DISTRIB_DIR}/tmp && \
    echo "127.0.0.1       localhost       localhost.localdomain" >> ${DISTRIB_DIR}/etc/hosts && \
    echo "nameserver 8.8.8.8 >> ${DISTRIB_DIR}/etc/resolv.conf"

