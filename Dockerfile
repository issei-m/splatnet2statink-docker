FROM python:3.9-alpine3.14 as build

ARG SPLATNET2STATINK_VERSION="1.7.3"

RUN apk --update --no-cache add build-base zlib-dev jpeg-dev

RUN cd /tmp; wget https://github.com/frozenpandaman/splatnet2statink/archive/refs/tags/v$SPLATNET2STATINK_VERSION.tar.gz \
    && tar xzf v$SPLATNET2STATINK_VERSION.tar.gz \
    && mv /tmp/splatnet2statink-$SPLATNET2STATINK_VERSION /opt/app

WORKDIR /opt/app

RUN pip install -r requirements.txt

# Make sure *.pyc files have generated
RUN echo '{"api_key":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx","cookie":"","session_token":"","user_lang":"ja-JP"}' > config.txt \
    && ./splatnet2statink.py -h \
    && rm config.txt

# Cleanup
RUN rm .gitignore requirements.txt

FROM python:3.9-alpine3.14 as package

WORKDIR /opt/app

COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY entrypoint.sh /entrypoint.sh
COPY --from=build /opt/app /opt/app

ENV SPLATNET2STATINK_CONFIG=""

ENTRYPOINT ["/entrypoint.sh", "./splatnet2statink.py"]
