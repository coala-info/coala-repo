# IDE Container: RStudio Server, Shiny Server, and More

#### 2025-10-30

# 1 Introduction

The goal of this [sevenbridges/sevenbridges-r](https://hub.docker.com/r/sevenbridges/sevenbridges-r/) Docker image is to provide

* Seven Bridges SDK environment that includes
  + Seven Bridges Platform command line uploader
  + Seven Bridges command line tools
  + R package sevenbridges with essential dependencies
* RStudio Server
* Shiny Server

# 2 Docker container

## 2.1 Build container locally

The `Dockerfile` is included with the package in `inst/docker` folder.

Here is the current content of `Dockerfile`:

```
fl <- system.file("docker/sevenbridges/", "Dockerfile", package = "sevenbridges")
cat(readLines(fl), sep = "\n")
```

```
FROM rocker/tidyverse

LABEL maintainer="soner.koc@sevenbridges.com"

## Install common dependencies
RUN apt-get update && apt-get install -y  \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    curl \
    libcairo2-dev \
    libxt-dev \
    unp \
    emacs \
    supervisor \
    libfuse-dev \
    gnupg
#   aufs-tools \
#   cgroupfs-mount

# RUN wget --no-verbose http://ftp.us.debian.org/debian/pool/main/l/lvm2/libdevmapper1.02.1_1.02.136-1_amd64.deb && \
#    dpkg -i libdevmapper1.02.1_1.02.136-1_amd64.deb && \
#    rm -f libdevmapper1.02.1_1.02.136-1_amd64.deb

# RUN wget --no-verbose http://ftp.us.debian.org/debian/pool/main/libt/libtool/libltdl7_2.4.6-2_amd64.deb && \
#    dpkg -i libltdl7_2.4.6-2_amd64.deb && \
#    rm -f libltdl7_2.4.6-2_amd64.deb

## Install Docker

RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates gnupg2 software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update -y \
    && apt-get install -y docker-ce

##################
# sevenbridges-r #
##################

# Install from GitHub instead of Bioconductor for the latest version
RUN Rscript -e "install.packages('BiocManager');\
    devtools::install_github('sbg/sevenbridges-r', repos = BiocManager::repositories(), build_vignettes = FALSE, dependencies = TRUE)"

#####################
# Seven Bridges SDK #
#####################

## Install SBG Rabix
RUN wget https://github.com/rabix/bunny/releases/download/v1.0.5-1/rabix-1.0.5.tar.gz \
    && tar -zvxf rabix-1.0.5.tar.gz \
    && ln -s  /rabix-cli-1.0.5/rabix /usr/local/bin/rabix

## Install SBG Command line uploader
# RUN wget https://igor.sbgenomics.com/sbg-uploader/sbg-uploader.tgz \
#     && tar zxvf sbg-uploader.tgz -C / \
#    && ln -s  /sbg-uploader/bin/sbg-uploader.sh /usr/local/bin/sbg-uploader.sh

## Install CGC Command line uploader
# RUN wget https://cgc.sbgenomics.com/cgc-uploader/cgc-uploader.tgz \
#    && tar zxvf cgc-uploader.tgz -C / \
#    && ln -s  /cgc-uploader/bin/cgc-uploader.sh /usr/local/bin/cgc-uploader.sh

## Copy command line interface and report templates needed
ADD src/runif.R /usr/local/bin/
RUN mkdir /report/
ADD report/report.Rmd /report/

## Install liftr and packrat
RUN Rscript -e "install.packages(c('liftr', 'packrat'), repos = 'https://cloud.r-project.org/')"

## (because --deps TRUE can fail when packages are added/removed from CRAN)
RUN rm -rf /var/lib/apt/lists/ \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

################
# Shiny Server #
################

## Thanks: rocker-org/shiny

## Download and install Shiny Server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O shiny-server-latest.deb && \
    gdebi -n shiny-server-latest.deb && \
    rm -f version.txt shiny-server-latest.deb

RUN Rscript -e "install.packages(c('shiny', 'rmarkdown', 'rsconnect'), repos = 'https://cloud.r-project.org/')"

RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

RUN mkdir /home/rstudio/ShinyApps/

RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /home/rstudio/ShinyApps/

EXPOSE 3838 8787

# COPY src/shiny-server.sh /usr/bin/shiny-server.sh
# RUN wget --no-verbos https://raw.githubusercontent.com/sbg/sevenbridges-r/master/inst/docker/sevenbridges/src/shiny-server.conf -P /etc/shiny-server/
# RUN wget --no-verbos https://raw.githubusercontent.com/sbg/sevenbridges-r/master/inst/docker/sevenbridges/src/supervisord.conf    -P /etc/shiny-server/
COPY src/shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY src/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

## set directory to `~/ShinyApps`
# RUN yes | /opt/shiny-server/bin/deploy-example user-dirs
# RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* ~/ShinyApps/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
# CMD ["/init;/usr/bin/shiny-server.sh"]
# CMD ["sh", "-c", "/usr/bin/shiny-server.sh;/init"]
```

You can simply build it locally, enter folder which contain that `Dockerfile`, in this case, it is under `inst/docker/sevenbridges`

```
docker build -t sevenbridges/sevenbridges-r .
```

## 2.2 Pull from Docker Hub

A hook is added to build the Docker image automatically from the [sevenbridges-r GitHub repository](https://github.com/sbg/sevenbridges-r/tree/master/inst/docker/sevenbridges). It is automatically built on [Docker Hub](https://hub.docker.com/r/sevenbridges/sevenbridges-r/). You can directly use this image `sevenbridges/sevenbridges-r`. Everytime a push is made in the GitHub repo, the Docker container is re-built.

# 3 Launch RStudio Server from Docker container

For example, you can ssh into your AWS instance, here I suppose you already have Docker installed, and pull the image

```
docker pull sevenbridges/sevenbridges-r
```

To launch sevenbridges RStudio Server image, I recommend you read this [tutorial](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image)

Or following the quick instruction here

```
docker run -d -p 8787:8787 sevenbridges/sevenbridges-r
docker run -d -p 8787:8787 -e USER=<username> -e PASSWORD=<password> rocker/rstudio
```

You will be able to access the RStudio in the browser by something like

`http://<your_ip_address>:8787`

Sometimes you want to add more users, to add users

```
## Enter the container
docker exec -it <container-id> bash
## Interactively input password and everything else
adduser <username>
```

## 3.1 Launch both RStudio Server and Shiny Server from the same Docker container

Sometimes it is very conventient to launch both RStudio Server and Shiny Server from a singel container and your users can manage to using RStudio Server and publish Shiny apps at the same time in the same container. To do so, just pull the same image and launch them at different port.

```
docker run  -d -p 8787:8787 -p 3838:3838 --name rstudio_shiny_server sevenbridges/sevenbridges-r
```

To mount file system you need to use `--privileged` with fuse.

```
docker run  --privileged -d -p 8787:8787 -p 3838:3838 --name rstudio_shiny_server sevenbridges/sevenbridges-r
```

check out the ip from docker machine if you are on mac os.

```
docker-machine ip default
```

In your browser, `http://<url>:8787/` for RStudio Server, for example, if 192.168.99.100 is what returned, visit `http://192.168.99.100:8787/` for RStudio Server.

For Shiny Server, **per user app** is hosted `http://<url>:3838/users/<username of rstudio>/<app_dir>`, for example, for user `rstudio` (a default user) and an app called `01_hello`, it will be `http://<url>:3838/users/rstudio/01_hello/`. To develop your Shiny app from RStudio Server, you can log into your RStudio Server with your username, and create a fold at home folder called `~/ShinyApps` and develop Shiny apps under that folder, for example, you can create an app called `02_text` at `~/ShinyApps/02_text/`.

Let’s try this, please log into your RStudio at `http://<url>:8787` now, then try to copy some example over to your home folder under `~/ShinyApps/`

```
dir.create("~/ShinyApps")
file.copy(
  "/usr/local/lib/R/site-library/shiny/examples/01_hello/",
  "~/ShinyApps/", recursive = TRUE
)
```

If you logged in with the username `rstudio`, then visit `http://192.168.99.100:3838/rstudio/01_hello` you should be able to see the hello example.

Note: Generic Shiny apps can also be hosted `http://<url>:3838/` or for particular app, `http://<url>:3838/<app_dir>` and inside the Docker container, it is hosted under `/srv/shiny-server/`.