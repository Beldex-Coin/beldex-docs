FROM python:3

LABEL user = "mohammed.niyas@beldex.org"

# Create a working directory 
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . .

# installing dependencies
RUN pip install mkdocs
RUN pip install mkdocs-material

EXPOSE 8000

CMD ["mkdocs", "serve"]