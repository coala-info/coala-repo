[Autometa](index.html)

latest

* [Getting Started](getting-started.html)
* [🍏 Nextflow Workflow 🍏](nextflow-workflow.html)
* [🐚 Bash Workflow 🐚](bash-workflow.html)
* [📓 Bash Step by Step Tutorial 📓](bash-step-by-step-tutorial.html)
* [Databases](databases.html)
* [Examining Results](examining-results.html)
* [Benchmarking](benchmarking.html)
* Installation
  + [Direct installation (Quickest)](#direct-installation-quickest)
  + [Install from source (using make)](#install-from-source-using-make)
  + [Install from source (full commands)](#install-from-source-full-commands)
  + [Building the Docker image](#building-the-docker-image)
  + [Testing Autometa](#testing-autometa)
* [Autometa Python API](autometa-python-api.html)
* [Usage](scripts/usage.html)
* [How to contribute](how-to-contribute.html)
* [Autometa modules](Autometa_modules/modules.html)
* [Legacy Autometa](legacy-autometa.html)
* [License](license.html)

[Autometa](index.html)

* Installation
* [Edit on GitHub](https://github.com/KwanLab/Autometa/blob/main/docs/source/installation.rst)

---

# Installation[](#installation "Permalink to this heading")

Currently Autometa package installation is supported by [mamba](https://mamba.readthedocs.io/en/latest/index.html), and [docker](https://www.docker.com/).
For installation using mamba, download mamba from [Mambaforge](https://github.com/conda-forge/miniforge#mambaforge).

Attention

If you are only trying to run the Autometa workflow, you should start at [Getting Started](getting-started.html#getting-started) before proceeding.

## Direct installation (Quickest)[](#direct-installation-quickest "Permalink to this heading")

1. Install [mamba](https://mamba.readthedocs.io/en/latest/index.html)

   > ```
   > wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
   > bash Mambaforge-$(uname)-$(uname -m).sh
   > ```
   >
   > Follow the installation prompts and when you get to this:
   >
   > ```
   > Do you wish the installer to initialize Mambaforge
   > by running conda init? [yes|no]
   > [no] >>> yes
   > ```
   >
   > This will require restarting the terminal, or resetting
   > the terminal with the source command
   >
   > ```
   > # To resolve the comment:
   > # ==> For changes to take effect, close and re-open your current shell. <==
   > # type:
   > source ~/.bashrc
   > ```
   >
   > Note
   >
   > If you already have conda installed, you can install mamba as a drop-in replacement.
   >
   > ```
   > conda -n base -c conda-forge mamba -y
   > ```
2. Create a new environment with `autometa` installed:

   > ```
   > mamba create -c conda-forge -c bioconda -n autometa autometa
   > ```
   >
   > Note
   >
   > You may add the `bioconda` and `conda-forge` channels to your mamba
   > config to simplify the command.
   >
   > ```
   > mamba config --append channels bioconda
   > mamba config --append channels conda-forge
   > ```
   >
   > Now mamba will search the `bioconda` and `conda-forge`
   > channels alongside the defaults channel.
   >
   > ```
   > mamba create -n autometa autometa
   > ```
3. Activate `autometa` environment:

   > ```
   > mamba activate autometa
   > ```

## Install from source (using make)[](#install-from-source-using-make "Permalink to this heading")

Download and install [mamba](https://mamba.readthedocs.io/en/latest/index.html). Now run the following commands:

```
# Navigate to the directory where you would like to clone Autometa
cd $HOME

# Clone the Autometa repository
git clone https://github.com/KwanLab/Autometa.git

# Navigate into the cloned repository
cd Autometa

# create autometa mamba environment
make create_environment

# activate autometa mamba environment
mamba activate autometa

# install autometa source code in autometa environment
make install
```

Note

You can see a list of all available make commands by running `make` without any other arguments.

## Install from source (full commands)[](#install-from-source-full-commands "Permalink to this heading")

Download and install [mamba](https://mamba.readthedocs.io/en/latest/index.html). Now run the following commands:

```
# Navigate to the directory where you would like to clone Autometa
cd $HOME

# Clone the Autometa repository
git clone https://github.com/KwanLab/Autometa.git

# Navigate into the cloned repository
cd Autometa

# Construct the autometa environment from autometa-env.yml
mamba env create --file=autometa-env.yml

# Activate environment
mamba activate autometa

# Install the autometa code base from source
python -m pip install . --ignore-installed --no-deps -vv
```

## Building the Docker image[](#building-the-docker-image "Permalink to this heading")

You can build a docker image for your clone of the Autometa repository.

1. Install [Docker](https://www.docker.com/)
2. Run the following commands

```
# Navigate to the directory where you need to clone Autometa
cd $HOME

# Clone the Autometa repository
git clone https://github.com/KwanLab/Autometa.git

# Navigate into the cloned repository
cd Autometa

# This will tag the image as jasonkwan/autometa:<your current branch>
make image

# (or the full command from within the Autometa repo)
docker build . -t jasonkwan/autometa:`git branch --show-current`
```

## Testing Autometa[](#testing-autometa "Permalink to this heading")

You can also check the installation using autometa’s built-in unit tests.
This is not at all necessary and is primarily meant for development and debugging purposes.
To run the tests, however, you’ll first need to install the following packages and download the test dataset.

```
# Activate your autometa mamba environment
mamba activate autometa

# List all make options
make

# Install dependencies for test environment
make test_environment

# Download test_data.json for unit testing to tests/data/
make unit_test_data_download
```

You can now run different unit tests using the following commands:

```
# Run all unit tests
make unit_test

# Run unit tests marked with entrypoint
make unit_test_entrypoints

# Run unit tests marked with WIP
make unit_test_wip
```

Note

As a shortcut you can also create the test environment and run **all** the unit tests using `make unit_test` command.

For more information about the above commands see the Contributing Guidelines page.
Additional unit tests are provided in the test directory. These are designed to aid in future development of autometa.

[Previous](benchmarking.html "Benchmarking")
[Next](autometa-python-api.html "Autometa Python API")

---

© Copyright 2016 - 2024, Ian J. Miller, Evan R. Rees, Izaak Miller, Shaurya Chanana, Siddharth Uppal, Kyle Wolf, Jason C. Kwan.
Revision `0d9028cf`.
Last updated on Jun 14, 2024.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).