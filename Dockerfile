FROM alpine:3.14
WORKDIR /app

RUN apk add --no-cache git openssh bash coreutils 

COPY run.sh /root/run.sh

CMD ["sh", "/root/run.sh"]
