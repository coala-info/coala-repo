[Cromwell Tools](../../index.html)

latest

Overview

* [Cromwell-tools](../../README_SYMLINK.html)

Tutorials

* [Cromwell-tools Python API Quickstart](api_quickstart.html)
* Cromwell-tools Command Line Interface Quickstart
  + [Basic usage](#Basic-usage)
    - [Verify the installation](#Verify-the-installation)
    - [Check all of the available commands and help text](#Check-all-of-the-available-commands-and-help-text)
  + [Standard Authentication](#Standard-Authentication)
    - [Authenticate with Cromwell using HTTPBasicAuth (username and password)](#Authenticate-with-Cromwell-using-HTTPBasicAuth-(username-and-password))
    - [Authenticate with Cromwell using HTTPBasicAuth (secret JSON file)](#Authenticate-with-Cromwell-using-HTTPBasicAuth-(secret-JSON-file))
    - [Authenticate with Cromwell using OAuth (Google Cloud service account JSON key file)](#Authenticate-with-Cromwell-using-OAuth-(Google-Cloud-service-account-JSON-key-file))
    - [Authenticate with Cromwell with no Auth](#Authenticate-with-Cromwell-with-no-Auth)
  + [Explain the arguments and the `submit` command](#Explain-the-arguments-and-the-submit-command)
    - [Using short optional arguments](#Using-short-optional-arguments)
    - [Workflow labels and options](#Workflow-labels-and-options)
    - [Using URLs as the file paths](#Using-URLs-as-the-file-paths)
  + [The `wait` command](#The-wait-command)
  + [Other commands](#Other-commands)

API Documentation

* [API Documentation](../../API/index.html)

[Cromwell Tools](../../index.html)

* [Docs](../../index.html) »
* Cromwell-tools Command Line Interface Quickstart
* [Edit on GitHub](https://github.com/broadinstitute/cromwell-tools/blob/master/docs/Tutorials/Quickstart/cli_quickstart.ipynb)

---

# Cromwell-tools Command Line Interface Quickstart[¶](#Cromwell-tools-Command-Line-Interface-Quickstart "Permalink to this headline")

This notebook will help you get familiar with the Cromwell-tools’ CLI (command line interface). After walking through this notebook, you should be able to work with Cromwell engine using the `cromwell-tools` command in your terminal.

## Basic usage[¶](#Basic-usage "Permalink to this headline")

### Verify the installation[¶](#Verify-the-installation "Permalink to this headline")

Once you successfully installed the `cromwell-tools`, you shall be bale to verify if the CLI is added to your available commands by:

```
[ ]:
```

```
%%bash

cromwell-tools --version
```

### Check all of the available commands and help text[¶](#Check-all-of-the-available-commands-and-help-text "Permalink to this headline")

You could check all of the available commands by:

```
[7]:
```

```
%%bash

cromwell-tools --help
```

```
usage: cromwell-tools [-h] [-V]
                      {submit,wait,status,abort,release_hold,query,health} ...

positional arguments:
  {submit,wait,status,abort,release_hold,query,health}
                        sub-command help
    submit              submit help
    wait                wait help
    status              status help
    abort               abort help
    release_hold        release_hold help
    query               query help
    health              health help

optional arguments:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
```

You could also check the detailed help message, for instance, to check the help message of `submit`, you could:

```
[8]:
```

```
%%bash

cromwell-tools submit --help
```

```
usage: cromwell-tools submit [-h] [--url URL] [--username USERNAME]
                             [--password PASSWORD]
                             [--secrets-file SECRETS_FILE]
                             [--service-account-key SERVICE_ACCOUNT_KEY] -w
                             WDL_FILE -i INPUTS_FILES [INPUTS_FILES ...]
                             [-d DEPENDENCIES [DEPENDENCIES ...]]
                             [-o OPTIONS_FILE] [-l LABEL_FILE]
                             [-c COLLECTION_NAME] [--on-hold ON_HOLD]
                             [--validate-labels VALIDATE_LABELS]

Submit a WDL workflow on Cromwell.

optional arguments:
  -h, --help            show this help message and exit
  --url URL             The URL to the Cromwell server. e.g.
                        "https://cromwell.server.org/"
  --username USERNAME   Cromwell username for HTTPBasicAuth.
  --password PASSWORD   Cromwell password for HTTPBasicAuth.
  --secrets-file SECRETS_FILE
                        Path to the JSON file containing username, password,
                        and url fields.
  --service-account-key SERVICE_ACCOUNT_KEY
                        Path to the JSON key file for authenticating with
                        CaaS.
  -w WDL_FILE, --wdl-file WDL_FILE
                        Path to the workflow source file to submit for
                        execution.
  -i INPUTS_FILES [INPUTS_FILES ...], --inputs-files INPUTS_FILES [INPUTS_FILES ...]
                        Path(s) to the input file(s) containing input data in
                        JSON format, separated by space.
  -d DEPENDENCIES [DEPENDENCIES ...], --deps-file DEPENDENCIES [DEPENDENCIES ...]
                        Path to the Zip file containing dependencies, or a
                        list of raw dependency files to be zipped together
                        separated by space.
  -o OPTIONS_FILE, --options-file OPTIONS_FILE
                        Path to the Cromwell configs JSON file.
  -l LABEL_FILE, --label-file LABEL_FILE
                        Path to the JSON file containing a collection of
                        key/value pairs for workflow labels.
  -c COLLECTION_NAME, --collection-name COLLECTION_NAME
                        Collection in SAM that the workflow should belong to,
                        if use CaaS.
  --on-hold ON_HOLD     Whether to submit the workflow in "On Hold" status.
  --validate-labels VALIDATE_LABELS
                        Whether to validate cromwell labels.
```

## Standard Authentication[¶](#Standard-Authentication "Permalink to this headline")

Cromwell-tools supports 4 types of authentication when talking to Cromwell:

* Authenticate with Cromwell using HTTPBasicAuth (username and password)
* Authenticate with Cromwell using HTTPBasicAuth (secret JSON file)
* Authenticate with Cromwell using OAuth (service account JSON key file)
* Authenticate with Cromwell with no Auth

As you might have noticed, most of the commands that cromwell-tools provides share a same set of auth-related arguments:

* `--url`
* `--username`
* `--password`
* `--secrets-file`
* `--service-account-key`

You would like to choose the right auth combinations depending on the Cromwell engine you work with.

### Authenticate with Cromwell using HTTPBasicAuth (username and password)[¶](#Authenticate-with-Cromwell-using-HTTPBasicAuth-(username-and-password) "Permalink to this headline")

Passing only the `--username` and `--password` besides the `--url` indicates that you want to authenticate with a HTTPBasicAuth-protected Cromwell:

```
[9]:
```

```
%%bash

cromwell-tools submit \
--url "https://cromwell.xxx.broadinstitute.org" \
--username "xxx" \
--password "xxx" \
--wdl "Examples/hello_world.wdl" \
--inputs-files "Examples/inputs.json" \
--deps-file "Examples/helloworld.wdl"
```

```
{"id":"d3dfa1a0-1134-46dc-9b29-335e645f3be9","status":"Submitted"}
```

### Authenticate with Cromwell using HTTPBasicAuth (secret JSON file)[¶](#Authenticate-with-Cromwell-using-HTTPBasicAuth-(secret-JSON-file) "Permalink to this headline")

Passing the username and password every time you run the command sounds like a burden. You could save the efforts by storing the HTTPBasic Authentication credentials as well as the cromwell URL into a JSON file (e.g. `secrets.json`) following the format:

```
{
    "url": "url",
    "username": "username",
    "password": "password"
}
```

Now you can pass the secret file path to the cromwell-tools:

```
[10]:
```

```
%%bash

cromwell-tools submit \
--secrets-file "secrets.json" \
--wdl "Examples/hello_world.wdl" \
--inputs-files "Examples/inputs.json" \
--deps-file "Examples/helloworld.wdl"
```

```
{"id":"25dc480d-6755-4b6b-b932-ded2ff634754","status":"Submitted"}
```

### Authenticate with Cromwell using OAuth (Google Cloud service account JSON key file)[¶](#Authenticate-with-Cromwell-using-OAuth-(Google-Cloud-service-account-JSON-key-file) "Permalink to this headline")

You could also use cromwell-tools to talk to a Crowmell that is using OAuth2. You will need to pass in the Service Account JSON key file to the `--service-account-key` argument. This file is usually generated by Google Cloud and downloaded from the Cloud console, which should have sufficient permission to talk to te OAuth-enbaled Cromwell.

Specifically, if you are working with Cromwell-as-a-Service (i.e. CaaS), you will need to specify `--collection-name` when submitting a workflow, which indicates a valid collection in [SAM](https://github.com/broadinstitute/sam) that the workflow should belong to.

Here is an example:

```
[11]:
```

```
%%bash

cromwell-tools submit \
--url "https://cromwell.caas-prod.broadinstitute.org" \
--service-account-key "/path/to/your/service-account-json-key.json" \
--collection-name "your-collection" \
--wdl "Examples/hello_world.wdl" \
--inputs-files "Examples/inputs.json" \
--deps-file "Examples/helloworld.wdl"
```

```
{"id":"a42e54ba-84e4-4305-be90-feeae33b7fc4","status":"Submitted"}
```

### Authenticate with Cromwell with no Auth[¶](#Authenticate-with-Cromwell-with-no-Auth "Permalink to this headline")

Sometimes you have to work with a Cromwell that does not have any authentication layer in front of it, no worries, just skip the auth arguments and fill the `--url`!

```
[9]:
```

```
%%bash

cromwell-tools submit \
--url "https://cromwell.xxx.broadinstitute.org" \
--wdl "Examples/hello_world.wdl" \
--inputs-files "Examples/inputs.json" \
--deps-file "Examples/helloworld.wdl"
```

```
{"id":"d3dfa1a0-1134-46dc-9b29-335e645f3be9","status":"Submitted"}
```

## Explain the arguments and the `submit` command[¶](#Explain-the-arguments-and-the-submit-command "Permalink to this headline")

### Using short optional arguments[¶](#Using-short-optional-arguments "Permalink to this headline")

You may have noticed that some of the arguments of `submit` have shorter versions, and yes, they are identical to their long counterparts: the following 2 examples are identical!

```
[11]:
```

```
%%bash

cromwell-tools submit \
--url "https://cromwell.caas-prod.broadinstitute.org" \
--service-account-key "/path/to/your/service-account-json-key.json" \
--collection-name "your-collection" \
--wdl "Examples/hello_world.wdl" \
--inputs-files "Examples/inputs.json" \
--deps-file "Examples/helloworld.wdl"
```

```
{"id":"a42e54ba-84e4-4305-be90-feeae33b7fc4","status":"Submitted"}
```

```
[11]:
```

```
%%bash

cromwell-tools submit \
--url "https://cromwell.caas-prod.broadinstitute.org" \
--service-account-key "/path/to/your/service-account-json-key.json" \
-c "your-collection" \
-w "Examples/hello_world.wdl" \
-i "Examples/inputs.json" \
-d "Examples/helloworld.wdl"
```

```
{"id":"a42e54ba-84e4-4305-be90-feeae33b7fc4","status":"Submitted"}
```

### Workflow labels and options[¶](#Workflow-labels-and-options "Permalink to this headline")

Workflow labels and options files are optional, you can pass the JSON files for your workflow when submitting:

```
[11]:
```

```
%%bash

cromwell-tools submit \
--url "https://cromwell.caas-prod.broadinstitute.org" \
--service-account-key "/path/to/your/service-account-json-key.json" \
--collection-name "your-collection" \
--wdl "Examples/hello_world.wdl" \
--inputs-files "Examples/inputs.json" \
--deps-file "Examples/helloworld.wdl" \
--label-file "Examples/options.json" \
--options-file "Examples/labels.json"
```

```
{"id":"a42e54ba-84e4-4305-be90-feeae33b7fc4","status":"Submitted"}
```

### Using URLs as the file paths[¶](#Using-URLs-as-the-file-paths "Permalink to this headline")

So far we have been passing the local (absolute or relative) paths as arguments, but we could also use HTTP/HTTPS paths, crowmell-tools will download and compose them for you:

```
[12]:
```

```
%%bash

cromwell-tools submit \
--url "https://cromwell.caas-prod.broadinstitute.org" \
--service-account-key "/path/to/your/service-account-json-key.json" \
--collection-name "your-collection" \
--wdl "https://raw.githubusercontent.com/broadinstitute/cromwell-tools/v2.0.0/notebooks/Quickstart/Examples/hello_world.wdl" \
--inputs-files "https://raw.githubusercontent.com/broadinstitute/cromwell-tools/v2.0.0/notebooks/Quickstart/Examples/inputs.json" \
--deps-file "https://raw.githubusercontent.com/broadinstitute/cromwell-tools/v2.0.0/notebooks/Quickstart/Examples/helloworld.wdl"
```

```
{"id":"13f7577a-c496-4770-8f3e-0f085f4edac0","status":"Submitted"}
```

## The `wait` command[¶](#The-wait-command "Permalink to this headline")

The `wait` command is a special command that helps polling and monitoring the workflow(s) in the Cromwell engine. You can use it to keep track of a list of workflows(they are NOT necessarily to be submitted by cromwell-tools!). By default `wait` will print verbose information while polling, but you can configure its behavior using the following arguemnts and flag(s):

* `--timeout-minutes`
* `--poll-interval-seconds`
* `--silent`

**Note: failure of one of the workflows will cause the whole polling process to be terminated, so please only poll one workflow if you are not sure if the workflow can succeed.**

```
[14]:
```

```
%%bash

cromwell-tools wait \
--url "https://cromwell.caas-prod.broadinstitute.org" \
--service-account-key "/path/to/your/service-account-json-key.json" \
--poll-interval-seconds 10 \
a42e54ba-84e4-4305-be90-feeae33b7fc4 \
13f7577a-c496-4770-8f3e-0f085f4edac0 \
d9d8dc18-d462-46f6-a39d-b68b20dfb5ab
```

```
--- polling from cromwell ---
Workflow a42e54ba-84e4-4305-be90-feeae33b7fc4 returned status Succeeded
Workflow 13f7577a-c496-4770-8f3e-0f085f4edac0 returned status Succeeded
All workflows succeeded!
```

## Other commands[¶](#Other-commands "Permalink to this headline")

You can check the available arugments of other commands by using `cromwell-tools COMMAND -h`, other commands are just simple mappings of the corresponding Cromwell endpoints. Note that the `query` command is not yet implemented in the CLI, please use the Python API client instead!

[Next](../../API/index.html "API Documentation")
 [Previous](api_quickstart.html "Cromwell-tools Python API Quickstart")

---

© Copyright 2018, Mint Team
Revision `fb1753dd`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).