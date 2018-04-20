FROM alpine:latest AS build
ARG VERSION="0.8.11"
WORKDIR /build
RUN apk --update add --virtual build-dependendencies \           
wget make gcc libc-dev libnetfilter_log-dev
RUN wget https://github.com/z3APA3A/3proxy/archive/$VERSION.tar.gz \                                                             
-O /tmp/src.tar.gz
RUN tar -xf /tmp/src.tar.gz -C ./
RUN cd "3proxy-$VERSION" \
&& make -f Makefile.Linux \
&& cp src/3proxy /build/

FROM alpine:latest
COPY --from=build /build/3proxy /usr/local/bin/
USER nobody
CMD /usr/local/bin/3proxy /etc/3proxy/3proxy.conf
