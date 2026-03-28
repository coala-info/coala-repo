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

# binchicken coassemble

Snakemake pipeline to discover coassembly sample clusters based on co-occurrence of single-copy marker genes, excluding those genes present in reference genomes (e.g. previously recovered genomes).

```
# Example: cluster reads into proposed coassemblies
binchicken coassemble --forward reads_1.1.fq ... --reverse reads_1.2.fq ...

# Example: cluster reads into proposed coassemblies based on unbinned sequences
binchicken coassemble --forward reads_1.1.fq ... --reverse reads_1.2.fq ... --genomes genome_1.fna ...

# Example: cluster reads into proposed coassemblies based on unbinned sequences and coassemble only unbinned reads
binchicken coassemble --forward reads_1.1.fq ... --reverse reads_1.2.fq ... --genomes genome_1.fna ... --assemble-unmapped

# Example: cluster reads into proposed coassemblies based on unbinned sequences from a specific taxa
binchicken coassemble --forward reads_1.1.fq ... --reverse reads_1.2.fq ... --genomes genome_1.fna ... --taxa-of-interest "p__Planctomycetota"

# Example: find relevant samples for differential coverage binning (no coassembly)
binchicken coassemble --forward reads_1.1.fq ... --reverse reads_1.2.fq ... --single-assembly

# Example: run proposed coassemblies through aviary with cluster submission
# Create snakemake profile at ~/.config/snakemake/qsub with cluster, cluster-status, cluster-cancel, etc.
# See https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
binchicken coassemble --forward reads_1.1.fq ... --reverse reads_1.2.fq ... --run-aviary \
  --snakemake-profile qsub --cluster-submission --local-cores 64 --cores 64
```

Important options:

* Minimum and maximum cluster sizes can be specified (`--num-coassembly-samples` and `--max-coassembly-samples`, both default to 2)
* Maximum number of recovery samples for differential-abundance binning can be specified (`--max-recovery-samples`, default 20)
* Genomes can be provided and matching marker genes will be excluded (`--genomes`)
* Reads can be mapped to the matched bins with only unmapped reads being assembled (`--assemble-unmapped`).
* Assembly and recovery running options:
  + Run directly through Aviary (`--run-aviary`)
  + Run Aviary commands manually (see `coassemble/commands` in output)
  + Run coassemblies with differential-abundance-binning samples with the tool of your choice (see `coassemble/target/elusive_clusters.tsv` in output)
* The taxa of the considered sequences can be filtered to target a specific taxon (e.g. `--taxa-of-interest "p__Planctomycetota"`).
* Differential-abundance binning samples for single-assembly can also be found (`--single-assembly`)

Paired end reads of form \*.1.fq, \*\_1.fq and \*\_R1.fq, where \* represents the sample name are automatically detected and matched to their basename.
Most intermediate files can be provided to skip intermediate steps (e.g. SingleM otu tables, read sizes or genome transcripts; see `binchicken coassemble --full-help`).

## Abundance weighting (experimental)

By default, coassemblies are ranked by the number of feasibly-recovered target sequences they contain.
Instead, `--abundance-weighted` can be used to weight target sequences by their average abundance across samples.
This prioritises recovery of the most abundant lineages.
The samples for which abundances are calculated can be restricted using `--abundance-weighted-samples`.

## Kmer preclustering

Clustering groups of more than 1000 samples quickly leads to memory issues due to combinatorics.
Kmer preclustering can be used (default if >1000 samples are provided, or use `--kmer-precluster always`) to reduce the number of combinations that are considered.
This greatly reduces memory usage and allows scaling up to at least 250k samples.
Kmer preclustering can be disabled with `--kmer-precluster never`.

## Polars idx errors

If you encounter the following error: `Polars' maximum length reached. Consider installing 'polars-u64-idx'.`
You can try reducing the `--max-sample-combinations` option (default 100).
Bin Chicken ignores target sequences found in more than this number of samples to prevent combinatorial explosions.
These targets are also less useful for distinguishing between clusters.
It is not recommended to set this value lower than the number of requested recovery samples (`--max-recovery-samples`).

# OPTIONS

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

**--aviary-skip-binners** [{rosella,semibin,metabat1,metabat2,metabat,vamb