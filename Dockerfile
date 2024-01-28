FROM alpine:3.19.1
RUN apk add --no-cache ca-certificates tzdata tini git && \
    git config --global --add safe.directory /src

WORKDIR /src
ENV GIT_DIR=/src/.git
ENTRYPOINT ["tini", "--", "sh", "-c", "while true; do (rm -vf /src/.git/*.lock && git fetch origin && git reset --hard origin && sleep 30) || exit 1; done || exit 1"]
#HEALTHCHECK CMD (rm -f /src/.git/*.lock && git fetch origin > /dev/null 2>&1 && git reset --hard origin > /dev/null 2>&1) || exit 1
