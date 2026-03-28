☰
[ ]

[![Bin Chicken logo](/binchicken/binchicken_logo.png)](/binchicken/)

## [Bin Chicken](/binchicken/)

S

* [installation](/binchicken/installation)
* [setup](/binchicken/setup)
* [usage](/binchicken/usage)
* [demo](/binchicken/demo)
* [tools](/binchicken/tools)

+ [Bin Chicken coassemble](/binchicken/tools/coassemble)
+ [Bin Chicken single](/binchicken/tools/single)
+ [Bin Chicken update](/binchicken/tools/update)
+ [Bin Chicken iterate](/binchicken/tools/iterate)
+ [Bin Chicken evaluate](/binchicken/tools/evaluate)
+ [Bin Chicken build](/binchicken/tools/build)

# binchicken build

# DESCRIPTION

Create dependency environments

# OPTIONS

**--singlem-metapackage** *SINGLEM\_METAPACKAGE*

SingleM metapackage

**--checkm2-db** *CHECKM2\_DB*

CheckM2 database

**--gtdbtk-db** *GTDBTK\_DB*

GTDBtk release database (Only required if --aviary-speed is set to
{COMPREHENSIVE\_AVIARY\_MODE})

**--metabuli-db** *METABULI\_DB*

MetaBuli database (Only required with TaxVAMB extra binner)

**--set-tmp-dir** *SET\_TMP\_DIR*

Set temporary directory [default: /tmp]

**--skip-aviary-envs**

Do not install Aviary subworkflow environments

**--build-gpu**

Build GPU-friendly environments for certain binners in Aviary
recovery [default: do not]. Must be run on a node with GPU access.

**--download-databases**

Download databases if provided paths do not exist

**--output** *OUTPUT*

Output directory [default: .]

**--cores** *CORES*

Maximum number of cores to use [default: 1]

**--dryrun**, **--dry-run**

dry run workflow

**--snakemake-profile** *SNAKEMAKE\_PROFILE*

Snakemake profile (see
https://snakemake.readthedocs.io/en/v7.32.3/executing/cli.html#profiles).
Can be used to submit rules as jobs to cluster engine (see
https://snakemake.readthedocs.io/en/v7.32.3/executing/cluster.html).

**--local-cores** *LOCAL\_CORES*

Maximum number of cores to use on localrules when running in cluster
mode [default: 1]

**--retries** *RETRIES*

Number of times to retry a failed job [default: 3].

**--snakemake-args** *SNAKEMAKE\_ARGS*

Additional commands to be supplied to snakemake in the form of a
space- prefixed single string e.g. " --quiet"

**--tmp-dir** *TMP\_DIR*

Path to temporary directory. [default: no default]

# OTHER GENERAL OPTIONS

**--debug**

output debug information

**--version**

output version information and quit

**--quiet**

only output errors

**--full-help**

print longer help message

**--full-help-roff**

print longer help message in ROFF (manpage) format

# EXAMPLES

create dependency environments

**$ binchicken build**

create dependency environments and setup environment variables for databases

**$ binchicken build --singlem-metapackage metapackage
--checkm2-db CheckM2 --gtdbtk-db GTDBtk**

create dependency environments and download databases

**$ binchicken build --singlem-metapackage metapackage
--checkm2-db CheckM2 --download-databases**

On this page

* [binchicken build](#binchicken-build)
* [DESCRIPTION](#description)
* [OPTIONS](#options)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [EXAMPLES](#examples)

Powered by [Doctave](https://cli.doctave.com)