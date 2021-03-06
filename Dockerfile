FROM python:3.7.3
RUN mkdir -p /var/TestApp
ADD requirement.txt /var/TestApp/
RUN pip install --upgrade pip
RUN pip install uWSGI
RUN pip install -r /var/TestApp/requirement.txt
ENV UWSGI_HTTP_PORT=8000
ENV UWSGI_APP=app
RUN useradd -ms /bin/bash admin
USER admin
ADD app.py /var/TestApp/
ADD uwsgi.ini /var/TestApp/
WORKDIR /var/TestApp/
VOLUME /var/TestApp/
ENTRYPOINT ["uwsgi", "--ini", "/var/TestApp/uwsgi.ini"]
