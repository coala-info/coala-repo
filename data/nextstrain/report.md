# nextstrain CWL Generation Report

## nextstrain_build

### Tool Description
Runs a pathogen build in the Nextstrain build environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
- **Homepage**: https://nextstrain.org
- **Package**: https://anaconda.org/channels/bioconda/packages/nextstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nextstrain/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: nextstrain build [options] <directory> [...]
       nextstrain build --help

Runs a pathogen build in the Nextstrain build environment.

The build directory should contain a Snakefile, which will be run with
snakemake.

The default build environment is inside an ephemeral Docker container which has
all the necessary Nextstrain components available.  You may instead run the
build in the native ambient environment by passing the --native flag, but all
dependencies must already be installed and configured.  For larger builds, you
may want to use the --aws-batch flag to launch jobs on AWS Batch instead of
running locally (if the required AWS resources are configured in your AWS
account).

You can test if Docker, native, or AWS Batch build environments are properly
supported on your computer by running:

    nextstrain check-setup

The `nextstrain build` command is designed to cleanly separate the Nextstrain
build interface from provisioning a build environment, so that running builds
is as easy as possible.  It also lets us more seamlessly make environment
changes in the future as desired or necessary.

positional arguments:
  <directory>           Path to pathogen build directory
  ...                   Additional arguments to pass to the executed program

optional arguments:
  --help, -h            Show a brief help message of common options and exit
  --help-all            Show a full help message of all options and exit
  --detach              Run the build in the background, detached from your
                        terminal. Re-attach later using --attach. Currently
                        only supported when also using --aws-batch. (default:
                        False)
  --attach <job-id>     Re-attach to a --detach'ed build to view output and
                        download results. Currently only supported when also
                        using --aws-batch. (default: None)
  --cpus <count>        Number of CPUs/cores/threads/jobs to utilize at once.
                        Limits containerized (Docker, AWS Batch) builds to
                        this amount. Informs Snakemake's resource scheduler
                        when applicable. Informs the AWS Batch instance size
                        selection. (default: None)
  --memory <quantity>   Amount of memory to make available to the build. Units
                        of b, kb, mb, gb, kib, mib, gib are supported. Limits
                        containerized (Docker, AWS Batch) builds to this
                        amount. Informs Snakemake's resource scheduler when
                        applicable. Informs the AWS Batch instance size
                        selection. (default: None)
  --download <pattern>  Only download new or modified files matching <pattern>
                        from the remote build. Basic shell-style globbing is
                        supported, but be sure to escape wildcards or quote
                        the whole pattern so your shell doesn't expand them.
                        May be passed more than once. Currently only supported
                        when also using --aws-batch. Default is to download
                        every new or modified file.
  --no-download         Do not download any files from the remote build when
                        it completes. Currently only supported when also using
                        --aws-batch.

Run again with --help-all instead to see more options.
```


## nextstrain_view

### Tool Description
Visualizes a completed pathogen build in Auspice, the Nextstrain visualization app.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
- **Homepage**: https://nextstrain.org
- **Package**: https://anaconda.org/channels/bioconda/packages/nextstrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nextstrain view [options] <directory>
       nextstrain view --help

Visualizes a completed pathogen build in Auspice, the Nextstrain visualization app.

The data directory should contain sets of Auspice JSON¹ files like

    <name>.json

or

    <name>_tree.json
    <name>_meta.json

The viewer runs inside a container, which requires Docker.  Run `nextstrain
check-setup` to check if Docker is installed and works.

¹ <https://nextstrain.github.io/auspice/introduction/how-to-run#input-file-formats>

positional arguments:
  <directory>           Path to directory containing JSONs for Auspice

optional arguments:
  --help, -h            Show a brief help message of common options and exit
  --help-all            Show a full help message of all options and exit
  --allow-remote-access
                        Allow other computers on the network to access the
                        website (default: False)
  --port <number>       Listen on the given port instead of the default port
                        4000

Run again with --help-all instead to see more options.
```


## nextstrain_deploy

### Tool Description
Uploads (deploys) a set of built pathogen JSON data files or Markdown narratives to a remote source.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
- **Homepage**: https://nextstrain.org
- **Package**: https://anaconda.org/channels/bioconda/packages/nextstrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nextstrain deploy [-h] <s3://bucket-name> <file.json> [<file.json> ...]

Uploads (deploys) a set of built pathogen JSON data files or Markdown
narratives to a remote source.

The `nextstrain deploy` command is an alias for `nextstrain remote upload`.

Source URLs support optional path prefixes if you want your local filenames to
be prefixed on the remote.  For example:

    nextstrain remote upload s3://my-bucket/some/prefix/ auspice/zika*.json

will upload files named "some/prefix/zika*.json".

See `nextstrain remote --help` for more information on remote sources.

positional arguments:
  <s3://bucket-name>  Remote path as a URL, with optional key/path prefix
  <file.json>         Files to upload, typically Auspice JSON data files

optional arguments:
  -h, --help          show this help message and exit
```


## nextstrain_remote

### Tool Description
Upload, download, and manage Nextstrain files on remote sources.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
- **Homepage**: https://nextstrain.org
- **Package**: https://anaconda.org/channels/bioconda/packages/nextstrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nextstrain remote [-h] {upload,download,list,ls,delete,rm} ...

Upload, download, and manage Nextstrain files on remote sources.

Remote sources host the Auspice JSON data files and Markdown narratives that
are fetched by nextstrain.org or standalone instances of Auspice.
 
Currently only Amazon S3 buckets (s3://…) are supported as the remote
source, but others can be added in the future.

Credentials for authentication should generally be provided by environment
variables specific to each source.

Amazon S3
---------

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

More information at:

    https://boto3.amazonaws.com/v1/documentation/api/latest/guide/credentials.html#environment-variables

A persistent credentials file, ~/.aws/credentials, is also supported:

    https://boto3.amazonaws.com/v1/documentation/api/latest/guide/credentials.html#shared-credentials-file
 

optional arguments:
  -h, --help            show this help message and exit

commands:
  {upload,download,list,ls,delete,rm}
    upload              Upload dataset and narrative files
    download            Download dataset and narrative files
    list (ls)           List dataset and narrative files
    delete (rm)         Delete dataset and narrative files
```


## nextstrain_shell

### Tool Description
Start a new shell inside the Nextstrain containerized build environment to run ad-hoc commands and perform debugging.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
- **Homepage**: https://nextstrain.org
- **Package**: https://anaconda.org/channels/bioconda/packages/nextstrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nextstrain shell [options] <directory> [...]
       nextstrain shell --help

Start a new shell inside the Nextstrain containerized build environment to
run ad-hoc commands and perform debugging.

The shell runs inside a container, which requires Docker.  Run `nextstrain
check-setup` to check if Docker is installed and works.

positional arguments:
  <directory>       Path to pathogen build directory
  ...               Additional arguments to pass to the executed program

optional arguments:
  --help, -h        Show a brief help message of common options and exit
  --help-all        Show a full help message of all options and exit

Run again with --help-all instead to see more options.
```


## nextstrain_update

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
- **Homepage**: https://nextstrain.org
- **Package**: https://anaconda.org/channels/bioconda/packages/nextstrain/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
A new version of nextstrain-cli, 10.4.2, is available!  You're running 3.0.3.

Upgrade by running:

    python3.8 -m pip install --upgrade nextstrain-cli

[1mUpdating Docker image from nextstrain/base to nextstrain/base:build-20260210T230050Z…[0m


[0;31mUpdating images failed[0m

[0;33mMaybe upgrading nextstrain-cli, as noted above, will help?[0m
```


## nextstrain_check-setup

### Tool Description
Checks your local setup to see if you have a supported build environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
- **Homepage**: https://nextstrain.org
- **Package**: https://anaconda.org/channels/bioconda/packages/nextstrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nextstrain check-setup [-h] [--set-default]

Checks your local setup to see if you have a supported build environment.

Three environments are supported, each of which will be tested:

  • Our Docker image is the preferred build environment.  Docker itself must
    be installed and configured on your computer first, but once it is, the
    build environment is robust and reproducible.

  • Your native ambient environment will be tested for snakemake, augur, and
    auspice. Their presence implies a working build environment, but does not
    guarantee it.

  • Remote jobs on AWS Batch.  Your AWS account, if credentials are available
    in your environment or via aws-cli configuration, will be tested for the
    presence of appropriate resources.  Their presence implies a working AWS
    Batch environment, but does not guarantee it.

optional arguments:
  -h, --help     show this help message and exit
  --set-default  Set the default environment to the first which passes check-
                 setup. Checks run in the order: docker, native, aws-batch.
                 (default: False)
```


## Metadata
- **Skill**: not generated
