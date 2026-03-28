[ ]
[ ]

[Skip to content](#option-1-install-via-bioconda-recommended)

[![logo](images/WEPP_icon.png)](index.html "WEPP")

WEPP

Install

Initializing search

[TurakhiaLab/WEPP](https://github.com/TurakhiaLab/WEPP "Go to repository")

* [Home](index.html)
* [Install](install.html)
* [Quick Start](quickstart.html)
* [User Guide](usage.html)
* [Contributions](contribution.html)
* [Cite WEPP](cite.html)

[![logo](images/WEPP_icon.png)](index.html "WEPP")
WEPP

[TurakhiaLab/WEPP](https://github.com/TurakhiaLab/WEPP "Go to repository")

* [Home](index.html)
* [ ]

  Install

  [Install](install.html)

  Table of contents
  + [Option-1: Install via Bioconda (Recommended)](#option-1-install-via-bioconda-recommended)
  + [Option-2: Install via DockerHub](#option-2-install-via-dockerhub)
  + [Option-3: Install via Dockerfile](#option-3-install-via-dockerfile)
  + [Option-4: Install via Shell Commands (requires sudo access)](#option-4-install-via-shell-commands-requires-sudo-access)
* [Quick Start](quickstart.html)
* [User Guide](usage.html)
* [Contributions](contribution.html)
* [Cite WEPP](cite.html)

# Install

WEPP offers multiple installation methods.

1. Bioconda (Recommended)
2. Docker image from DockerHub
3. Dockerfile
4. Shell Commands

## **Option-1: Install via Bioconda (Recommended)**

**Step 1:** Create a new conda environment for WEPP.

```
conda create --name wepp-env
conda activate wepp-env
conda config --env --add channels bioconda
conda config --env --add channels conda-forge
conda config --env --set channel_priority flexible
conda install wepp
```

Note

⚠️You can use `conda install wepp --solver=libmamba` to enable a faster dependency resolution and installation.

**Step 2:** Confirm proper working by running the following command. This should print WEPP's help menu.

```
run-wepp help --cores 1 --use-conda
```

**Step 3:** Create a `data` directory and start analyzing your samples with WEPP. If you are running samples from multiple `data` directories, specify the `.snakemake` directory created in one run as the `--conda-prefix` for the others to avoid redundant creation of Snakemake conda environments.

All set to try the [examples](quickstart.html#example).

## **Option-2: Install via DockerHub**

The Docker image includes all dependencies required to run WEPP.

**Step 1:** Get the image from DockerHub

```
docker pull pranavgangwar/wepp:latest
```

**Step 2:** Start and run Docker container. The command below will take you inside the docker container with WEPP already installed.

```
# -p <host_port>:<container_port> → Maps container port to a port on your host (Accessing Dashboard, NOT needed otherwise)
# Replace <host_port> with your desired local port (e.g., 80 or 8080)
# Use this command if your datasets can be downloaded from the Web
docker run -it -p 80:80 pranavgangwar/wepp:latest

# Use this command if your datasets are present in your current directory
docker run -it -p 80:80 -v "$PWD":/WEPP -w /WEPP pranavgangwar/wepp:latest
```

**Step 3:** Confirm proper working by running the following command. This should print WEPP's help menu.

```
run-wepp help --cores 1 --use-conda
```

All set to try the [examples](quickstart.html#example).

Note

⚠️The Docker image is currently built for the `linux/amd64` platform. While it can run on `arm64` systems (e.g., Apple Silicon or Linux aarch64) via emulation, this may lead to reduced performance.

## **Option-3: Install via Dockerfile**

The Dockerfile contains all dependencies required to run WEPP.

**Step 1:** Clone the repository

```
git clone --recurse-submodules https://github.com/TurakhiaLab/WEPP.git
cd WEPP
chmod +x run-wepp
```

**Step 2:** Build a Docker Image

```
cd docker
docker build -t wepp .
cd ..
```

**Step 3:** Start and run Docker container. The command below will take you inside the docker container with the view of the current directory.

```
# -p <host_port>:<container_port> → Maps container port to a port on your host (Accessing Dashboard, NOT needed otherwise)
# Replace <host_port> with your desired local port (e.g., 80 or 8080)
docker run -it -p 80:80 -v "$PWD":/workspace -w /workspace wepp
```

All set to try the [examples](quickstart.html#example).

## **Option-4: Install via Shell Commands (requires sudo access)**

Users without sudo access are advised to install WEPP via [Docker Image](#dockerhub).

**Step 1:** Clone the repository

```
git clone --recurse-submodules https://github.com/TurakhiaLab/WEPP.git
cd WEPP
chmod +x run-wepp
```

**Step 2:** Update `~/.bashrc` for linux or `~/.zshrc` for macOS

```
echo "
run-wepp() {
    snakemake -s $PWD/workflow/Snakefile \"\$@\"
}
export -f run-wepp
" >> ~/.bashrc

source ~/.bashrc
```

**Step 3:** Install dependencies (might require sudo access)
WEPP depends on the following common system libraries, which are typically pre-installed on most development environments:

```
- wget
- curl
- pip
- build-essential
- python3-pandas
- pkg-config
- zip
- cmake
- libtbb-dev
- libprotobuf-dev
- protobuf-compiler
- libopenmpi-dev
- snakemake
- conda
- nodejs(v18+)
- nginx
```

For Ubuntu users with sudo access, if any of the required libraries are missing, you can install them with:

```
sudo apt-get update
sudo apt-get install -y wget pip curl python3-pip build-essential python3-pandas pkg-config zip cmake libtbb-dev libprotobuf-dev protobuf-compiler snakemake nginx
```

Note: WEPP expects the `python` command to be available. If your system only provides python3, you can optionally set up a symlink:

```
update-alternatives --install /usr/bin/python python /usr/bin/python3 1
```

If you do not have Node.js v18 or higher installed, follow these steps to install Node.js v22:

```
# Update and install prerequisites
apt-get install -y curl gnupg ca-certificates

# Add NodeSource Node.js 22 repo
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -

# Install Node.js 22
apt-get install -y nodejs
```

```
# Install Yarn package manager globally
npm install -g yarn
```

If your system doesn't have Conda, you can install it with:

```
wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/download/24.11.3-2/Miniforge3-24.11.3-2-Linux-x86_64.sh"
bash Miniforge3.sh -b -p "${HOME}/conda"

source "${HOME}/conda/etc/profile.d/conda.sh"
source "${HOME}/conda/etc/profile.d/mamba.sh"
```

All set to try the [examples](quickstart.html#example).

[Previous

Home](index.html)
[Next

Quick Start](quickstart.html)

© 2025 [Turakhia Lab](https://github.com/TurakhiaLab)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)