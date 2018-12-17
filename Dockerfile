FROM mwaeckerlin/very-base
MAINTAINER mwaeckerlin

# change in childern:
ENV CONTAINERNAME     "base"

# derieved images must have a /start.sh command as entrypoint
ONBUILD ADD start.sh /start.sh
ONBUILD CMD ["/start.sh"]

# derieved images should have a health check script at /health.sh
#ONBUILD ADD health.sh /health.sh
#ONBUILD HEALTHCHECK --interval=60s --timeout=10s --start-period=600s --retries=3 CMD /health.sh

# allow derieved images to overwrite the language
ONBUILD ARG lang
ONBUILD ENV LANG=${lang:-${LANG}}
