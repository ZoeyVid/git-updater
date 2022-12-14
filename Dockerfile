FROM alpine:20221110
COPY update /usr/local/bin/update
RUN apk upgrade --no-cache && \
    apk add --no-cache ca-certificates wget tzdata git && \
    git config --global --add safe.directory /src && \
    chmod +x /usr/local/bin/update

ENV GIT_DIR=/src/.git
WORKDIR /src
ENTRYPOINT ["update"]
HEALTHCHECK CMD git fetch origin && git reset --hard origin || exit 1
