[![Logo](../_static/GTDBTk.svg)](../index.html)

2.6.1

Getting started

* [Announcements](../announcements.html)
* [Installing GTDB-Tk](../installing/index.html)
* [FAQ](../faq.html)

Running GTDB-Tk

* [Performance and Accuracy](../performance/index.html)
* [Commands](../commands/index.html)
* [Files](../files/index.html)
* Example
  + [Step 1: Obtaining data](#Step-1:-Obtaining-data)
  + [Step 2: Gene calling (identify)](#Step-2:-Gene-calling-(identify))
    - [Results](#Results)
  + [Step 3: Aligning genomes (align)](#Step-3:-Aligning-genomes-(align))
    - [Results](#id1)
  + [Step 4: Classifying genomes (classify)](#Step-4:-Classifying-genomes-(classify))
    - [Results](#id2)

About

* [Change log](../changelog.html)
* [References](../references.html)

[GTDB-Tk](../index.html)

* »
* Example
* [Edit on GitHub](https://github.com/Ecogenomics/GTDBTk/blob/master/docs/src/examples/classify_wf.ipynb)

---

# Example[¶](#Example "Permalink to this headline")

This jupyter notebook demonstrates how to run the `classify_wf` command on a set of test genomes.

For a full list of commands see: \* `gtdbtk -h`, or \* [GTDB-Tk commands](https://ecogenomics.github.io/GTDBTk/commands/)

## Step 1: Obtaining data[¶](#Step-1:-Obtaining-data "Permalink to this headline")

This example will use the following two genomes that we will refer to as: \* Genome A: `GCF_003947435.1` [[GTDB](https://gtdb.ecogenomic.org/genomes?gid=GCF_003947435.1) / [NCBI](https://www.ncbi.nlm.nih.gov/assembly/GCF_003947435.1/)] \* Genome B: `GCA_002011125.1` [[GTDB](https://gtdb.ecogenomic.org/genomes?gid=GCA_002011125.1) / [NCBI](https://www.ncbi.nlm.nih.gov/assembly/GCA_002011125.1/)]

```
[5]:
```

```
# Create the directory.
!mkdir -p /tmp/gtdbtk && cd /tmp/gtdbtk

# Obtain the genomes.
!mkdir -p /tmp/gtdbtk/genomes
!wget -q https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/947/435/GCF_003947435.1_ASM394743v1/GCF_003947435.1_ASM394743v1_genomic.fna.gz -O /tmp/gtdbtk/genomes/genome_a.fna.gz
!wget -q https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/011/125/GCA_002011125.1_ASM201112v1/GCA_002011125.1_ASM201112v1_genomic.fna.gz -O /tmp/gtdbtk/genomes/genome_b.fna.gz
```

## Step 2: Gene calling (identify)[¶](#Step-2:-Gene-calling-(identify) "Permalink to this headline")

Note that the workflow can be run as a single command `classify_wf`, however, each step will be run individually in this notebook. It can sometimes be useful to run the steps individually when processing large pipelines.

```
[ ]:
```

```
!ls -l /tmp/gtdbtk/genomes
```

```
[2]:
```

```
!gtdbtk identify --genome_dir /tmp/gtdbtk/genomes --out_dir /tmp/gtdbtk/identify --extension gz --cpus 2
```

```
[2022-04-11 11:48:59] INFO: GTDB-Tk v2.0.0
[2022-04-11 11:48:59] INFO: gtdbtk identify --genome_dir /tmp/gtdbtk/genomes --out_dir /tmp/gtdbtk/identify --extension gz --cpus 2
[2022-04-11 11:48:59] INFO: Using GTDB-Tk reference data version r207: /srv/db/gtdbtk/official/release207
[2022-04-11 11:48:59] INFO: Identifying markers in 2 genomes with 2 threads.
[2022-04-11 11:48:59] TASK: Running Prodigal V2.6.3 to identify genes.
[2022-04-11 11:49:10] INFO: Completed 2 genomes in 10.94 seconds (5.47 seconds/genome).
[2022-04-11 11:49:10] TASK: Identifying TIGRFAM protein families.
[2022-04-11 11:49:16] INFO: Completed 2 genomes in 5.78 seconds (2.89 seconds/genome).
[2022-04-11 11:49:16] TASK: Identifying Pfam protein families.
[2022-04-11 11:49:16] INFO: Completed 2 genomes in 0.42 seconds (4.81 genomes/second).
[2022-04-11 11:49:16] INFO: Annotations done using HMMER 3.1b2 (February 2015).
[2022-04-11 11:49:16] TASK: Summarising identified marker genes.
[2022-04-11 11:49:16] INFO: Completed 2 genomes in 0.05 seconds (40.91 genomes/second).
[2022-04-11 11:49:16] INFO: Done.
```

### Results[¶](#Results "Permalink to this headline")

The called genes and marker information can be found under each genomes respeective intermediate files directory, as shown below.

```
[4]:
```

```
!ls /tmp/gtdbtk/identify/identify/intermediate_results/marker_genes/genome_a.fna/
```

```
genome_a.fna_pfam_tophit.tsv         genome_a.fna_protein.gff.sha256
genome_a.fna_pfam_tophit.tsv.sha256  genome_a.fna_tigrfam.out
genome_a.fna_pfam.tsv                genome_a.fna_tigrfam.out.sha256
genome_a.fna_pfam.tsv.sha256         genome_a.fna_tigrfam_tophit.tsv
genome_a.fna_protein.faa             genome_a.fna_tigrfam_tophit.tsv.sha256
genome_a.fna_protein.faa.sha256      genome_a.fna_tigrfam.tsv
genome_a.fna_protein.fna             genome_a.fna_tigrfam.tsv.sha256
genome_a.fna_protein.fna.sha256      prodigal_translation_table.tsv
genome_a.fna_protein.gff             prodigal_translation_table.tsv.sha256
```

However, it is sometimes more useful to just read the summary files which detail markers identified from either the archaeal 53, or bacterial 120 marker set.

```
[5]:
```

```
!cat /tmp/gtdbtk/identify/identify/gtdbtk.ar53.markers_summary.tsv
```

```
name    number_unique_genes     number_multiple_genes   number_multiple_unique_genes    number_missing_genes    list_unique_genes       list_multiple_genes     list_multiple_unique_genes      list_missing_genes
genome_a.fna    44      0       0       9       PF00410.20,PF00466.21,PF00687.22,PF00827.18,PF00900.21,PF01000.27,PF01015.19,PF01090.20,PF01200.19,PF01280.21,PF04919.13,PF07541.13,TIGR00037,TIGR00111,TIGR00134,TIGR00279,TIGR00291,TIGR00323,TIGR00335,TIGR00405,TIGR00448,TIGR00483,TIGR00491,TIGR00967,TIGR00982,TIGR01008,TIGR01012,TIGR01018,TIGR01020,TIGR01028,TIGR01046,TIGR01052,TIGR01213,TIGR01952,TIGR02236,TIGR02390,TIGR03626,TIGR03627,TIGR03628,TIGR03671,TIGR03672,TIGR03674,TIGR03676,TIGR03680                     TIGR00064,TIGR00373,TIGR00522,TIGR01171,TIGR02338,TIGR02389,TIGR03629,TIGR03670,TIGR03673
genome_b.fna    50      0       0       3       PF00410.20,PF00466.21,PF00687.22,PF00827.18,PF00900.21,PF01000.27,PF01015.19,PF01090.20,PF01200.19,PF01280.21,PF04919.13,PF07541.13,TIGR00037,TIGR00064,TIGR00111,TIGR00134,TIGR00279,TIGR00291,TIGR00323,TIGR00335,TIGR00373,TIGR00405,TIGR00448,TIGR00483,TIGR00491,TIGR00522,TIGR00967,TIGR00982,TIGR01008,TIGR01012,TIGR01018,TIGR01020,TIGR01028,TIGR01046,TIGR01052,TIGR01952,TIGR02236,TIGR02338,TIGR02389,TIGR02390,TIGR03626,TIGR03628,TIGR03629,TIGR03670,TIGR03671,TIGR03672,TIGR03673,TIGR03674,TIGR03676,TIGR03680                 TIGR01171,TIGR01213,TIGR03627
```

## Step 3: Aligning genomes (align)[¶](#Step-3:-Aligning-genomes-(align) "Permalink to this headline")

The align step will align all identified markers, determine the most likely domain and output a concatenated MSA.

```
[7]:
```

```
!gtdbtk align --identify_dir /tmp/gtdbtk/identify --out_dir /tmp/gtdbtk/align --cpus 2
```

```
[2022-04-11 11:59:14] INFO: GTDB-Tk v2.0.0
[2022-04-11 11:59:14] INFO: gtdbtk align --identify_dir /tmp/gtdbtk/identify --out_dir /tmp/gtdbtk/align --cpus 2
[2022-04-11 11:59:14] INFO: Using GTDB-Tk reference data version r207: /srv/db/gtdbtk/official/release207
[2022-04-11 11:59:15] INFO: Aligning markers in 2 genomes with 2 CPUs.
[2022-04-11 11:59:16] INFO: Processing 2 genomes identified as archaeal.
[2022-04-11 11:59:16] INFO: Read concatenated alignment for 3,412 GTDB genomes.
[2022-04-11 11:59:16] TASK: Generating concatenated alignment for each marker.
[2022-04-11 11:59:16] INFO: Completed 2 genomes in 0.01 seconds (139.73 genomes/second).
[2022-04-11 11:59:16] TASK: Aligning 52 identified markers using hmmalign 3.1b2 (February 2015).
[2022-04-11 11:59:17] INFO: Completed 52 markers in 0.86 seconds (60.66 markers/second).
[2022-04-11 11:59:17] TASK: Masking columns of archaeal multiple sequence alignment using canonical mask.
[2022-04-11 11:59:21] INFO: Completed 3,414 sequences in 4.19 seconds (815.22 sequences/second).
[2022-04-11 11:59:21] INFO: Masked archaeal alignment from 13,540 to 10,153 AAs.
[2022-04-11 11:59:21] INFO: 0 archaeal user genomes have amino acids in <10.0% of columns in filtered MSA.
[2022-04-11 11:59:21] INFO: Creating concatenated alignment for 3,414 archaeal GTDB and user genomes.
[2022-04-11 11:59:23] INFO: Creating concatenated alignment for 2 archaeal user genomes.
[2022-04-11 11:59:23] INFO: Done.
```

### Results[¶](#id1 "Permalink to this headline")

It is important to pay attention to the output, if a genome had a low number of markers identified it will be excluded from the analysis at this step. A warning will appear if that is the case.

Depending on the domain, a prefixed file of either `ar53` or `bac120` will appear containing the MSA of the user genomes and the GTDB genomes, or just the user genomes (`gtdbtk.ar53.msa.fasta.gz` and `gtdbtk.ar53.user_msa.fasta.gz` respectively.)

```
[8]:
```

```
!ls /tmp/gtdbtk/align/align/
```

```
gtdbtk.ar53.filtered.tsv  gtdbtk.ar53.user_msa.fasta.gz
gtdbtk.ar53.msa.fasta.gz  intermediate_results
```

## Step 4: Classifying genomes (classify)[¶](#Step-4:-Classifying-genomes-(classify) "Permalink to this headline")

The classify step will place the genomes into a reference tree, then determine their most likely classification.

```
[2]:
```

```
!gtdbtk classify --genome_dir /tmp/gtdbtk/genomes --align_dir /tmp/gtdbtk/align --out_dir /tmp/gtdbtk/classify -x gz --cpus 2
```

```
/bin/bash: gtdbtk: command not found
```

### Results[¶](#id2 "Permalink to this headline")

The two main files output are the summary files (`gtdbtk.ar53.summary.tsv`, and `gtdbtk.bac120.summary.tsv` respectively). Classification of the genomes are present in the summary file.

```
[10]:
```

```
!ls /tmp/gtdbtk/classify
```

```
classify  gtdbtk.ar53.summary.tsv  gtdbtk.log  gtdbtk.warnings.log
```

```
[ ]:
```

```

```

[Next](../changelog.html "Change log")
 [Previous](../files/failed_genomes.tsv.html "failed.genomes.tsv")

---

© Copyright 2025, Pierre-Alain Chaumeil, Aaron Mussig and Donovan Parks.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).