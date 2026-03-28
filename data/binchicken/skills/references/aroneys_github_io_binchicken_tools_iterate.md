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

# binchicken iterate

Run a further iteration of coassemble, including newly recovered bins.
All [coassemble](/binchicken/tools/coassemble) options are available and can be altered for the new iteration (see [example workflow](/binchicken/)).

```
# Example: rerun coassemble, adding new bins to database
binchicken iterate --coassemble-output coassemble_dir

# Example: rerun coassemble, adding new bins to database, providing genomes directly
binchicken iterate --coassemble-output coassemble_dir \
    --new-genomes new_genome_1.fna
```

Defaults to using genomes (from the provided coassemble outputs) with at least 70% complete and at most 10% contamination as estimated by CheckM2.
Alternatively, selected genomes can be provided directly with `--new-genomes`.
Automatically excludes previous coassemblies.

# OPTIONS

# ITERATION OPTIONS

**--iteration** *ITERATION*

Iteration number used for unique bin naming [default: 0]

**--aviary-outputs** *AVIARY\_OUTPUTS* [*AVIARY\_OUTPUTS* ...]

Output dir from Aviary coassembly and recover commands produced by
coassemble subcommand

**--new-genomes** *NEW\_GENOMES* [*NEW\_GENOMES* ...]

New genomes to iterate (alternative to --aviary-outputs)

**--new-genomes-list** *NEW\_GENOMES\_LIST*

New genomes to iterate (alternative to --aviary-outputs) newline
separated

**--new-genome-singlem** *NEW\_GENOME\_SINGLEM*

Combined SingleM otu tables for new genome transcripts. If provided,
genome SingleM is skipped

**--elusive-clusters** *ELUSIVE\_CLUSTERS* [*ELUSIVE\_CLUSTERS* ...]

Previous elusive\_clusters.tsv files produced by coassemble
subcommand (used to check for duplicated coassembly suggestions)

**--coassemble-output** *COASSEMBLE\_OUTPUT*

Output dir from coassemble subcommand

**--coassemble-unbinned** *COASSEMBLE\_UNBINNED*

SingleM appraise unbinned output from Bin Chicken coassemble
(alternative to --coassemble-output)

**--coassemble-binned** *COASSEMBLE\_BINNED*

SingleM appraise binned output from Bin Chicken coassemble
(alternative to --coassemble-output)

**--checkm-version** *CHECKM\_VERSION*

CheckM version to use to quality cutoffs [default: 2]

**--min-completeness** *MIN\_COMPLETENESS*

Include bins with at least this minimum completeness [default: 70]

**--max-contamination** *MAX\_CONTAMINATION*

Include bins with at most this maximum contamination [default: 10]

# BASE INPUT ARGUMENTS

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

**--singlem-metapackage** *SINGLEM\_METAPACKAGE*

SingleM metapackage for sequence searching. [default: use path from
SINGLEM\_METAPACKAGE\_PATH env variable]

# INTERMEDIATE RESULTS INPUT ARGUMENTS

**--sample-singlem** *SAMPLE\_SINGLEM* [*SAMPLE\_SINGLEM* ...]

SingleM otu tables for each sample, in the form "[sample
name]\_read.otu\_table.tsv". If provided, SingleM pipe sample is
skipped

**--sample-singlem-list** *SAMPLE\_SINGLEM\_LIST*

SingleM otu tables for each sample, in the form "[sample
name]\_read.otu\_table.tsv" newline separated. If provided, SingleM
pipe sample is skipped

**--sample-singlem-dir** *SAMPLE\_SINGLEM\_DIR*

Directory containing SingleM otu tables for each sample, in the form
"[sample name]\_read.otu\_table.tsv". If provided, SingleM pipe
sample is skipped

**--sample-query** *SAMPLE\_QUERY* [*SAMPLE\_QUERY* ...]

Queried SingleM otu tables for each sample against genome database,
in the form "[sample name]\_query.otu\_table.tsv". If provided,
SingleM pipe and appraise are skipped

**--sample-query-list** *SAMPLE\_QUERY\_LIST*

Queried SingleM otu tables for each sample against genome database,
in the form "[sample name]\_query.otu\_table.tsv" newline
separated. If provided, SingleM pipe and appraise are skipped

**--sample-query-dir** *SAMPLE\_QUERY\_DIR*

Directory containing Queried SingleM otu tables for each sample
against genome database, in the form "[sample
name]\_query.otu\_table.tsv". If provided, SingleM pipe and
appraise are skipped

**--sample-read-size** *SAMPLE\_READ\_SIZE*

Comma separated list of sample name and size (bp). If provided,
sample read counting is skipped

**--genome-transcripts** *GENOME\_TRANSCRIPTS* [*GENOME\_TRANSCRIPTS* ...]

Genome transcripts for reference database, in the form
"[genome]\_protein.fna"

**--genome-transcripts-list** *GENOME\_TRANSCRIPTS\_LIST*

Genome transcripts for reference database, in the form
"[genome]\_protein.fna" newline separated

**--genome-singlem** *GENOME\_SINGLEM*

Combined SingleM otu tables for genome transcripts. If provided,
genome SingleM is skipped

# CLUSTERING OPTIONS

**--taxa-of-interest** *TAXA\_OF\_INTEREST*

Only consider sequences from this GTDB taxa (e.g.
p\_\_Planctomycetota, or

**--appraise-sequence-identity** *APPRAISE\_SEQUENCE\_IDENTITY*

Minimum sequence identity for SingleM appraise against reference
database. e.g. 96% for Species-level or 86% Genus-level [default:
0.96]

**--min-sequence-coverage** *MIN\_SEQUENCE\_COVERAGE*

Minimum combined coverage for sequence inclusion [default: 10]

**--single-assembly**

Skip appraise to discover samples to differential abundance binning.
Forces --num-coassembly-samples and --max-coassembly-samples to 1
and sets --max- coassembly-size to None

**--exclude-coassemblies** *EXCLUDE\_COASSEMBLIES* [*EXCLUDE\_COASSEMBLIES* ...]

List of coassemblies to exclude, space separated, in the form
"sample\_1,sample\_2"

**--exclude-coassemblies-list** *EXCLUDE\_COASSEMBLIES\_LIST*

List of coassemblies to exclude, space separated, in the form
"sample\_1,sample\_2", newline separated

**--num-coassembly-samples** *NUM\_COASSEMBLY\_SAMPLES*

Number of samples per coassembly cluster [default: 2]

**--max-coassembly-samples** *MAX\_COASSEMBLY\_SAMPLES*

Upper bound for number of samples per coassembly cluster [default:
--num- coassembly-samples]

**--max-coassembly-size** *MAX\_COASSEMBLY\_SIZE*

Maximum size (Gbp) of coassembly cluster [default: 50Gbp]

**--max-recovery-samples** *MAX\_RECOVERY\_SAMPLES*

Upper bound for number of related samples to use for differential
abundance binning [default: 20]

**--max-sample-combinations** *MAX\_SAMPLE\_COMBINATIONS*

Maximum number of samples per target to consider for pooled clusters
(reduces combinatorial explosions). Set to a smaller number if you
have a polars idx error. [default: starts at 100, reducing by 20
with retries]

**--abundance-weighted**

Weight sequences by mean sample abundance when ranking clusters
[default: False]

**--abundance-weighted-samples** *ABUNDANCE\_WEIGHTED\_SAMPLES* [*ABUNDANCE\_WEIGHTED\_SAMPLES* ...]

Restrict sequence weighting to these samples. Remaining samples will
still be used for coassembly [default: use all samples]

**--abundance-weighted-samples-list** *ABUNDANCE\_WEIGHTED\_SAMPLES\_LIST*

Restrict sequence weighting to these samples, newline separated.
Remaining samples will still be used for coassembly [default: use
all samples]

**--kmer-precluster** {never,large,always}

Run kmer preclustering using unbinned window sequences as kmers.
[default: large; perform preclustering when given >1000 samples]

**--precluster-distances** *PRECLUSTER\_DISTANCES*

Distance file in the format of `sourmash scripts pairwise`. If
provided, kmer sketching and clustering is skipped.

**--precluster-size** *PRECLUSTER\_SIZE*

# of samples within each sample's precluster [default: 5 \*
max-recovery- samples]

**--file-hierarchy** {never,large,always}

Split sample outputs into subdirectories based on sample name.
[default: large; use when given >10000 samples]

**--file-hierarchy-depth** *FILE\_HIERARCHY\_DEPTH*

Maximum depth of subdirectory hierarchy. [default: 3]

**--file-hierarchy-chars** *FILE\_HIERARCHY\_CHARS*

Number of characters to use for subdirectory hierarchy. [default:
4]

**--prodigal-meta**

Use prodigal "-p meta" argument (for testing)

# COASSEMBLY OPTIONS

**--assemble-unmapped**

Only assemble reads that do not map to reference genomes

**--sra**

Download reads from SRA (forward read argument intepreted as SRA
IDs). Also sets --run-qc.

**--download-limit** *DOWNLOAD\_LIMIT*

Parallel download limit [default: 3]

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

rerun coassemble, adding new bins to database

**$ binchicken iterate --coassemble-output coassemble\_dir**

rerun coassemble, adding new bins to database, providing genomes directly

**$ binchicken iterate --coassemble-output coassemble\_dir
--new-genomes new\_genome\_1.fna**

On this page

* [binchicken iterate](#binchicken-iterate)
* [OPTIONS](#options)
* [ITERATION OPTIONS](#iteration-options)
* [BASE INPUT ARGUMENTS](#base-input-arguments)
* [INTERMEDIATE RESULTS INPUT ARGUMENTS](#intermediate-results-input-arguments)
* [CLUSTERING OPTIONS](#clustering