[ ]
[ ]

[Skip to content](#download-summary-tables)

assembly finder

Examples

Initializing search

[metagenlab/assembly\_finder](https://github.com/metagenlab/assembly_finder "Go to repository")

assembly finder

[metagenlab/assembly\_finder](https://github.com/metagenlab/assembly_finder "Go to repository")

* [Home](..)
* [Inputs](../inputs/)
* [Outputs](../outputs/)
* [ ]

  Examples

  [Examples](./)

  Table of contents
  + [Download summary tables](#download-summary-tables)
  + [Download genomes](#download-genomes)

    - [Small datasets](#small-datasets)
    - [Big datasets](#big-datasets)
  + [Download other files (cds, proteins, gff3 ...)](#download-other-files-cds-proteins-gff3)

Table of contents

* [Download summary tables](#download-summary-tables)
* [Download genomes](#download-genomes)

  + [Small datasets](#small-datasets)
  + [Big datasets](#big-datasets)
* [Download other files (cds, proteins, gff3 ...)](#download-other-files-cds-proteins-gff3)

# Examples

## Download summary tables

Starting from [v0.8.0](https://github.com/metagenlab/assembly_finder/releases/tag/v0.8.0), you can restrict outputs to `assembly_summary.tsv` and `taxonomy.tsv`

* Command

```
assembly_finder -i staphylococcus_aureus --reference --summary
```

* Output

```
📂staphylococcus_aureus
 ┣ 📂logs
 ┃ ┣ 📂taxons
 ┃ ┃ ┗ 📜staphylococcus_aureus.log
 ┃ ┗📜lineage.log
 ┣ 📜assembly_finder.log
 ┣ 📜assembly_summary.tsv
 ┣ 📜config.yaml
 ┗ 📜taxonomy.tsv
```

## Download genomes

### Small datasets

* *Staphylococcus aureus* complete genomes

```
assembly_finder -i staphylococcus_aureus
```

Note

By default, assembly\_finder searches assembly levels in the following order: **complete**, **chromosome**, **scaffold**, and **contig**.

The search stops at the first assembly level where genomes are found.

This behavior was introduced in [v0.9.0](https://github.com/metagenlab/assembly_finder/releases/tag/v0.9.0) to allow finding the best genomes available for each taxon

* All *Staphylococcus aureus* genomes

```
assembly_finder -i staphylococcus_aureus --all
```

Note

The --all option disables the default iteration over assembly levels.
When used, all genomes for the specified taxon are downloaded, regardless of their assembly level.

* Any *Staphylococcus aureus* complete genome

```
assembly_finder -i staphylococcus_aureus -nb 1
```

### Big datasets

Warning

These examples are for big datasets downloads, so using an NCBI api-key is highly recommended

* Download all chlamydia genomes

```
assembly_finder -i chlamydia --all --api-key <api-key>
```

* Best ranking complete genome per bacteria species

```
assembly_finder -i eubacteria --api-key <api-key> --rank species --nrank 1
```

* Complete bacteria viruses and archaea genomes from RefSeq (excluding MAGs and atypical)

```
assembly_finder -i eubacteria,viruses,archaea \
--api-key <api-key> \
--source refseq \
--mag exclude \
-o outdir
```

* Specific bioproject

```
assembly_finder -i PRJNA289059 --api-key <api-key> --accession
```

## Download other files (cds, proteins, gff3 ...)

```
assembly_finder -i staphylococcus_aureus --reference \
--include rna,protein,cds,gff3,gtf,gbff,seq-report
```

Output:

```
📂staphylococcus_aureus
 ┣ 📂download
 ┃ ┣ 📂GCF_000013425.1
 ┃ ┃ ┣ 📜GCF_000013425.1_ASM1342v1_genomic.fna.gz
 ┃ ┃ ┣ 📜cds_from_genomic.fna.gz
 ┃ ┃ ┣ 📜genomic.gbff.gz
 ┃ ┃ ┣ 📜genomic.gff.gz
 ┃ ┃ ┣ 📜genomic.gtf.gz
 ┃ ┃ ┗ 📜protein.faa.gz
 ┃ ┃ ┗ 📜sequence_report.jsonl
 ┃ ┗ 📜.snakemake_timestamp
 ┣ 📂logs
 ┃ ┣ 📂taxons
 ┃ ┃ ┗ 📜staphylococcus_aureus.log
 ┃ ┣ 📜archive.log
 ┃ ┣ 📜lineage.log
 ┃ ┣ 📜rsync.log
 ┃ ┗ 📜unzip.log
 ┣ 📜archive.zip
 ┣ 📜assembly_finder.log
 ┣ 📜assembly_summary.tsv
 ┣ 📜config.yaml
 ┗ 📜taxonomy.tsv
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)