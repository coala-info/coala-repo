# Running zAMP[¶](#running-zamp "Link to this heading")

Note

Before running zAMP see [Installation and resource requirements](setup.html#setup) and [Taxonomic reference databases](ref_DB_preprocessing.html#tax-db) sections.

zAMP can use reads locally or from NCBI’s [Sequence Read Archive (SRA)](https://www.ncbi.nlm.nih.gov/sra).

## Local reads[¶](#local-reads "Link to this heading")

### Sample sheet only[¶](#sample-sheet-only "Link to this heading")

*Command*:

```
zamp run -i samples.tsv
```

*Example samples.tsv* :

| sample | R1 | R2 | sample\_group | run |
| --- | --- | --- | --- | --- |
| SRR9067116 | reads/SRR9067116\_1.fastq.gz | reads/SRR9067116\_2.fastq.gz | Genital\_tract | run1 |
| SRR9067115 | reads/SRR9067115\_1.fastq.gz | reads/SRR9067115\_2.fastq.gz | Genital\_tract | run1 |
| SRR9067114 | reads/SRR9067114\_1.fastq.gz | reads/SRR9067114\_2.fastq.gz | Genital\_tract | run1 |
| SRR7225909 | reads/SRR7225909\_1.fastq.gz | reads/SRR7225909\_2.fastq.gz | human\_biliary\_tract | run2 |
| SRR7225908 | reads/SRR7225908\_1.fastq.gz | reads/SRR7225908\_2.fastq.gz | human\_biliary\_tract | run2 |
| SRR7225907 | reads/SRR7225907\_1.fastq.gz | reads/SRR7225907\_2.fastq.gz | human\_biliary\_tract | run2 |

* sample: the name of the sample
* R1: path to forward reads
* R2: path to reverse reads
* sample\_group: sample grouping for visualizations
* run: column for applying DADA2 error learning and denoising for each sequencing run

Note

You can add any other columns in the table provided the above mentionned columns are present

### Reads directory and metadata as input[¶](#reads-directory-and-metadata-as-input "Link to this heading")

*Command*:

```
zamp run -i reads -m metadata.tsv
```

*Example metadata.tsv* :

| fastq | sample | sample\_group | run |
| --- | --- | --- | --- |
| SRR9067116 | Vaginal-Library42 | Genital\_tract | run1 |
| SRR9067115 | Vaginal-Library41 | Genital\_tract | run1 |
| SRR9067114 | Vaginal-Library48 | Genital\_tract | run1 |
| SRR7225909 | NE14 | human\_biliary\_tract | run2 |
| SRR7225908 | A3D12 | human\_biliary\_tract | run2 |
| SRR7225907 | NN15 | human\_biliary\_tract | run2 |

## SRA reads[¶](#sra-reads "Link to this heading")

zAMP can fetch reads from NCBI’s [SRA](https://www.ncbi.nlm.nih.gov/sra) using [fasterq-dump](https://github.com/ncbi/sra-tools/wiki/HowTo%3A-fasterq-dump).

*Command*:

```
zamp run -i sra-samples.tsv
```

*Example sra-samples.tsv* :

| sample | sample\_label | sample\_group | run | paired |
| --- | --- | --- | --- | --- |
| SRR9067116 | Vaginal-16s-V3V4-Library42 | Genital\_tract | run1 | True |
| SRR9067115 | Vaginal-16s-V3V4-Library41 | Genital\_tract | run1 | True |

* sample\_label: label to rename the SRA fastq files
* paired: whether reads are paired or not (required because snakemake can’t guess the pairing from the fastq outputs easily )

# [zAMP](../index.html)

### Navigation

* [Installation and resource requirements](setup.html)
* [Taxonomic reference databases](ref_DB_preprocessing.html)
* Running zAMP
  + [Local reads](#local-reads)
  + [SRA reads](#sra-reads)
* [Under the hood](under_the_hood.html)
* [Downstream Analysis](downstream_analysis.html)
* [Frequently asked questions (FAQ)](FAQ.html)
* [*In silico* validation tool](insilico_validation.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Taxonomic reference databases](ref_DB_preprocessing.html "previous chapter")
  + Next: [Under the hood](under_the_hood.html "next chapter")

©2020, MetaGenLab.
|
Powered by [Sphinx 8.2.3](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](../_sources/pages/execution.rst.txt)