FROM python:3.6.0

RUN \
    apt-get update && \
    apt-get install -y supervisor nginx ca-certificates && \
    python3.6 -m pip install uwsgi

COPY ./manage.py /opt/playground/manage.py
COPY ./playground /opt/playground/playground
COPY ./requirements /opt/playground/requirements
COPY ./build/configs /opt/playground/configs/
COPY ./build/scripts /opt/playground/scripts/

RUN \
    rm -rf /etc/nginx/sites-enabled/* && \
    ln -s /opt/playground/configs/nginx.conf /etc/nginx/sites-enabled && \
    mkdir -p /var/log/playground/ && \
    chmod a+x /opt/playground/scripts/entrypoint.sh

RUN \
    python3.6 -m pip install -r /opt/playground/requirements/requirements.txt

COPY ./static /opt/playground/static

EXPOSE 80

ENTRYPOINT [ "/opt/playground/scripts/entrypoint.sh" ]
CMD ["service", "local"]
