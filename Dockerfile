FROM python:3.6.1
COPY ./code/requirements.txt /code/requirements.txt
WORKDIR /code
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
COPY ./code /code
