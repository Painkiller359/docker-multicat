# syntax=docker/dockerfile:1

FROM debian:10 AS build
RUN DEBIAN_FRONTEND=noninteractive apt update && DEBIAN_FRONTEND=noninteractive apt install -y gcc make git
WORKDIR /root/
RUN git clone https://github.com/videolan/bitstream && cd bitstream && make && make install
RUN git clone https://github.com/videolan/multicat && cd multicat && make

FROM scratch AS export
COPY --from=build /root/multicat/multicat .
COPY --from=build /root/multicat/multilive .
