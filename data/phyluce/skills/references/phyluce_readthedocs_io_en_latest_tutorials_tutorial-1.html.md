[phyluce](../index.html)

Contents:

* [Purpose](../purpose.html)
* [Installation](../installation.html)
* [Phyluce Tutorials](index.html)
  + Tutorial I: UCE Phylogenomics
    - [Download the data](#download-the-data)
    - [Count the read data](#count-the-read-data)
    - [Clean the read data](#clean-the-read-data)
      * [Quality control](#quality-control)
    - [Assemble the data](#assemble-the-data)
      * [Assembly QC](#assembly-qc)
    - [Finding UCE loci](#finding-uce-loci)
    - [Extracting UCE loci](#extracting-uce-loci)
      * [Exploding the monolithic FASTA file](#exploding-the-monolithic-fasta-file)
    - [Aligning UCE loci](#aligning-uce-loci)
      * [Edge trimming](#edge-trimming)
      * [Internal trimming](#internal-trimming)
    - [Alignment cleaning](#alignment-cleaning)
    - [Final data matrices](#final-data-matrices)
    - [Preparing data for downstream analysis](#preparing-data-for-downstream-analysis)
      * [Downstream Analysis](#downstream-analysis)
    - [Next Steps](#next-steps)
  + [Tutorial II: Phasing UCE data](tutorial-2.html)
  + [Tutorial III: Harvesting UCE Loci From Genomes](tutorial-3.html)
  + [Tutorial IV: Identifying UCE Loci and Designing Baits To Target Them](tutorial-4.html)
* [Phyluce in Daily Use](../daily-use/index.html)

* [Citing](../citing.html)
* [License](../license.html)
* [Attributions](../attributions.html)
* [Funding](../funding.html)
* [Acknowledgements](../ack.html)

[phyluce](../index.html)

* [Phyluce Tutorials](index.html)
* Tutorial I: UCE Phylogenomics
* [View page source](../_sources/tutorials/tutorial-1.rst.txt)

---

# Tutorial I: UCE Phylogenomics[](#tutorial-i-uce-phylogenomics "Link to this heading")

In the following example, we are going to process raw read data from UCE enrichments performed against several divergent taxa so that you can get a feel for how a typical analysis goes. For more general analysis notes, see the [UCE Processing for Phylogenomics](../daily-use/daily-use-3-uce-processing.html#uce-processing) chapter. That said, this is a good place to start.

The taxa we are working with will be:

* Mus musculus (PE100)
* Anolis carolinensis (PE100)
* Alligator mississippiensis (PE150)
* Gallus gallus (PE250)

## Download the data[](#download-the-data "Link to this heading")

You can download the data from figshare (<http://dx.doi.org/10.6084/m9.figshare.1284521>). If you want to use the command line, you can use something like:

```
# create a project directory
mkdir uce-tutorial

# change to that directory
cd uce-tutorial

# download the data into a file names fastq.zip
wget -O fastq.zip https://ndownloader.figshare.com/articles/1284521/versions/2

# make a directory to hold the data
mkdir raw-fastq

# move the zip file into that directory
mv fastq.zip raw-fastq

# move into the directory we just created
cd raw-fastq

# unzip the fastq data
unzip fastq.zip

# delete the zip file
rm fastq.zip

# you should see 6 files in this directory now
ls -l

-rw-r--r--. 1 bcf users 4.4M Feb 22 14:14 Alligator_mississippiensis_GGAGCTATGG_L001_R1_001.fastq.gz
-rw-r--r--. 1 bcf users 4.3M Feb 22 14:14 Alligator_mississippiensis_GGAGCTATGG_L001_R2_001.fastq.gz
-rw-r--r--. 1 bcf users 4.9M Feb 22 14:14 Anolis_carolinensis_GGCGAAGGTT_L001_R1_001.fastq.gz
-rw-r--r--. 1 bcf users 4.9M Feb 22 14:15 Anolis_carolinensis_GGCGAAGGTT_L001_R2_001.fastq.gz
-rw-r--r--. 1 bcf users 7.6M Feb 22 14:15 Gallus_gallus_TTCTCCTTCA_L001_R1_001.fastq.gz
-rw-r--r--. 1 bcf users 8.4M Feb 22 14:15 Gallus_gallus_TTCTCCTTCA_L001_R2_001.fastq.gz
-rw-r--r--. 1 bcf users 4.9M Feb 22 14:16 Mus_musculus_CTACAACGGC_L001_R1_001.fastq.gz
-rw-r--r--. 1 bcf users 4.9M Feb 22 14:16 Mus_musculus_CTACAACGGC_L001_R2_001.fastq.gz
```

Alternatively, if you think of the filesystem as a tree-like structure, the directory in which we are working (uce-tutorial) would look like:

```
uce-tutorial
└── raw-fastq
    ├── Alligator_mississippiensis_GGAGCTATGG_L001_R1_001.fastq.gz
    ├── Alligator_mississippiensis_GGAGCTATGG_L001_R2_001.fastq.gz
    ├── Anolis_carolinensis_GGCGAAGGTT_L001_R1_001.fastq.gz
    ├── Anolis_carolinensis_GGCGAAGGTT_L001_R2_001.fastq.gz
    ├── Gallus_gallus_TTCTCCTTCA_L001_R1_001.fastq.gz
    ├── Gallus_gallus_TTCTCCTTCA_L001_R2_001.fastq.gz
    ├── Mus_musculus_CTACAACGGC_L001_R1_001.fastq.gz
    └── Mus_musculus_CTACAACGGC_L001_R2_001.fastq.gz
```

If you do not want to use the command line, you can download the data using the figshare interface or by clicking:

<http://downloads.figshare.com/article/public/1284521>

## Count the read data[](#count-the-read-data "Link to this heading")

Usually, we want a count of the actual number of reads in a given sequence file for a given species. We can do this several ways, but here, we’ll use tools from unix, because they are fast. The next line of code will count the lines in each R1 file (which should be equal to the reads in the R2 file) and divide that number by 4 to get the number of sequence reads.

```
for i in *_R1_*.fastq.gz; do echo $i; gunzip -c $i | wc -l | awk '{print $1/4}'; done
```

You should see:

```
Alligator_mississippiensis_GGAGCTATGG_L001_R1_001.fastq.gz
50000
Anolis_carolinensis_GGCGAAGGTT_L001_R1_001.fastq.gz
50000
Gallus_gallus_TTCTCCTTCA_L001_R1_001.fastq.gz
50000
Mus_musculus_CTACAACGGC_L001_R1_001.fastq.gz
50000
```

Notice that all the read counts are equal - that is because these 50,000 reads in each R1 and R2 file were subsampled, randomly, from a file of many more reads.

## Clean the read data[](#clean-the-read-data "Link to this heading")

The data you just downloaded are actual, raw, untrimmed fastq data. This means they contain adapter contamination and low quality bases. We need to remove these - which you can do several ways. We’ll use another program that I wrote ([illumiprocessor](https://github.com/faircloth-lab/illumiprocessor/)) because it allows us to trim many different indexed adapters from individual-specific fastq files - something that is a pain to do by hand. That said, you can certainly trim your reads however you would like. See the [illumiprocessor](https://github.com/faircloth-lab/illumiprocessor/) website for instructions on installing the program.

To use this program, we will create a configuration file that we will use to inform the program about which adapters are in which READ1 and READ2 files. The data we are trimming, here, are from TruSeq v3 libraries, but the indexes are 10 nucleotides long. We will set up the trimming file with these parameters, but please see the [illumiprocessor](https://github.com/faircloth-lab/illumiprocessor/) documentation for other options.

```
# this is the section where you list the adapters you used.  the asterisk
# will be replaced with the appropriate index for the sample.
[adapters]
i7:AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC*ATCTCGTATGCCGTCTTCTGCTTG
i5:AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT

# this is the list of indexes we used
[tag sequences]
BFIDT-166:GGAGCTATGG
BFIDT-016:GGCGAAGGTT
BFIDT-045:TTCTCCTTCA
BFIDT-011:CTACAACGGC

# this is how each index maps to each set of reads
[tag map]
Alligator_mississippiensis_GGAGCTATGG:BFIDT-166
Anolis_carolinensis_GGCGAAGGTT:BFIDT-016
Gallus_gallus_TTCTCCTTCA:BFIDT-045
Mus_musculus_CTACAACGGC:BFIDT-011

# we want to rename our read files something a bit more nice - so we will
# rename Alligator_mississippiensis_GGAGCTATGG to alligator_mississippiensis
[names]
Alligator_mississippiensis_GGAGCTATGG:alligator_mississippiensis
Anolis_carolinensis_GGCGAAGGTT:anolis_carolinensis
Gallus_gallus_TTCTCCTTCA:gallus_gallus
Mus_musculus_CTACAACGGC:mus_musculus
```

I create this file in a directory **above** the one holding my reads, so the
structure looks like:

```
uce-tutorial
├── illumiprocessor.conf
└── raw-fastq
    ├── Alligator_mississippiensis_GGAGCTATGG_L001_R1_001.fastq.gz
    ├── Alligator_mississippiensis_GGAGCTATGG_L001_R2_001.fastq.gz
    ├── Anolis_carolinensis_GGCGAAGGTT_L001_R1_001.fastq.gz
    ├── Anolis_carolinensis_GGCGAAGGTT_L001_R2_001.fastq.gz
    ├── Gallus_gallus_TTCTCCTTCA_L001_R1_001.fastq.gz
    ├── Gallus_gallus_TTCTCCTTCA_L001_R2_001.fastq.gz
    ├── Mus_musculus_CTACAACGGC_L001_R1_001.fastq.gz
    └── Mus_musculus_CTACAACGGC_L001_R2_001.fastq.gz
```

Now I run [illumiprocessor](https://github.com/faircloth-lab/illumiprocessor/) against the data. Note that I am using **4 physical CPU cores** to do this work. You need to use the number of physical cores available on your machine, although there is not sense in using more cores than you have taxa (in this case).

```
# go to the directory containing our config file and data
cd uce-tutorial

# run illumiprocessor

illumiprocessor \
    --input raw-fastq/ \
    --output clean-fastq \
    --config illumiprocessor.conf \
    --cores 4
```

The output should look like the following:

```
2021-02-22 14:59:26,488 - illumiprocessor - INFO - ==================== Starting illumiprocessor ===================
2021-02-22 14:59:26,489 - illumiprocessor - INFO - Version: 2.0.9
2021-02-22 14:59:26,489 - illumiprocessor - INFO - Argument --config: illumiprocessor.conf
2021-02-22 14:59:26,489 - illumiprocessor - INFO - Argument --cores: 4
2021-02-22 14:59:26,489 - illumiprocessor - INFO - Argument --input: /scratch/bfaircloth/uce-tutorial/raw-fastq
2021-02-22 14:59:26,490 - illumiprocessor - INFO - Argument --log_path: None
2021-02-22 14:59:26,490 - illumiprocessor - INFO - Argument --min_len: 40
2021-02-22 14:59:26,490 - illumiprocessor - INFO - Argument --no_merge: False
2021-02-22 14:59:26,490 - illumiprocessor - INFO - Argument --output: /scratch/bfaircloth/uce-tutorial/clean-fastq
2021-02-22 14:59:26,490 - illumiprocessor - INFO - Argument --phred: phred33
2021-02-22 14:59:26,491 - illumiprocessor - INFO - Argument --r1_pattern: None
2021-02-22 14:59:26,491 - illumiprocessor - INFO - Argument --r2_pattern: None
2021-02-22 14:59:26,491 - illumiprocessor - INFO - Argument --se: False
2021-02-22 14:59:26,491 - illumiprocessor - INFO - Argument --trimmomatic: /home/bcf/conda/envs/phyluce/bin/trimmomatic
2021-02-22 14:59:26,491 - illumiprocessor - INFO - Argument --verbosity: INFO
2021-02-22 14:59:26,904 - illumiprocessor - INFO - Trimming samples with Trimmomatic
Running....
2021-02-22 14:59:36,754 - illumiprocessor - INFO - =================== Completed illumiprocessor ===================
```

Notice that the program has created a `log` file showing what it did, and it has also created a new directory holding the clean data that has the name `clean-fastq` (what you told it to name the directory). Within that new directory, there are taxon-specific folder for the cleaned reads. More specifically, your directory structure should look similar to the following (I’ve collapsed the list of raw-reads):

```
uce-tutorial
├── clean-fastq
│   ├── alligator_mississippiensis
│   ├── anolis_carolinensis
│   ├── gallus_gallus
│   └── mus_musculus
├── illumiprocessor.conf
├── illumiprocessor.log
└── raw-fastq
```

Within each organism specific directory, there are more files and folders:

```
uce-tutorial
├── clean-fastq
│   ├── alligator_mississippiensis
│   │   ├── adapters.fasta
│   │   ├── raw-reads
│   │   ├── split-adapter-quality-trimmed
│   │   └── stats
│   ├── anolis_carolinensis
│   │   ├── adapters.fasta
│   │   ├── raw-reads
│   │   ├── split-adapter-quality-trimmed
│   │   └── stats
│   ├── gallus_gallus
│   │   ├── adapters.fasta
│   │   ├── raw-reads
│   │   ├── split-adapter-quality-trimmed
│   │   └── stats
│   └── mus_musculus
│       ├── adapters.fasta
│       ├── raw-reads
│       ├── split-adapter-quality-trimmed
│       └── stats
├── illumiprocessor.conf
├── illumiprocessor.log
└── raw-fastq
```

And, within each of those directories nested within the species-specific directory, there are additional files or links to files:

```
uce-tutorial
├── clean-fastq
│   ├── alligator_mississippiensis
│   │   ├── adapters.fasta
│   │   ├── raw-reads
│   │   │   ├── alligator_mississippiensis-READ1.fastq.gz -> <PATH>
│   │   │   └── alligator_mississippiensis-READ2.fastq.gz -> <PATH>
│   │   ├── split-adapter-quality-trimmed
│   │   │   ├── alligator_mississippiensis-READ1.fastq.gz
│   │   │   ├── alligator_mississippiensis-READ2.fastq.gz
│   │   │   └── alligator_mississippiensis-READ-singleton.fastq.gz
│   │   └── stats
│   │       └── alligator_mississippiensis-adapter-contam.txt
│   ├── anolis_carolinensis
│   ├── gallus_gallus
│   └── mus_musculus
├── illumiprocessor.conf
├── illumiprocessor.log
└── raw-fastq
```

I have collapsed the listing to show only the first taxon.

The -> in the raw-reads directory above means there are [symlinks](http://en.wikipedia.org/wiki/Symbolic_link) to the files. I have removed the file paths and replaced them with <PATH> so that the figure will fit on a page.

The really important information is in the split-adapter-quality-trimmed directory - which now holds our reads that have had adapter-contamination and low-quality bases removed. Within this split-adapter-quality-trimmed directory, the READ1 and READ2 files hold reads that remain in a pair (the reads are in the same consecutive order in each file). The READ-singleton file holds READ1 reads **OR** READ2 reads that lost their “mate” or “paired-read” because of trimming or removal.

### Quality control[](#quality-control "Link to this heading")

You might want to get some idea of what effect the trimming has on read counts and overall read lengths. There are certainly other (better) tools out there to do this (like [FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)), but you can get a reasonable idea of how good your reads are by running the following, which will output a CSV listing of read stats by sample:

```
# move to the directory holding our cleaned reads
cd clean-fastq/

# run this script against all directories of reads

for i in *;
do
    phyluce_assembly_get_fastq_lengths --input $i/split-adapter-quality-trimmed/ --csv;
done
```

The output you see should look like this:

```
All files in dir with alligator_mississippiensis-READ1.fastq.gz,93699,8418476,89.84595353205476,0.059508742244529164,40,100,100.0
All files in dir with anolis_carolinensis-READ-singleton.fastq.gz,92184,8401336,91.13659637247244,0.048890234925557836,40,100,100.0
All files in dir with gallus_gallus-READ1.fastq.gz,99444,21218771,213.37406982824504,0.16122899415574637,40,251,250.0
All files in dir with mus_musculus-READ2.fastq.gz,89841,8165734,90.89095179261139,0.052266485638855914,40,100,100.
```

Now, we’re ready to assemble our reads.

## Assemble the data[](#assemble-the-data "Link to this heading")

[phyluce](https://github.com/faircloth-lab/phyluce) has several options for assembly - you can use [velvet](http://www.ebi.ac.uk/~zerbino/velvet/), [abyss](http://www.bcgsc.ca/platform/bioinfo/software/abyss), or [spades](https://cab.spbu.ru/software/spades/). For this tutorial, we are going to use [spades](https://cab.spbu.ru/software/