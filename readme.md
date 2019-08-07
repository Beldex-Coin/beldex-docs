# Beldex Docs
To view documentation please visit https://docs.beldex.io

Any changes made to this repository will be auto-propagated to the Beldex-docs website.

## Building from source

clone repo, install dependencies and build the docs:
``` 
$ git clone https://github.com/beldex-coin/Beldex-docs
$ cd Beldex-docs
$ mkdocs build
```

## Run the application

```
$ mkdocs serve
```
    
## Run using docker

Clone the repo and rund the below command from the application folder

### Build docker image
```
$ docker build . -t beldex-docs
```

### Run docker image
```
$ docker run -p 8000:8000 beldex-docs:latest
```
