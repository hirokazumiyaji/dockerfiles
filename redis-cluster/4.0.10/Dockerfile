FROM redis:4.0.10-alpine

ADD 7000 /data/7000
ADD 7001 /data/7001
ADD 7002 /data/7002
ADD 7003 /data/7003
ADD 7004 /data/7004
ADD 7005 /data/7005
ADD cluster /data/cluster

EXPOSE 7000 7001 7002 7003 7004 7005

CMD ["/data/cluster"]
