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

# binchicken update

Applies further processing to a previous Bin Chicken coassemble run.
Note that all coassemblies can be run by rerunning the `coassemble` command unchanged except for adding `--run-aviary`.

Any combinations of the following:

* Generating unmapped reads files (`--assemble-unmapped`)
* Running assembly/recovery for all/specific coassemblies through Aviary (`--run-aviary`, `--coassemblies`)
* Downloading SRA reads (`--sra`)

```
# Example: update previous run to run specific coassemblies
binchicken update --coassemble-output coassemble_dir --run-aviary \
    --coassemblies coassembly_0 ...

# Example: update previous run to perform unmapping
binchicken update --coassemble-output coassemble_dir --assemble-unmapped

# Example: update previous run to download SRA reads
# Note: requires sample names to be SRA IDs (e.g. SRA123456)
binchicken update --coassemble-output coassemble_dir --sra

# Example: update previous run to download SRA reads, perform unmapping and run specific coassemblies
binchicken update --coassemble-output coassemble_dir --sra \
    --assemble-unmapped \
    --run-aviary --coassemblies coassembly_0 ...
```

# OPTIONS

# INPUT ARGUMENTS

**--forward**, **--reads**, **--sequences** *FORWARD* [*FORWARD* ...]

input forward/unpaired nucleotide read sequence(s)

**--forward-list**, **--reads-list**, **--sequences-list** *FORWARD\_LIST*

input forward/unpaired nucleotide read sequence(s) newline separated

**--reverse** *REVERSE* [*REVERSE* ...]

input reverse nucleotide read sequence(s)

**--reverse-list** *REVERSE\_LIST*

input reverse nucleotide read sequence(s) newline separated

**--genomes** *GENOMES* [*GENOMES* ...]

Reference genomes for read mapping

**--genomes-list** *GENOMES\_LIST*

Reference genomes for read mapping newline separated

**--coassembly-samples** *COASSEMBLY\_SAMPLES* [*COASSEMBLY\_SAMPLES* ...]

Restrict coassembly to these samples. Remaining samples will still
be used for recovery [default: use all samples]

**--coassembly-samples-list** *COASSEMBLY\_SAMPLES\_LIST*

Restrict coassembly to these samples, newline separated. Remaining
samples will still be used for recovery [default: use all samples]

**--anchor-samples** *ANCHOR\_SAMPLES* [*ANCHOR\_SAMPLES* ...]

Samples to use as anchors for coassembly, all coassemblies will
contain at least one anchor sample. [default: no restriction]

**--anchor-samples-list** *ANCHOR\_SAMPLES\_LIST*

Samples to use as anchors for coassembly, all coassemblies will
contain at least one anchor sample, newline separated. [default: no
restriction]

**--sra**

Download reads from SRA (forward read argument intepreted as SRA
IDs). Also sets --run-qc.

**--download-limit** *DOWNLOAD\_LIMIT*

Parallel download limit [default: 3]

# COASSEMBLY OPTIONS

**--coassemble-output** *COASSEMBLE\_OUTPUT*

Output dir from coassemble subcommand

**--coassemble-unbinned** *COASSEMBLE\_UNBINNED*

SingleM appraise unbinned output from Bin Chicken coassemble
(alternative to --coassemble-output)

**--coassemble-binned** *COASSEMBLE\_BINNED*

SingleM appraise binned output from Bin Chicken coassemble
(alternative to --coassemble-output)

**--coassemble-targets** *COASSEMBLE\_TARGETS*

Target sequences output from Bin Chicken coassemble (alternative to
--coassemble-output)

**--coassemble-elusive-edges** *COASSEMBLE\_ELUSIVE\_EDGES*

Elusive edges output from Bin Chicken coassemble (alternative to
--coassemble- output)

**--coassemble-elusive-clusters** *COASSEMBLE\_ELUSIVE\_CLUSTERS*

Elusive clusters output from Bin Chicken coassemble (alternative to
--coassemble-output)

**--coassemble-summary** *COASSEMBLE\_SUMMARY*

Summary output from Bin Chicken coassemble (alternative to
--coassemble- output)

**--coassemblies** *COASSEMBLIES* [*COASSEMBLIES* ...]

Choose specific coassemblies from elusive clusters (e.g.
coassembly\_0)

**--coassemblies-list** *COASSEMBLIES\_LIST*

Choose specific coassemblies from elusive clusters newline separated
(e.g. coassembly\_0)

**--assemble-unmapped**

Only assemble reads that do not map to reference genomes

**--run-qc**

Run Fastp QC on reads

**--unmapping-min-appraised** *UNMAPPING\_MIN\_APPRAISED*

Minimum fraction of sequences binned to justify unmapping [default:
0.1]

**--unmapping-max-identity** *UNMAPPING\_MAX\_IDENTITY*

Maximum sequence identity of mapped sequences kept for coassembly
[default: 99%]

**--unmapping-max-alignment** *UNMAPPING\_MAX\_ALIGNMENT*

Maximum percent alignment of mapped sequences kept for coassembly
[default: 99%]

**--run-aviary**

Run Aviary commands for all identified coassemblies (unless specific
coassemblies are chosen with --coassemblies) [default: do not]

**--prior-assemblies** *PRIOR\_ASSEMBLIES*

Prior assemblies to use for Aviary recovery. tsv file with header:
name [tab] assembly. Only possible with single-sample or update.
[default: generate assemblies through Aviary assemble]

**--cluster-submission**

Flag that cluster submission will occur through
`--snakemake-profile`. This sets the local threads of Aviary
recover to 1, allowing parallel job submission [default: do not]

**--aviary-speed** {fast,comprehensive}

Run Aviary recover in 'fast' or 'comprehensive' mode. Fast mode
skips slow binners and refinement steps. [default: fast]

**--assembly-strategy** {dynamic,metaspades,megahit}

Assembly strategy to use with Aviary. [default: dynamic; attempts
metaspades and if fails, switches to megahit]

**--aviary-gtdbtk-db** *AVIARY\_GTDBTK\_DB*

Path to GTDB-Tk database directory for Aviary. Only required if
--aviary-speed is set to comprehensive [default: use path from
GTDBTK\_DATA\_PATH env variable]

**--aviary-checkm2-db** *AVIARY\_CHECKM2\_DB*

Path to CheckM2 database directory for Aviary. [default: use path
from CHECKM2DB env variable]

**--aviary-metabuli-db** *AVIARY\_METABULI\_DB*

Path to MetaBuli database directory for Aviary, specifically for
TaxVAMB. [default: use path from METABULI\_DB\_PATH env variable]

**--aviary-snakemake-profile** *AVIARY\_SNAKEMAKE\_PROFILE*

Snakemake profile (see
https://snakemake.readthedocs.io/en/v7.32.3/executing/cli.html#profiles).
Can be used to submit rules as jobs to cluster engine (see
https://snakemake.readthedocs.io/en/v7.32.3/executing/cluster.html).
[default: same as `--snakemake-profile`]

**--aviary-assemble-cores** *AVIARY\_ASSEMBLE\_CORES*

Maximum number of cores for Aviary assemble to use. [default: 64]

**--aviary-assemble-memory** *AVIARY\_ASSEMBLE\_MEMORY*

Maximum amount of memory for Aviary assemble to use (Gigabytes).
[default: 500]

**--aviary-recover-cores** *AVIARY\_RECOVER\_CORES*

Maximum number of cores for Aviary recover to use. [default: 32]

**--aviary-recover-memory** *AVIARY\_RECOVER\_MEMORY*

Maximum amount of memory for Aviary recover to use (Gigabytes).
[default: 250]

**--aviary-extra-binners** [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]

Optional list of extra binning algorithms to run. Can be any
combination of: maxbin, maxbin2, concoct, comebin, taxvamb

**--aviary-skip-binners** [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]

Optional list of binning algorithms to skip. Can be any combination
of: rosella, semibin, metabat1, metabat2, metabat, vamb. Note that
specifying

**--aviary-request-gpu**

Request GPU resources for certain binners in Aviary recovery
[default: do not].

# GENERAL OPTIONS

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

update previous run to run specific coassemblies

**$ binchicken update --coassemble-output coassemble\_dir
--run-aviary --coassemblies coassembly\_0 ...**

update previous run to perform unmapping

**$ binchicken update --coassemble-output coassemble\_dir
--assemble-unmapped**

update previous run to download SRA reads

**$ binchicken update --coassemble-output coassemble\_dir --sra**

update previous run to download SRA reads, perform unmapping and run specific coassemblies

**$ binchicken update --coassemble-output coassemble\_dir --sra
--assemble-unmapped --run-aviary --coassemblies coassembly\_0
...**

On this page

* [binchicken update](#binchicken-update)
* [OPTIONS](#options)
* [INPUT ARGUMENTS](#input-arguments)
* [COASSEMBLY OPTIONS](#coassembly-options)
* [GENERAL OPTIONS](#general-options)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [EXAMPLES](#examples)

Powered by [Doctave](https://cli.doctave.com)