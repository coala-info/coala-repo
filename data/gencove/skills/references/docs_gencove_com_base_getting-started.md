[ ]
[ ]

[Skip to content](#getting-started)

[![logo](../../img/iso-gencove@2x.svg)](../.. "Gencove Docs")

Gencove Docs

Getting Started

Initializing search

[![logo](../../img/iso-gencove@2x.svg)](../.. "Gencove Docs")
Gencove Docs

* [x]

  Gencove Base

  Gencove Base
  + [ ]

    Getting Started

    [Getting Started](./)

    Table of contents
    - [Gencove data](#gencove-data)
    - [Quickstart](#quickstart)
    - [Video demo](#video-demo)
    - [Setup](#setup)

      * [Installation](#installation)
      * [Configuring the CLI host](#configuring-the-cli-host)
      * [Mac OS notes](#mac-os-notes)
      * [Configuration](#configuration)
  + [ ]

    Analysis

    Analysis
    - [ ]

      Upload files

      Upload files
      * [FASTQs](../analysis/fastq-files/my-fastqs/)
      * [CRAMs](../analysis/fastq-files/crams/)
      * [Listing uploads](../analysis/fastq-files/listing-uploads/)
      * [Uploading using the CLI](../analysis/fastq-files/uploading-using-the-cli/)
      * [Uploading using S3](../analysis/fastq-files/uploading-using-s3/)
      * [Uploading using BaseSpace](../analysis/fastq-files/uploading-using-basespace/)
    - [ ]

      Projects

      Projects
      * [Introduction](../analysis/projects/introduction/)
      * [Creating projects](../analysis/projects/creating-projects/)
      * [Data analysis configuration](../analysis/projects/data-analysis-configurations/)
      * [Hiding projects](../analysis/projects/hiding-projects/)
      * [Listing projects](../analysis/projects/listing-projects/)
      * [Listing pipeline capabilities](../analysis/projects/listing-pipeline-capabilities/)
      * [Listing pipelines](../analysis/projects/listing-pipelines/)
      * [Deleting projects](../analysis/projects/deleting-projects/)
      * [Sharing projects](../analysis/projects/sharing-projects/)
    - [ ]

      Samples

      Samples
      * [Introduction](../analysis/samples/introduction/)
      * [Hiding samples](../analysis/samples/hiding-samples/)
      * [Listing samples](../analysis/samples/listing-samples/)
      * [Downloading deliverables](../analysis/samples/downloading-deliverables/)
      * [Sample metadata and files](../analysis/samples/sample-metadata-and-files/)
      * [Importing existing samples to another project](../analysis/samples/importing-existing-samples-to-another-project/)
      * [Copying existing samples to another project](../analysis/samples/copying-existing-samples-to-another-project/)
      * [Canceling samples](../analysis/samples/cancel-samples/)
      * [Deleting samples](../analysis/samples/deleting-samples/)
    - [Reference Genome](../analysis/reference-genome/)
    - [Merged VCF file](../analysis/merged-vcf-file/)
    - [Backwards-compatible array deliverables](../analysis/backwards-compatible-array-deliverables/)
    - [Retrieving reports](../analysis/retrieving-reports/)
    - [Project sample manifests](../analysis/project-sample-manifests/)
    - [Event Notifications](../analysis/event-notifications/)
    - [The Gencove Archive](../analysis/the-gencove-archive/)
  + [Permissions](../permissions/)
  + [Billing](../billing/)
  + [Consumer Reports](../consumer-reports/)
  + [Kit Ordering](../kit-ordering/)
  + [API Reference](../api-reference/)
  + [CLI Reference](../cli-reference/)
  + [Base FAQ](../faq/)
* [ ]

  Gencove Explorer

  Gencove Explorer
  + [Introduction](../../explorer/introduction/)
  + [Demo notebooks](../../explorer/demo_notebooks/)
  + [Running analyses](../../explorer/running_analyses/)
  + [Storage](../../explorer/storage/)
  + [Querying](../../explorer/query/)
  + [ ]

    Shortcuts

    Shortcuts
    - [Overview](../../explorer/shortcuts/overview/)
    - [VCF Management](../../explorer/shortcuts/vcfs/)
    - [IGV](../../explorer/shortcuts/igv/)
    - [Data Export](../../explorer/shortcuts/data_export/)
    - [Relatedness](../../explorer/shortcuts/relatedness/)
  + [Installing packages and software](../../explorer/installing_packages_and_software/)
  + [Instance management](../../explorer/instance_management/)
  + [SDK Reference](../../explorer/reference/)
  + [Explorer FAQ](../../explorer/faq/)
* [ ]

  General

  General
  + [Support](../../general/support/)
  + [Terms](../../general/terms/)
  + [Gencove homepage](https://gencove.com)

Table of contents

* [Gencove data](#gencove-data)
* [Quickstart](#quickstart)
* [Video demo](#video-demo)
* [Setup](#setup)

  + [Installation](#installation)
  + [Configuring the CLI host](#configuring-the-cli-host)
  + [Mac OS notes](#mac-os-notes)
  + [Configuration](#configuration)

# Getting Started[¶](#getting-started "Permanent link")

Welcome to the [Gencove](https://gencove.com) Base docs!

For Gencove Explorer analysis cloud documentation, see [here](../../explorer/introduction/).

![Gencove systems](/img/docs-base.png)

Gencove Base makes it easy to:

1. upload low-pass sequencing FASTQ files to the Gencove analysis pipeline
2. download analysis results
3. track sample status
4. automate data delivery.

Read on to get started and try out the examples on the side along the way.

## Gencove data[¶](#gencove-data "Permanent link")

Genomic data is organized into "projects". Each project contains "samples".
Each sample has an `id` (generated by Gencove) and `client_id`
(provided to Gencove by clients).

In most cases, a user account and project will be created for you by our
team.

In case you would like to explore the Gencove data delivery dashboard, feel
free to create an account and explore as follows:

1. Create a free Gencove account using the
   [dashboard](https://web.gencove.com)
2. Create a project by going to My Projects -> Add new project

## Quickstart[¶](#quickstart "Permanent link")

```
$ pip install gencove
$ gencove upload <local-directory-path>
```

Install the Gencove CLI using the Python package manager `pip`
and upload files to your Gencove account.

Alternatively, if you have [uv available](https://docs.astral.sh/uv/getting-started/installation/) on your system, you can invoke `uvx` to easily use the Gencove CLI. This will bypass the need for creating a virtual environment or for installing Python on your system.

```
$ uvx gencove upload <local-directory-path>
```

For more detailed installation instructions, please see the Installation section below.

## Video demo[¶](#video-demo "Permanent link")

## Setup[¶](#setup "Permanent link")

### Installation[¶](#installation "Permanent link")

```
$ pip install gencove
```

Note

Gencove CLI is compatible with Python versions 3.8 and above.
Please note that Python 3.7 has reached its end of life,
and we highly recommend upgrading to a supported version.

The Gencove CLI can be installed using the Python package manager `pip`.
The source code is mirrored to a public repository on
[GitHub](https://github.com/gncv/gencove-cli).

Python 3 and pip are commonly available on many operating systems. In
case you do need to install Python 3, straightforward instructions are available
[here](https://docs.python-guide.org/starting/installation/).

In production environments, we highly recommend using [virtualenv](https://virtualenv.pypa.io/en/latest/)
and/or [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/)
for installing the Gencove CLI in a dedicated Python environment.

### Configuring the CLI host[¶](#configuring-the-cli-host "Permanent link")

The Gencove platform is deployed across several geographical locations to accommodate users across the world. When using the CLI, the `--host` option can be configured to point to an alternative environment. Users can find their respective environment by checking the URL used to access the web UI, which follows the format `web.<env>.gencove.com`.

For example, if you are using the EU environment, you must configure your CLI commands as follows:

```
$ gencove <command> <options> --host https://api.eu1.gencove.com <args>
```

To upload a directory to Gencove on the EU host:

```
$ gencove upload /home/gencove/reads --host https://api.eu1.gencove.com --api-key GENCOVE_API_KEY
```

### Mac OS notes[¶](#mac-os-notes "Permanent link")

Due to a [known issue](https://github.com/pypa/pip/issues/3165) with Python that ships
with Mac OS, the Gencove CLI should be installed in the user's home directory (not
system-wide) as follows: `pip install --user gencove`. Make sure to have `~/bin` present
in your `$PATH` environment variable.

For advanced users, we highly recommend [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/)
and installing the Gencove CLI within a dedicated virtualenv.

If you absolutely must install the Gencove CLI system-wide using `sudo`, the following
command can be used as a last resort: `sudo pip install gencove --ignore-installed six`.

### Configuration[¶](#configuration "Permanent link")

Your credentials can be provided to the Gencove CLI via environment variables:

* `$GENCOVE_API_KEY`
  + API keys can be generated and revoked using the Gencove Dashboard under Account
    Settings -> API Keys
* `$GENCOVE_EMAIL` and `$GENCOVE_PASSWORD`

Please note that you cannot use `$GENCOVE_EMAIL`+`$GENCOVE_PASSWORD` and
`$GENCOVE_API_KEY` at the same time.

API keys can also be used to authenticate with the API directly by setting the
`Authorization` HTTP header to `Api-Key <your-api-key>`.

Note

If MFA (multi-factor authentication) is enabled in the account and you use email and password credentials,
an MFA token will be requested in the terminal after the command is submitted.

If an API key is used instead, no other token is necessary.

Back to top

[Next
FASTQs](../analysis/fastq-files/my-fastqs/)