[ ]
[ ]

[Skip to content](#download-directory)

assembly finder

Outputs

Initializing search

[metagenlab/assembly\_finder](https://github.com/metagenlab/assembly_finder "Go to repository")

assembly finder

[metagenlab/assembly\_finder](https://github.com/metagenlab/assembly_finder "Go to repository")

* [Home](..)
* [Inputs](../inputs/)
* [ ]

  Outputs

  [Outputs](./)

  Table of contents
  + [Download directory](#download-directory)
  + [Assembly summary](#assembly-summary)
  + [Taxonomy](#taxonomy)
* [Examples](../examples/)

Table of contents

* [Download directory](#download-directory)
* [Assembly summary](#assembly-summary)
* [Taxonomy](#taxonomy)

# Outputs

Below are all the outputs when using the [taxons table example](../inputs/#tables)

```
📂taxons
 ┣ 📂download
 ┃ ┣ 📂GCF_000008865.2
 ┃ ┃ ┗ 📜GCF_000008865.2_ASM886v2_genomic.fna.gz
 ┃ ┣ 📂GCF_000013425.1
 ┃ ┃ ┗ 📜GCF_000013425.1_ASM1342v1_genomic.fna.gz
 ┃ ┣ 📂GCF_003812505.1
 ┃ ┃ ┗ 📜GCF_003812505.1_ASM381250v1_genomic.fna.gz
 ┃ ┗ 📜.snakemake_timestamp
 ┣ 📂logs
 ┃ ┣ 📂taxons
 ┃ ┃ ┣ 📜1290.log
 ┃ ┃ ┣ 📜562.log
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

## Download directory

Downloaded files (`genomic.fna.gz` by default) are located in the download directory as shown below

```
 ┣ 📂download
 ┃ ┣ 📂GCF_000008865.2
 ┃ ┃ ┗ 📜GCF_000008865.2_ASM886v2_genomic.fna.gz
 ┃ ┣ 📂GCF_000013425.1
 ┃ ┃ ┗ 📜GCF_000013425.1_ASM1342v1_genomic.fna.gz
 ┃ ┣ 📂GCF_003812505.1
 ┃ ┃ ┗ 📜GCF_003812505.1_ASM381250v1_genomic.fna.gz
```

## Assembly summary

Table with assembly informations such as assembly level, reference category, checkM and BUSCO completeness, sequencing technology, number of contigs ...

| taxon | accession | current\_accession | paired\_accession | source\_database | annotation\_info.method | annotation\_info.name | annotation\_info.pipeline | annotation\_info.provider | annotation\_info.release\_date | annotation\_info.software\_version | annotation\_info.stats.gene\_counts.non\_coding | annotation\_info.stats.gene\_counts.protein\_coding | annotation\_info.stats.gene\_counts.pseudogene | annotation\_info.stats.gene\_counts.total | assembly\_level | assembly\_method | assembly\_name | assembly\_status | assembly\_type | bioproject\_accession | biosample.accession | biosample.bioprojects | biosample.description.organism\_name | biosample.description.tax\_id | biosample.description.title | biosample.last\_updated | biosample.models | biosample.owner.contacts | biosample.owner.name | biosample.package | biosample.publication\_date | biosample.status.status | biosample.status.when | biosample.submission\_date | paired\_assembly.accession | paired\_assembly.annotation\_name | paired\_assembly.status | refseq\_category | release\_date | sequencing\_tech | submitter | contig\_l50 | contig\_n50 | gc\_count | gc\_percent | genome\_coverage | number\_of\_component\_sequences | number\_of\_contigs | number\_of\_scaffolds | scaffold\_l50 | scaffold\_n50 | total\_number\_of\_chromosomes | total\_sequence\_length | total\_ungapped\_length | average\_nucleotide\_identity.best\_ani\_match.ani | average\_nucleotide\_identity.best\_ani\_match.assembly | average\_nucleotide\_identity.best\_ani\_match.assembly\_coverage | average\_nucleotide\_identity.best\_ani\_match.category | average\_nucleotide\_identity.best\_ani\_match.organism\_name | average\_nucleotide\_identity.best\_ani\_match.type\_assembly\_coverage | average\_nucleotide\_identity.category | average\_nucleotide\_identity.comment | average\_nucleotide\_identity.match\_status | average\_nucleotide\_identity.submitted\_ani\_match.ani | average\_nucleotide\_identity.submitted\_ani\_match.assembly | average\_nucleotide\_identity.submitted\_ani\_match.assembly\_coverage | average\_nucleotide\_identity.submitted\_ani\_match.category | average\_nucleotide\_identity.submitted\_ani\_match.organism\_name | average\_nucleotide\_identity.submitted\_ani\_match.type\_assembly\_coverage | average\_nucleotide\_identity.submitted\_organism | average\_nucleotide\_identity.submitted\_species | average\_nucleotide\_identity.taxonomy\_check\_status | checkm\_info.checkm\_marker\_set | checkm\_info.checkm\_marker\_set\_rank | checkm\_info.checkm\_species\_tax\_id | checkm\_info.checkm\_version | checkm\_info.completeness | checkm\_info.completeness\_percentile | checkm\_info.contamination | infraspecific\_names.strain | organism\_name | tax\_id | path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| staphylococcus\_aureus | GCF\_000013425.1 | GCF\_000013425.1 | GCA\_000013425.1 | SOURCE\_DATABASE\_REFSEQ | na | Annotation submitted by NCBI RefSeq | na | NCBI RefSeq | 2016-08-03 | na | 75 | 2767 | 30 | 2872 | Complete Genome | na | ASM1342v1 | current | haploid | PRJNA237 | SAMN02604235 | [{'accession': 'PRJNA237'}] | Staphylococcus aureus subsp. aureus NCTC 8325 | 93061 | Sample from Staphylococcus aureus subsp. aureus NCTC 8325 | 2015-05-18T13:21:01.110 | ['Generic'] | na | NCBI | Generic.1.0 | 2014-01-30T15:13:19.920 | live | 2014-01-30T15:13:19.920 | 2014-01-30T15:13:19.920 | GCA\_000013425.1 | Annotation submitted by University of Oklahoma Health Sciences Center | current | reference genome | 2006-02-13 | na | University of Oklahoma Health Sciences Center | 1 | 2821361 | 927332 | 33 | na | 1 | 1 | 1 | 1 | 2821361 | 1 | 2821361 | 2821361 | 99.94 | GCA\_006094915.1 | 96.32 | type | Staphylococcus aureus | 97.66 | category\_na | na | species\_match | 99.94 | GCA\_006094915.1 | 96.32 | type | Staphylococcus aureus | 97.66 | Staphylococcus aureus subsp. aureus NCTC 8325 | Staphylococcus aureus | OK | Staphylococcus aureus | species | 1280 | v1.2.2 | 97.59 | 19.683367 | 0.39 | NCTC 8325 | Staphylococcus aureus subsp. aureus NCTC 8325 | 93061 | /path/to/genome/GCF\_000013425.1/GCF\_000013425.1\_ASM1342v1\_genomic.fna.gz |
| 562 | GCF\_000008865.2 | GCF\_000008865.2 | GCA\_000008865.2 | SOURCE\_DATABASE\_REFSEQ | na | Annotation submitted by NCBI RefSeq | na | NCBI RefSeq | 2021-02-12 | na | 126 | 5155 | 136 | 5417 | Complete Genome | na | ASM886v2 | current | haploid | PRJNA226 | SAMN01911278 | [{'accession': 'PRJNA226'}] | Escherichia coli O157:H7 str. Sakai | 386585 | Bacterial, clinical or host-associated sample for Escherichia coli O157:H7 str. SAKAI (EHEC) | 2019-05-23T15:25:40.989 | ['Pathogen.ba-cl'] | [{}] | ATCC | Pathogen.cl.1.0 | 2013-02-05T00:00:00.000 | live | 2014-11-20T09:44:57 | 2013-02-05T09:09:06.203 | GCA\_000008865.2 | Annotation submitted by GIRC | current | reference genome | 2018-06-08 | na | GIRC | 1 | 5498578 | 2824389 | 50.5 | na | 3 | 3 | 3 | 1 | 5498578 | 3 | 5594605 | 5594605 | 99.97 | GCA\_001281725.1 | 94.32 | claderef | Escherichia coli | 99.57 | category\_na | na | species\_match | 99.97 | GCA\_001281725.1 | 94.32 | claderef | Escherichia coli | 99.57 | Escherichia coli O157:H7 str. Sakai | Escherichia coli | OK | Escherichia coli | species | 562 | v1.2.2 | 99.51 | 92.85564 | 0.15 | Sakai substr. RIMD 0509952 | Escherichia coli O157:H7 str. Sakai | 386585 | /path/to/genome/GCF\_000008865.2/GCF\_000008865.2\_ASM886v2\_genomic.fna.gz |
| 1290 | GCF\_003812505.1 | GCF\_003812505.1 | GCA\_003812505.1 | SOURCE\_DATABASE\_REFSEQ | Best-placed reference protein set; GeneMarkS-2+ | GCF\_003812505.1-RS\_2024\_03\_28 | NCBI Prokaryotic Genome Annotation Pipeline (PGAP) | NCBI RefSeq | 2024-03-28 | 6.7 | 85 | 2142 | 35 | 2262 | Complete Genome | SMRT v. 2.3.0, HGAP v. 3.0 | ASM381250v1 | current | haploid | PRJNA231221 | SAMN10163251 | [{'accession': 'PRJNA231221'}] | Staphylococcus hominis | 1290 | Pathogen: clinical or host-associated sample from Staphylococcus hominis | 2019-05-14T13:08:20.304 | ['Pathogen.cl'] | [{}] | US Food and Drug Administration | Pathogen.cl.1.0 | 2018-10-02T00:00:00.000 | live | 2018-10-02T12:23:11.101 | 2018-10-02T12:23:11.100 | GCA\_003812505.1 | NCBI Prokaryotic Genome Annotation Pipeline (PGAP) | current | representative genome | 2018-11-21 | PacBio; Illumina | US Food and Drug Administration | 1 | 2220494 | 713682 | 31.5 | 19.6x | 3 | 3 | 3 | 1 | 2220494 | 3 | 2257431 | 2257431 | 99.99 | GCA\_900458635.1 | 98.99 | type | Staphylococcus hominis | 99.01 | category\_na | na | species\_match | 99.99 | GCA\_900458635.1 | 98.99 | type | Staphylococcus hominis | 99.01 | Staphylococcus hominis | Staphylococcus hominis | OK | Staphylococcus hominis | species | 1290 | v1.2.2 | 90.97 | 47.945206 | 2.63 | FDAARGOS\_575 | Staphylococcus hominis | 1290 | /path/to/genome/GCF\_003812505.1/GCF\_003812505.1\_ASM381250v1\_genomic.fna.gz |

Note

Some columns were removed for visual clarity

## Taxonomy

Table containing the full lineage from kingdom to species of each tax\_id

| accession | tax\_id | name | rank | kingdom | phylum | class | order | family | genus | species |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GCF\_000013425.1 | 93061 | Staphylococcus aureus subsp. aureus NCTC 8325 | strain | Bacteria | Bacillota | Bacilli | Bacillales | Staphylococcaceae | Staphylococcus | Staphylococcus aureus |
| GCF\_000008865.2 | 386585 | Escherichia coli O157:H7 str. Sakai | strain | Bacteria | Pseudomonadota | Gammaproteobacteria | Enterobacterales | Enterobacteriaceae | Escherichia | Escherichia coli |
| GCF\_003812505.1 | 1290 | Staphylococcus hominis | species | Bacteria | Bacillota | Bacilli | Bacillales | Staphylococcaceae | Staphylococcus | Staphylococcus hominis |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)