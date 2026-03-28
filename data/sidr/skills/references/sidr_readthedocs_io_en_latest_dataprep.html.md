[SIDR](index.html)

latest

* [Installing SIDR](install.html)
* Data Preparation
  + [Assembly](#assembly)
  + [Alignment](#alignment)
  + [BLAST](#blast)
  + [Taxonomy Dump](#taxonomy-dump)
* [Running With Raw Input](rundefault.html)
* [Running With a Runfile](runfilerun.html)
* [Runfile Example](runfileexample.html)

[SIDR](index.html)

* [Docs](index.html) »
* Data Preparation
* [Edit on GitHub](https://github.com/damurdock/SIDR/blob/master/docs/dataprep.rst)

---

# Data Preparation[¶](#data-preparation "Permalink to this headline")

In order to run SIDR, you will need to perform several analyses of your data. For the default analysis, you will need:

* A preliminary assembly
* An alignment back to that preliminary assembly
* A BLAST classification of that assembly
* A copy of the NCBI Taxonomy Dump

Alternatively, you can precalculate the data you wish to use to train the model, and save it in a specific format for input. This is explained here: [Running With a Runfile](runfilerun.html#runfilerun).

## Assembly[¶](#assembly "Permalink to this headline")

SIDR requires a preliminary assembly of your data built with standard *de novo* assembly techniques. The scaffolds from this assembly will be used as input for the machine learning model. During testing, the [ABySS](http://www.bcgsc.ca/platform/bioinfo/software/abyss) assembler was used to generate preliminary assemblies, however at this time no testing has been done as to the effect the preliminary assembler has on downstream assembly.

Regardless of the tools used, the final scaffold FASTA file will be used for input into SIDR.

## Alignment[¶](#alignment "Permalink to this headline")

The second piece of data required is an alignment of your raw reads to the preliminary assembly. The alignment can be constructed using any standard alignment tools, during testing [GSNAP](http://research-pub.gene.com/gmap/) was used. Regardless of the tools used, the alignment must be in a sorted and indexed BAM file. These can be created from a SAM alignment using the following [samtools](http://www.htslib.org/) commands:

```
samtools view -Sb /path/to/alignment.sam -o /path/to/alignment.bam
samtools sort /path/to/alignment.bam /path/to/alignment_sorted
samtools index /path/to/alignment_sorted.bam
```

## BLAST[¶](#blast "Permalink to this headline")

The last piece of data that must be precalculated is a [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi) classification of the preliminary assembly. This may be constructed with a tool besides command-line BLAST, so long as it is properly formatted. To make a properly-formatted BLAST result file, you can use the command:

```
blastn \
    -task megablast \
    -query /path/to/FASTA \
    -db nt \
    -outfmt '6 qseqid staxids' \
    -culling_limit 5 \
    -evalue 1e-25 \
    -out /path/to/output
```

Currently SIDR assumes that BLAST input will have the sequence ID in the first column, and the NCBI Taxonomy ID in the second column. Any alternative classification tool may be used so long as it can produce this output. Any additional columns in the BLAST output will be ignored.

## Taxonomy Dump[¶](#taxonomy-dump "Permalink to this headline")

SIDR uses the NCBI Taxonomy to translate the BLAST results into the desired classification. The Taxonomy dump can be downloaded from:

```
ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz
```

After downloading, extract it and note it’s location. By default, SIDR checks the directory listed in $BLASTDB, however this can be changed at runtime.

[Next](rundefault.html "Running With Raw Input")
 [Previous](install.html "Installing SIDR")

---

© Copyright 2017, Duncan Murdock.
Revision `37d56e54`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).