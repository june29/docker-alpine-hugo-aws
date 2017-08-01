FROM alpine:3.6
MAINTAINER Chris Baker <cgbaker@cgbaker.net>

ENV HUGO_VERSION 0.25.1
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit

# Install AWS tools as well
RUN mkdir -p /aws
# Install pygments (for syntax highlighting) and bash
RUN apk update && \
    apk add py-pygments && \
    apk add bash git && \
    apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm -rf /var/cache/apk/*

# Download and Install hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /tmp/hugo
RUN cp /tmp/hugo/hugo /usr/local/bin/ && rm -rf /tmp/hugo

EXPOSE 1313
CMD hugo version
