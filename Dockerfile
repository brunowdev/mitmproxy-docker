FROM mitmproxy/mitmproxy

COPY ca-fixed/ home/mitmproxy/.mitmproxy

RUN chmod 777 home/mitmproxy/.mitmproxy/*.pem

CMD ["mitmproxy"]