### Navigation

* [index](../../genindex/ "General Index")
* [next](../Scoring_tutorial/ "5. Tutorial: how to create a scoring configuration file") |
* [previous](../ "3. Tutorial") |
* [Mikado](../../) »

# 4. Tutorial for Daijin[¶](#tutorial-for-daijin "Permalink to this headline")

This tutorial will guide you through the task of configuring and running the whole Daijin pipeline on a *Drosophila melanogaster* dataset comprising two different samples, using one aligner (HISAT) and two assemblers (Stringtie and CLASS2) as chosen methods. A modern desktop computer with a multicore processor and 4GB of RAM or more should suffice to execute the pipeline within two hours.

Warning

Please note that **development of Daijin Assemble has now been discontinued**. Daijin will be superseded by a different pipeline manager, which is currently in the works. We will continue the active maintenance the “mikado” part of the pipeline, which is dedicated to run the steps between a set of input transcript assemblies and/or cDNA alignments until the final Mikado output.

## 4.1. Overview[¶](#overview "Permalink to this headline")

The tutorial will guide you through the following tasks:

1. Configuring Daijin to analyse the chosen data
2. Running the alignment and assemblies using `daijin assemble`
3. Running the Mikado analysis using `daijin mikado`
4. Comparing the results against the reference transcriptome

## 4.2. Required software[¶](#required-software "Permalink to this headline")

Mikado should be installed and configured properly (see our [installation instructions](../../Installation/#installation)). Additionally, you should have the following software tools at disposal (between brackets is indicated the version used at the time of the writing):

* DIAMOND (v0.8.22 or later)
* Prodigal (v2.6.3 or later)
* Portcullis (v1.0.2 or later)
* HISAT2 (v2.0.4)
* Stringtie (v1.2.4)
* CLASS2 (v2.12)
* SAMtools (v1.1 or later)

## 4.3. Input data[¶](#input-data "Permalink to this headline")

Throughout this tutorial, we will use data coming from EnsEMBL v89, and from the [PRJEB15540](http://www.ebi.ac.uk/ena/data/view/PRJEB15540) experiment on ENA. In particular, we will need:

> * the genome FASTA file of *Drosophila melanogaster*
> * its relative genome annotation
> * RNA-Seq from two samples of the [PRJEB15540](http://www.ebi.ac.uk/ena/data/view/PRJEB15540) study:
>
>   > + [ERX1732854](http://www.ebi.ac.uk/ena/data/view/ERX1732854), left (ERR1662533\_1.fastq.gz) and right (ERR1662533\_2.fastq.gz) reads
>   > + [ERX1732855](http://www.ebi.ac.uk/ena/data/view/ERX1732855), left (ERR1662534\_1.fastq.gz) and right (ERR1662534\_2.fastq.gz) reads
> * protein sequences for the related species *Aedes aegypti*, [downloaded from Uniprot](%22http%3A//www.uniprot.org/uniprot/?sort=score&desc=&compress=yes&query=taxonomy:diptera%20NOT%20taxonomy:%22Drosophila%20(fruit%20flies)%20[7215]%22%20AND%20taxonomy:%22Aedes%20aegypti%22&fil=&format=fasta&force=yes")

## 4.4. Preparation of the input data[¶](#preparation-of-the-input-data "Permalink to this headline")

First of all, let us set up a folder with the reference data:

```
mkdir -p Reference;
cd Reference;
wget ftp://ftp.ensembl.org/pub/release-89/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP6.89.gtf.gz;
wget ftp://ftp.ensembl.org/pub/release-89/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.dna.toplevel.fa.gz;
wget "http://www.uniprot.org/uniprot/?sort=score&desc=&compress=yes&query=taxonomy:diptera%20NOT%20taxonomy:%22Drosophila%20(fruit%20flies)%20[7215]%22%20AND%20taxonomy:%22Aedes%20aegypti%22&fil=&format=fasta&force=yes" -O Aedes_aegypti.fasta.gz;
gunzip *gz;
cd ../;
```

The snippet of the bash script above will create a “Reference” directory, download the genome of *D. melanogaster* in FASTA file, the corresponding GTF, and the protein sequences for *Aedes aegypti*. It will also decompress all files.

It is possible to have a feel for the annnotation of this species - the size of its genes and transcripts, the average number of exons per transcript, etc - by using `mikado util stats`; just issue the following command:

```
mikado util stats Reference/Drosophila_melanogaster.BDGP6.89.gtf Reference/Drosophila_melanogaster.BDGP6.89.stats.txt 2> Reference/stats.err
```

These are the results:

| Stat | Total | Average | Mode | Min | 1% | 5% | 10% | 25% | Median | 75% | 90% | 95% | 99% | Max |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Number of genes | 17559 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| Number of genes (coding) | 13898 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| Number of monoexonic genes | 4772 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| Transcripts per gene | 34740 | 1.98 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 2 | 4 | 5 | 10 | 75 |
| Coding transcripts per gene | 30308 | 1.73 | 1 | 0 | 0 | 0 | 0 | 1 | 1 | 2 | 4 | 5 | 10 | 69 |
| CDNA lengths | 90521553 | 2,605.69 | 22 | 20 | 58 | 322 | 526 | 988 | 1,888 | 3,373 | 5,361 | 7,025 | 11,955 | 71,382 |
| CDNA lengths (mRNAs) | 87158361 | 2,875.75 | 1023 | 108 | 379 | 571 | 748 | 1,247 | 2,147 | 3,628 | 5,636 | 7,312 | 12,444 | 71,382 |
| CDS lengths | 59968005 | 1,726.19 | 0 | 0 | 0 | 0 | 0 | 525 | 1,212 | 2,142 | 3,702 | 5,106 | 9,648 | 68,847 |
| CDS lengths (mRNAs) | NA | 1,978.62 | 372 | 33 | 177 | 315 | 435 | 780 | 1,404 | 2,361 | 3,915 | 5,480 | 10,149 | 68,847 |
| CDS/cDNA ratio | NA | 67.88 | 75.0 | 1 | 14 | 29 | 40 | 56 | 71 | 83 | 91 | 94 | 99 | 100 |
| Monoexonic transcripts | 5899 | 882.90 | 22 | 20 | 21 | 25 | 73 | 288 | 640 | 1,154 | 1,898 | 2,470 | 4,517 | 21,216 |
| MonoCDS transcripts | 4269 | 912.26 | 372 | 33 | 114 | 186 | 249 | 402 | 723 | 1,227 | 1,789 | 2,153 | 3,721 | 9,405 |
| Exons per transcript | 186414 | 5.37 | 1 | 1 | 1 | 1 | 1 | 2 | 4 | 7 | 11 | 15 | 24 | 82 |
| Exons per transcript (mRNAs) | 3715 | 5.93 | 2 | 1 | 1 | 1 | 2 | 3 | 4 | 8 | 12 | 15 | 26 | 82 |
| Exon lengths | NA | 485.59 | 156 | 1 | 33 | 69 | 93 | 145 | 251 | 554 | 1,098 | 1,606 | 3,303 | 28,074 |
| Exon lengths (mRNAs) | NA | 485.18 | 156 | 1 | 36 | 70 | 95 | 146 | 250 | 554 | 1,102 | 1,612 | 3,277 | 28,074 |
| Intron lengths | NA | 1,608.99 | 61 | 2 | 52 | 55 | 58 | 63 | 102 | 742 | 3,482 | 7,679 | 25,852 | 257,022 |
| Intron lengths (mRNAs) | NA | 1,597.85 | 61 | 23 | 52 | 55 | 58 | 63 | 102 | 744 | 3,472 | 7,648 | 25,529 | 257,022 |
| CDS exons per transcript | 2761 | 4.60 | 2 | 0 | 0 | 0 | 0 | 1 | 3 | 6 | 10 | 13 | 23 | 81 |
| CDS exons per transcript (mRNAs) | 2761 | 5.27 | 2 | 1 | 1 | 1 | 1 | 2 | 4 | 7 | 11 | 14 | 24 | 81 |
| CDS exon lengths | 59968005 | 375.21 | 156 | 1 | 12 | 48 | 73 | 123 | 197 | 407 | 848 | 1,259 | 2,523 | 27,705 |
| CDS Intron lengths | 165622620 | 1,278.75 | 60 | 22 | 51 | 54 | 56 | 61 | 81 | 525 | 2,503 | 5,629 | 21,400 | 257,021 |
| 5’UTR exon number | 30308 | 1.52 | 1 | 0 | 0 | 1 | 1 | 1 | 1 | 2 | 2 | 3 | 4 | 13 |
| 3’UTR exon number | 30308 | 1.11 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 2 | 4 | 29 |
| 5’UTR length | 9330312 | 307.85 | 0 | 0 | 0 | 21 | 39 | 87 | 185 | 407 | 702 | 960 | 1,684 | 5,754 |
| 3’UTR length | 17860044 | 589.28 | 3 | 0 | 3 | 45 | 68 | 126 | 299 | 724 | 1,398 | 2,079 | 4,048 | 18,497 |
| Stop distance from junction | NA | 31.30 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 23 | 1,027 | 10,763 |
| Intergenic distances | NA | 1,991.60 | 235 | -1,472,736 | -42,934 | -6,222 | -1,257 | 37 | 335 | 1,894 | 9,428 | 18,101 | 47,477 | 1,125,562 |
| Intergenic distances (coding) | NA | 2,842.58 | 1 | -351,626 | -38,336 | -4,836 | -316 | 58 | 347 | 1,798 | 10,218 | 21,258 | 56,471 | 932,526 |

From this summary it is quite apparent that the *D. melanogaster* genome preferentially encodes multiexonic transcripts, which on average have ~30% of their sequence in UTRs. Intron lengths are generally over 1.5 kbps, with a very long maximum value of approximately 257 kbps. Genes on average are separated by 3 kbps stretches of intergenic regions, although there is considerable variation, with over 25% of the genes overlapping one another.

Next, we download the reads that we will use for this example:

```
mkdir -p Reads;
cd Reads;
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR166/003/ERR1662533/ERR1662533_1.fastq.gz;
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR166/003/ERR1662533/ERR1662533_2.fastq.gz;
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR166/004/ERR1662534/ERR1662534_1.fastq.gz;
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR166/004/ERR1662534/ERR1662534_2.fastq.gz;
cd ../;
```

These files have a total file size of approximately 4GB, so they might take five to ten minutes to download, depending on your connection speed.

## 4.5. Step 1: configuring Daijin[¶](#step-1-configuring-daijin "Permalink to this headline")

The first task is to create a configuration file for Daijin using `daijin configure`. On the command line, we have to configure the following:

* name of the configuration file (daijin.yaml)
* number of threads per process (2)
* reference genome and the name of the species (**without spaces or non-ASCII/special characters**)
* reads to use, with their strandedness and the name of the sample
* aligners (HISAT2) and assemblers (Stringtie, CLASS2)
* output directory (Dmelanogaster)
* the scoring file to use for Mikado pick; we will ask to copy it in-place to have a look at it (dmelanogaster\_scoring.yaml)
* the protein database for homology searches for Mikado (Aedes\_aegypti.fasta)
* flank: as *D. melanogaster* has a relatively compact genome, we should decrease the maximum distance for grouping together transcripts. We will decrease from 1kbps (default) to 500.
* (optional) the scheduler to use for the cluster (we will presume that the job is being executed locally)
* (optional) name of the cluster configuration file, which will have to be edited manually.

First, we will create a sample sheet, containing the information of the sample that we are going to use. This is a tab-delimited text file, where each line defines a single sample, and with up to 5 columns per line. The first three columns are mandatory, while the last two are optional. The columns are as follows:

> * **Read1**: required. Location of the left reads for the sample.
> * **Read2**: optional, location of the right reads for the sample if it is paired.
> * **Sample**: name of the sample. Required.
> * **Strandedness**: strandedness of the sample. It can be one of:
>
>   > + fr-unstranded (Unstranded data)
>   > + fr-firststrand (Stranded data, first read forward, second read reverse)
>   > + fr-secondstrand (Stranded data, second read forward, first read reverse)
>   > + f (Forward, single read only)
>   > + r (Reverse, single read only)
> * **Long read sample**: Boolean flag. If set to “True”, the sample will be considered as coming from a non-second generation sequencing platform (eg. Sanger ESTs or PacBio IsoSeq) and for its reads we would therefore consider only the alignment, without performing any assembly.

For our example, therefore, the sample sheet will look like this:

```
Reads/ERR1662533_1.fastq.gz Reads/ERR1662533_2.fastq.gz     ERR1662533      fr-unstranded   False
Reads/ERR1662534_1.fastq.gz Reads/ERR1662534_2.fastq.gz     ERR1662534      fr-unstranded   False
```

Write this into a text file called “sample\_sheet.tsv”.
Now we will configure Daijin for the run:

```
daijin configure --scheduler "local" \
     --scoring HISTORIC/dmelanogaster_scoring.yaml \
     --copy-scoring dmelanogaster_scoring.yaml \
     -m permissive --sample-sheet sample_sheet.tsv \
     --flank 500 -i 50 26000 --threads 2 \
     --genome Reference/Drosophila_melanogaster.BDGP6.dna.toplevel.fa \
     -al hisat -as class stringtie -od Dmelanogaster --name Dmelanogaster \
     -o daijin.toml --prot-db Reference/Aedes_aegypti.fasta;
```

This will create three files in the working directory:

> * **daijin.yaml**, the main configuration file. This file is in [TOML format](https://toml.io/en/v1.0.0).
> * *dmelanogaster.yaml*: this file is a copy of the scoring configuration file. Please refer to the [dedicated section](../../Scoring_files/#scoring-files) for details.
> * *daijin\_exe.yaml*: this small configuration file contains the instruction to load the necessary software into the working environment. Ignore it if you are working on a local machine. If you are working within a cluster environment, please modify this file with the normal commands you would use in a cluster script to load necessary software. For example, this is how this file looks like on our own cluster system:

```
blast: 'source blast-2.3.0'
class: 'source class-2.12'
cufflinks: ''
gmap: ''
hisat: 'source HISAT-2.0.4'
mikado: 'source mikado-1.1'
portcullis: 'source portcullis-0.17.2'
samtools: 'source samtools-1.2'
star: ''
stringtie: 'source stringtie-1.2.4'
tophat: ''
transdecoder: 'source transdecoder-3.0.0'
trinity: ''
```

Important

If you are operating on a cluster, instead of a local machine, you will need to specify the scheduler type. Currently we support **SLURM, PBS and LSF**. Add the following switch to the configure command above:

```
--scheduler <One of local, SLURM, PBS or LSF>
```

Adding this switch will also create a default cluster configuration file, *daijin\_hpc.yaml*, specifying the number of resources per job and the submission queue. This is an example of how it appears on our system:

```
__default__:
    threads: 4
    memory: 10000
asm_trinitygg:
    memory: 20000
bam_sort:
    memory: 20000
```

## 4.6. Step 2: running the assemble part[¶](#step-2-running-the-assemble-part "Permalink to this headline")

Now that we have created a proper configuration file, it is time to launch Daijin assemble and inspect the results. Issue the command:

```
daijin assemble --cores <Number of maximum cores> daijin.toml
```

After checking that the configuration file is valid, Daijin will start the alignment and assembly of the dataset. On a normal desktop computer, this should take less than 2 hours. Before launching the pipeline, you can obtain a graphical representation of the steps with:

```
daijin assemble --dag daijin.toml | dot -Tsvg > assemble.svg
```

[![schematic diagram of the assembling pipeline](../../_images/assemble_pipeline.png)](../../_images/assemble_pipeline.png)

You can also ask Daijin to display the steps to be executed, inclusive of their command lines, by issuing the following command:

```
daijin assemble --dryrun daijin.toml
```

When Daijin is finished, have a look inside the folder Dmelanogaster/3-assemblies/output/; you will find the following GTF files:

* Dmelanogaster/3-assemblies/output/class-0-hisat-ERR1662533-0.gtf
* Dmelanogaster/3-assemblies/output/class-0-hisat-ERR1662534-0.gtf
* Dmelanogaster/3-assemblies/output/stringtie-0-hisat-ERR1662533-0.gtf
* Dmelanogaster/3-assemblies/output/stringtie-0-hisat-ERR1662534-0.gtf

These are standard [GTF files](http://www.ensembl.org/info/websi