FROM alpine as builder

RUN apk update && apk upgrade
RUN apk add --update alpine-sdk linux-headers zlib-dev openssl-dev gperf cmake
RUN mkdir -p /tg/build
ADD . /tg
RUN cd /tg/build && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. ..
RUN cmake --build /tg/build --target install

FROM alpine
COPY --from=builder /tg/bin/telegram-bot-api /
ENTRYPOINT [ "/telegram-bot-api" ]