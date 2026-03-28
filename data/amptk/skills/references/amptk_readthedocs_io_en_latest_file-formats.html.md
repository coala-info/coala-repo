[AMPtk](index.html)

latest

* [AMPtk Overview](overview.html)
* [AMPtk Quick Start](quick-start.html)
* AMPtk file formats
  + [NGS Sequencing Data](#ngs-sequencing-data)
  + [Mapping file (QIIME-like)](#mapping-file-qiime-like)
  + [Barcode FASTA files](#barcode-fasta-files)
* [AMPtk Pre-Processing](pre-processing.html)
* [AMPtk Clustering](clustering.html)
* [AMPtk OTU Table Filtering](filtering.html)
* [AMPtk Taxonomy](taxonomy.html)
* [AMPtk Commands](commands.html)
* [AMPtk Downstream Tools](downstream.html)

[AMPtk](index.html)

* AMPtk file formats
* [Edit on GitHub](https://github.com/nextgenusfs/amptk/blob/master/docs/file-formats.rst)

---

# AMPtk file formats[¶](#amptk-file-formats "Link to this heading")

## NGS Sequencing Data[¶](#ngs-sequencing-data "Link to this heading")

AMPtk handles FASTQ or gzipped FASTQ input. Platform specific formats, i.e. SFF from 454 and BAM from Ion Torrent are also supported in their respective scripts.

## Mapping file (QIIME-like)[¶](#mapping-file-qiime-like "Link to this heading")

The pre-processing scripts in AMPtk will automatically produce a QIIME-like mapping file for you if one is not specified in the command line arguments. The format is simliar to used in QIIME, although has fewer formatting rules. This file is intended to be used as a metadata file in the `amptk taxonomy` script. Below is an example of a mapping file for a dual indexed PE MiSeq run:

```
#SampleID   BarcodeSequence LinkerPrimerSequence    ReversePrimer   phinchID        Treatment
301-1       TCCGGAGA-CCTATCCT       GTGARTCATCGAATCTTTG     TCCTCCGCTTATTGATATGC    301-1   no_data
301-2       TCCGGAGA-GGCTCTGA       GTGARTCATCGAATCTTTG     TCCTCCGCTTATTGATATGC    301-2   no_data
spike       CGCTCATT-GGCTCTGA       GTGARTCATCGAATCTTTG     TCCTCCGCTTATTGATATGC    spike   no_data
```

A properly formatted AMPtk mapping file contains the first 5 columns. Pre-processing scripts will parse the mapping file and grab the primer sequences. Ion Torrent and 454 mapping files should have the following format:

```
#SampleID   BarcodeSequence LinkerPrimerSequence    ReversePrimer   phinchID        Treatment       Location
BC.1        CTAAGGTAAC      CCATCTCATCCCTGCGTGTCTCCGACTCAGCTAAGGTAACAGTGARTCATCGAATCTTTG    TCCTCCGCTTATTGATATGC    BC.1    Treatment1      Woods
BC.2        TAAGGAGAAC      CCATCTCATCCCTGCGTGTCTCCGACTCAGTAAGGAGAACAGTGARTCATCGAATCTTTG    TCCTCCGCTTATTGATATGC    BC.2    Treatment1      Woods
BC.3        AAGAGGATTC      CCATCTCATCCCTGCGTGTCTCCGACTCAGAAGAGGATTCAGTGARTCATCGAATCTTTG    TCCTCCGCTTATTGATATGC    BC.3    Treatment2      Field
BC.4        TACCAAGATC      CCATCTCATCCCTGCGTGTCTCCGACTCAGTACCAAGATCAGTGARTCATCGAATCTTTG    TCCTCCGCTTATTGATATGC    BC.4    Treatment1      Field
BC.5        CAGAAGGAAC      CCATCTCATCCCTGCGTGTCTCCGACTCAGCAGAAGGAACAGTGARTCATCGAATCTTTG    TCCTCCGCTTATTGATATGC    BC.5    Treatment2      Woods
BC.6        CTGCAAGTTC      CCATCTCATCCCTGCGTGTCTCCGACTCAGCTGCAAGTTCAGTGARTCATCGAATCTTTG    TCCTCCGCTTATTGATATGC    BC.6    Treatment2      Woods
BC.7        TTCGTGATTC      CCATCTCATCCCTGCGTGTCTCCGACTCAGTTCGTGATTCAGTGARTCATCGAATCTTTG    TCCTCCGCTTATTGATATGC    BC.7    Treatment2      Field
```

Note that the barcode is nested within the ‘LinkerPrimerSequence’ column. In this example, there are two metadata columns (Treatment and Location).

## Barcode FASTA files[¶](#barcode-fasta-files "Link to this heading")

Barcode FASTA files for pre-processing should be in standard FASTA format:

```
>Sample1
CTAAGGTAAC
>Sample2
TAAGGAGAAC
>Sample3
AAGAGGATTC
>Sample4
TACCAAGATC
>Sample5
CAGAAGGAAC
>Mock
CTGCAAGTTC
```

[Previous](quick-start.html "AMPtk Quick Start")
[Next](pre-processing.html "AMPtk Pre-Processing")

---

© Copyright 2017, Jon Palmer.
Revision `15f497c3`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).