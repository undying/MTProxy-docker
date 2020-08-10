#! /bin/bash

CPU=$(grep -c processor /proc/cpuinfo)
MTPROXY_WORKERS=${MTPROXY_WORKERS:-${CPU}}

if [[ -z "${MTPROXY_SECRET}" ]];then
  ##MTPROXY_SECRET=$(head -c 16 /dev/urandom | xxd -ps)
  MTPROXY_SECRET=$(tr -dc 'a-f0-9' < /dev/urandom|head -c30)
  MTPROXY_SECRET=dd${MTPROXY_SECRET}
  printf "Proxy Secret: %s\n" "${MTPROXY_SECRET}"
fi

exec \
  mtproto-proxy \
    -u nobody \
    -p 8888 \
    -H 1503 \
    -M "${MTPROXY_WORKERS}" \
    -S "${MTPROXY_SECRET}" \
    --aes-pwd /opt/proxy-secret \
    /opt/proxy-multi.conf

# vi:syntax=sh
