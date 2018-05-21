FROM alpine
MAINTAINER mwaeckerlin
ARG lang="en_US.UTF-8"

# change in childern:
ENV CONTAINERNAME     "base"

ENV LANG              "${lang}"
ENV SHARED_GROUP_NAME "shared-access"
ENV SHARED_GROUP_ID   "500"
ENV PS1               '\[\033[36;1m\]\u\[\033[97m\]@\[\033[32m\]${CONTAINERNAME}[\[\033[36m\]\h\[\033[97m\]]:\[\033[37m\]\w\[\033[0m\]\$ '
ENV PS4='${LINENO}: '

RUN addgroup -g $SHARED_GROUP_ID $SHARED_GROUP_NAME

RUN apk update --no-cache && apk upgrade --no-cache

# /cleanup.sh should be called at the end in all children
ADD cleanup.sh /cleanup.sh
RUN /cleanup.sh

# derieved images must have a /start.sh command as entrypoint
ONBUILD ADD start.sh /start.sh
ONBUILD CMD ["/start.sh"]

# derieved images must have a health check script at /health.sh
ONBUILD ADD health.sh /health.sh
ONBUILD HEALTHCHECK --interval=60s --timeout=10s --start-period=600s --retries=3 CMD /health.sh

# allow derieved images to overwrite the language
ONBUILD ARG lang
ONBUILD ENV LANG=${lang:-${LANG}}
