Cromwell Tools

latest

Overview

* [Cromwell-tools](README_SYMLINK.html)

Tutorials

* [Cromwell-tools Python API Quickstart](Tutorials/Quickstart/api_quickstart.html)
* [Cromwell-tools Command Line Interface Quickstart](Tutorials/Quickstart/cli_quickstart.html)

API Documentation

* [API Documentation](API/index.html)

Cromwell Tools

* Docs »
* Cromwell-tools documentation
* [Edit on GitHub](https://github.com/broadinstitute/cromwell-tools/blob/master/docs/index.rst)

---

# Cromwell-tools documentation[¶](#cromwell-tools-documentation "Permalink to this headline")

Overview

* [Cromwell-tools](README_SYMLINK.html)
  + [Overview](README_SYMLINK.html#overview)
  + [Installation](README_SYMLINK.html#installation)
  + [Usage](README_SYMLINK.html#usage)
    - [Python API](README_SYMLINK.html#python-api)
    - [Commandline Interface](README_SYMLINK.html#commandline-interface)
  + [Testing](README_SYMLINK.html#testing)
    - [Run Tests with Docker](README_SYMLINK.html#run-tests-with-docker)
    - [Run Tests with local Python environment](README_SYMLINK.html#run-tests-with-local-python-environment)
  + [Development](README_SYMLINK.html#development)
    - [Code Style](README_SYMLINK.html#code-style)
    - [Dependencies](README_SYMLINK.html#dependencies)
    - [Documentation](README_SYMLINK.html#documentation)
    - [Publish on PyPI](README_SYMLINK.html#publish-on-pypi)
  + [Contribute](README_SYMLINK.html#contribute)

Tutorials

* [Cromwell-tools Python API Quickstart](Tutorials/Quickstart/api_quickstart.html)
  + [Standard Authentication](Tutorials/Quickstart/api_quickstart.html#Standard-Authentication)
    - [1. [Recommended] Authenticate with Cromwell using the standardized method](Tutorials/Quickstart/api_quickstart.html#1.-[Recommended]-Authenticate-with-Cromwell-using-the-standardized-method)
    - [2. Authenticate with Cromwell using HTTPBasicAuth (username and password)](Tutorials/Quickstart/api_quickstart.html#2.-Authenticate-with-Cromwell-using-HTTPBasicAuth-(username-and-password))
    - [3. Authenticate with Cromwell using HTTPBasicAuth (secret JSON file)](Tutorials/Quickstart/api_quickstart.html#3.-Authenticate-with-Cromwell-using-HTTPBasicAuth-(secret-JSON-file))
    - [4. Authenticate with Cromwell using OAuth (service account JSON key file)](Tutorials/Quickstart/api_quickstart.html#4.-Authenticate-with-Cromwell-using-OAuth-(service-account-JSON-key-file))
    - [5. Authenticate with Cromwell with no Auth](Tutorials/Quickstart/api_quickstart.html#5.-Authenticate-with-Cromwell-with-no-Auth)
  + [Submit jobs to Cromwell/Cromwell-as-a-Service](Tutorials/Quickstart/api_quickstart.html#Submit-jobs-to-Cromwell/Cromwell-as-a-Service)
  + [Query jobs in Cromwell/Cromwell-as-a-Service](Tutorials/Quickstart/api_quickstart.html#Query-jobs-in-Cromwell/Cromwell-as-a-Service)
    - [Get the workflows](Tutorials/Quickstart/api_quickstart.html#Get-the-workflows)
  + [Submit jobs with On Hold in Cromwell/Cromwell-as-a-Service](Tutorials/Quickstart/api_quickstart.html#Submit-jobs-with-On-Hold-in-Cromwell/Cromwell-as-a-Service)
    - [Submit the job](Tutorials/Quickstart/api_quickstart.html#Submit-the-job)
    - [Check the status of the job](Tutorials/Quickstart/api_quickstart.html#Check-the-status-of-the-job)
    - [Release the job](Tutorials/Quickstart/api_quickstart.html#Release-the-job)
* [Cromwell-tools Command Line Interface Quickstart](Tutorials/Quickstart/cli_quickstart.html)
  + [Basic usage](Tutorials/Quickstart/cli_quickstart.html#Basic-usage)
    - [Verify the installation](Tutorials/Quickstart/cli_quickstart.html#Verify-the-installation)
    - [Check all of the available commands and help text](Tutorials/Quickstart/cli_quickstart.html#Check-all-of-the-available-commands-and-help-text)
  + [Standard Authentication](Tutorials/Quickstart/cli_quickstart.html#Standard-Authentication)
    - [Authenticate with Cromwell using HTTPBasicAuth (username and password)](Tutorials/Quickstart/cli_quickstart.html#Authenticate-with-Cromwell-using-HTTPBasicAuth-(username-and-password))
    - [Authenticate with Cromwell using HTTPBasicAuth (secret JSON file)](Tutorials/Quickstart/cli_quickstart.html#Authenticate-with-Cromwell-using-HTTPBasicAuth-(secret-JSON-file))
    - [Authenticate with Cromwell using OAuth (Google Cloud service account JSON key file)](Tutorials/Quickstart/cli_quickstart.html#Authenticate-with-Cromwell-using-OAuth-(Google-Cloud-service-account-JSON-key-file))
    - [Authenticate with Cromwell with no Auth](Tutorials/Quickstart/cli_quickstart.html#Authenticate-with-Cromwell-with-no-Auth)
  + [Explain the arguments and the `submit` command](Tutorials/Quickstart/cli_quickstart.html#Explain-the-arguments-and-the-submit-command)
    - [Using short optional arguments](Tutorials/Quickstart/cli_quickstart.html#Using-short-optional-arguments)
    - [Workflow labels and options](Tutorials/Quickstart/cli_quickstart.html#Workflow-labels-and-options)
    - [Using URLs as the file paths](Tutorials/Quickstart/cli_quickstart.html#Using-URLs-as-the-file-paths)
  + [The `wait` command](Tutorials/Quickstart/cli_quickstart.html#The-wait-command)
  + [Other commands](Tutorials/Quickstart/cli_quickstart.html#Other-commands)

API Documentation

* [API Documentation](API/index.html)
  + [cromwell\_tools.cromwell\_api](API/index.html#module-cromwell_tools.cromwell_api)
  + [cromwell\_tools.cromwell\_auth](API/index.html#module-cromwell_tools.cromwell_auth)
  + [cromwell\_tools.utilities](API/index.html#module-cromwell_tools.utilities)
  + [cromwell\_tools.cli](API/index.html#module-cromwell_tools.cli)

[Next](README_SYMLINK.html "Cromwell-tools")

---

© Copyright 2018, Mint Team
Revision `fb1753dd`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).