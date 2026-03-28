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

# binchicken evaluate

Evaluates the recovery of target genes by coassemblies suggested by above, finding the number of target genes present in the newly recovered genomes.
Compares the recovery by phyla and by single-copy marker gene.

```
# Example: evaluate a completed coassembly
binchicken evaluate --coassemble-output coassemble_dir \
    --aviary-outputs coassembly_0_dir ...

# Example: evaluate a completed coassembly by providing genomes directly
binchicken evaluate --coassemble-output coassemble_dir \
    --new-genomes genome_1.fna ... --coassembly-run coassembly_0
```

Defaults to using genomes (from the provided coassemble outputs) with at least 70% complete and at most 10% contamination as estimated by CheckM2.

# OPTIONS

# BASE INPUT ARGUMENTS

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

**--aviary-outputs** *AVIARY\_OUTPUTS* [*AVIARY\_OUTPUTS* ...]

Output dir from Aviary coassembly and recover commands produced by
coassemble subcommand

**--new-genomes** *NEW\_GENOMES* [*NEW\_GENOMES* ...]

New genomes to evaluate (alternative to --aviary-outputs, also
requires --coassembly-run)

**--new-genomes-list** *NEW\_GENOMES\_LIST*

New genomes to evaluate (alternative to --aviary-outputs, also
requires --coassembly-run) newline separated

**--coassembly-run** *COASSEMBLY\_RUN*

Name of coassembly run to produce new genomes (alternative to
--aviary- outputs, also requires --new-genomes)

**--singlem-metapackage** *SINGLEM\_METAPACKAGE*

SingleM metapackage for sequence searching

**--prodigal-meta**

Use prodigal "-p meta" argument (for testing)

# EVALUATION OPTIONS

**--checkm-version** *CHECKM\_VERSION*

CheckM version to use to quality cutoffs [default: 2]

**--min-completeness** *MIN\_COMPLETENESS*

Include bins with at least this minimum completeness [default: 70]

**--max-contamination** *MAX\_CONTAMINATION*

Include bins with at most this maximum contamination [default: 10]

# CLUSTER OPTIONS

**--cluster**

Cluster new and original genomes and report number of new clusters

**--cluster-ani** *CLUSTER\_ANI*

Cluster using this sequence identity [default: 86%]

**--genomes** *GENOMES* [*GENOMES* ...]

Original genomes used as references for coassemble subcommand

**--genomes-list** *GENOMES\_LIST*

Original genomes used as references for coassemble subcommand
newline separated

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

evaluate a completed coassembly

**$ binchicken evaluate --coassemble-output coassemble\_dir
--aviary-outputs coassembly\_0\_dir ...**

evaluate a completed coassembly by providing genomes directly

**$ binchicken evaluate --coassemble-output coassemble\_dir
--new-genomes genome\_1.fna ... --coassembly-run coassembly\_0**

On this page

* [binchicken evaluate](#binchicken-evaluate)
* [OPTIONS](#options)
* [BASE INPUT ARGUMENTS](#base-input-arguments)
* [EVALUATION OPTIONS](#evaluation-options)
* [CLUSTER OPTIONS](#cluster-options)
* [GENERAL OPTIONS](#general-options)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [EXAMPLES](#examples)

Powered by [Doctave](https://cli.doctave.com)