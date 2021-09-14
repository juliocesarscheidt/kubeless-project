# install requirements
FROM python:3.6-alpine AS build

WORKDIR /usr/src/app

COPY requirements.txt .
RUN pip install -r \
    requirements.txt --no-cache-dir

COPY ./src/ ./

CMD [ "python", "-u", "main.py" ]
