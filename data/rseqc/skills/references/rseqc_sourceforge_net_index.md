### Navigation

* [index](genindex.html "General Index")
* RSeQC documentation »
* RSeQC: An RNA-seq Quality Control Package

# RSeQC: An RNA-seq Quality Control Package[¶](#rseqc-an-rna-seq-quality-control-package "Link to this heading")

RSeQC package provides a number of useful modules that can comprehensively evaluate high
throughput sequence data especially RNA-seq data. Some basic modules quickly inspect sequence
quality, nucleotide composition bias, PCR bias and GC bias, while RNA-seq specific modules
evaluate sequencing saturation, mapped reads distribution, coverage uniformity, strand specificity, transcript level RNA integrity etc.

# Release history[¶](#release-history "Link to this heading")

**RSeQC v5.0.4**

* Oct 3, 2024

Add `pyproject.toml` file to manage project metadata.

**RSeQC v5.0.1**

* Oct 20, 2022
* Fix a bug in `scbam.py` to make it compatible with the latest [pysam](https://pysam.readthedocs.io/en/latest/index.html) (v0.19.1).

**RSeQC v5.0.0**

* Oct 16, 2022
* add these functions to QC scRNA-seq data.
  \* `sc_bamStat.py`
  \* `sc_editMatrix.py`
  \* `sc_seqLogo.py`
  \* `sc_seqQual.py`

**RSeQC v4.0.0**

* Aug. 21, 2020
* Add `FPKM-UQ.py` to calcualte HTSeq count, FPKM and [FPKM-UQ](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/#upper-quartile-fpkm) values defined by [TCGA](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/)
* `FPKM-UQ.py` could exactly reproduce TCGA FPKM-UQ values, if you use TCGA BAM file (or follow TCGA RNA-seq alignment workflow to generate your own BAM file), the [GDC.h38 GENCODE v22 GTF](https://api.gdc.cancer.gov/data/25aa497c-e615-4cb7-8751-71f744f9691f) file and the [GDC.h38 GENCODE TSV](https://api.gdc.cancer.gov/data/b011ee3e-14d8-4a97-aed4-e0b10f6bbe82) file.

**RSeQC v3.0.1**

* Sep. 21, 2019
* Junctions detected from the `junction_annotation.py` will be converted into [Interact](https://genome.ucsc.edu/goldenPath/help/interact.html) format file, which can be uploaded into UCSC genome browser for visualization. Example:

[![_images/junction_interact.png](_images/junction_interact.png)](_images/junction_interact.png)

**RSeQC v3.0.0**

* **Support Python3**. Please use previous versions (v2.6.5 or older) if you are using Python2.
* add [pyBigWig](https://github.com/deeptools/pyBigWig) as a dependency package.

**RSeQC v2.6.5, v2.6.6**

* Fix minor bugs.

**RSeQC v2.6.4**

* Two dependency packages bx-python and pysam are **not** shipped with RSeQC starting from v2.6.4.
* Users could install RSeQC using pip: **pip install RSeQC**. bx-python and pysam will be installed automatically if they haven’t been installed before.

**RSeQC v2.6.3**

* Fix a bug in “read\_quality.py” that does not return results if input file containing less than 1000 reads.
* Remove “RPKM\_count.py” as it generates erroneous results especially for longer reads. Use “FPKM\_count.py” instead.
* “bam\_stat.py” prints summary statistics to STDOUT.

**RSeQC v2.6.2**

* fix bugs in “insertion\_profile.py”, “clipping\_profile.py”, and “inner\_distance.py “

**RSeQC v2.6.1**

* Fix bug in “junction\_annotation.py” in that it would report some “novel splice junctions” that don’t exist in the BAM files. This happened when reads were clipped and spliced mapped simultaneously.
* Add FPKM.py. FPKM.py will report “raw fragment count”, “FPM” and “FPKM” for each gene. It does not report exon and intron level count.

**RSeQC v2.6**

Add 3 new modules:

* deletion\_profile.py
* insertion\_profile.py
* mismatch\_profile.py

**RSeQC v2.5**

* read\_duplication.py:

> * add ‘-q’ option filter alignments with low mapping quality.
> * Fix bug related to the labels of right Y-aixs

* bam2fq: add ‘-c’ option to call ‘gzip’ command to compress output fastq file(s).
* divide\_bam.py: add ‘-s’ option, skipped unmapped reads.
* clipping\_profile.py:

> * add ‘-q’ option filter alignments with low mapping quality.
> * Issue warnning and exit if no clipped reads found.

**RSeQC v2.4**
rewrite “geneBody\_coverage.py”

* Memory-efficient: consumed < 100M RAM
* Flexible input to handle one or more BAM files

```
1. Input a singel BAM file. eg: **-i test.bam**
2. Input several BAM files (separated by ","). eg: **-i test1.bam,test2.bam,test3.bam**
3. Input plain text file containing the path of BAM file(s). eg: **-i bam_path.txt**
4. Input a directory containing BAM file(s). eg: **-i my_folder**
```

* Generate heatmap to visualize gene body coverage over many samples.

**RSeQC v2.3.9**

* Add bam2fq.py. Transform BAM files into fastq format.
* bugs fixed.

**RSeQC v2.3.7**

* bam\_stat.py: Now counts ‘Proper-paired reads map to different chrom’
* bam2wig.py: automatically call ‘wigToBigwig’ if it can be found in system $PATH
* inner\_distance.py: add ‘PE\_within\_diff\_chrom’

**RSeQC v2.3.3**

* Minor bugs fixed.

**RSeQC v2.3.2**

* Add split\_bam.py: Split orignal BAM file into small BAM files based on provided gene list. User can use this module to estimate ribosome RNA amount if the input gene list is ribosomal RNA.
* Add read\_hexamer.py: Calculate hexamer frequency for multiple input files (fasta or fastq).
* Some parts were optimized and runs little faster.

RSeQC v2.3.1

* Add normalization option to bam2wig.py. With this option, user can normalize different sequencing depth into the same scale when converting BAM into wiggle format.
* Add another script. geneBody\_coverage2.py. This script uses BigWig? instead of BAM as input, and requires much less memory (~ 200M)

# Download[¶](#download "Link to this heading")

## Download RSeQC[¶](#download-rseqc "Link to this heading")

* [RSeQC (v5.0.1)](https://sourceforge.net/projects/rseqc/files/RSeQC-5.0.1.tar.gz/download)
* [RSeQC (v5.0.0)](https://sourceforge.net/projects/rseqc/files/RSeQC-5.0.0.tar.gz/download)
* [RSeQC (v4.0.0)](https://sourceforge.net/projects/rseqc/files/RSeQC-4.0.0.tar.gz/download)
* [RSeQC (v3.0.1)](https://sourceforge.net/projects/rseqc/files/RSeQC-3.0.1.tar.gz/download)
* [RSeQC (v3.0.0)](https://sourceforge.net/projects/rseqc/files/RSeQC-3.0.0.tar.gz/download)
* [RSeQC (v2.6.6)](https://sourceforge.net/projects/rseqc/files/RSeQC-2.6.6.tar.gz/download)
* [RSeQC (v2.6.5)](https://sourceforge.net/projects/rseqc/files/RSeQC-2.6.5.tar.gz/download)
* [RSeQC (v2.6.4)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.6.4.tar.gz/download)
* [RSeQC (v2.6.3)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.6.3.tar.gz/download)
* [RSeQC (v2.6.2)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.6.2.tar.gz/download)
* [RSeQC (v2.6.1)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.6.1.tar.gz/download)
* [RSeQC (v2.6)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.6.tar.gz/download)
* [RSeQC (v2.5)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.5.tar.gz/download)
* [RSeQC (v2.4)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.4.tar.gz/download)
* [RSeQC (v2.3.9)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.3.9.tar.gz/download)
* [RSeQC (v2.3.8)](http://sourceforge.net/projects/rseqc/files/RSeQC-2.3.8.tar.gz/download)
* [RSeQC (v2.3.7)](https://sourceforge.net/projects/rseqc/files/RSeQC-2.3.7.tar.gz/download)
* [RSeQC (v2.3.6)](http://rseqc.googlecode.com/files/RSeQC-2.3.6.tar.gz)
* [RSeQC (v2.3.3)](http://rseqc.googlecode.com/files/RSeQC-2.3.3.tar.gz)
* [RSeQC (v2.3.2)](http://rseqc.googlecode.com/files/RSeQC-2.3.2.tar.gz)
* [RSeQC (v2.3.1)](http://rseqc.googlecode.com/files/RSeQC-2.3.1.tar.gz)

## Download test datasets[¶](#download-test-datasets "Link to this heading")

Pair-end strand specific (Illumina).

* [Pairend\_StrandSpecific\_51mer\_Human\_hg19.bam](https://data.cyverse.org/dav-anon/iplant/home/liguow/RSeQC/Pairend_StrandSpecific_51mer_Human_hg19.bam)
* md5sum=fbd1fb1c153e3d074524ec70e6e21fb9

Pair-end non-strand specific (Illumina).

* [Pairend\_nonStrandSpecific\_36mer\_Human\_hg19.bam](https://data.cyverse.org/dav-anon/iplant/home/liguow/RSeQC/Pairend_nonStrandSpecific_36mer_Human_hg19.bam)
* md5sum=ba014f6b397b8a29c456b744237a12de

Single-end strand specific (SOLiD).

* [SingleEnd\_StrandSpecific\_50mer\_Human\_hg19.bam](https://data.cyverse.org/dav-anon/iplant/home/liguow/RSeQC/SingleEnd_StrandSpecific_50mer_Human_hg19.bam)
* md5sum=b39951a6ba4639ca51983c2f0bf5dfce

Single Cell RNA-seq data:

* BAM file generated by cellranger-7.0.1: [possorted\_genome\_bam.bam](https://sourceforge.net/projects/rseqc/files/scRNAseq_test/possorted_genome_bam.bam)
* md5sum=d0d8d4d58262091ad03386a35806d7dd

## Download gene models (update on 12/14/2021)[¶](#download-gene-models-update-on-12-14-2021 "Link to this heading")

* [Human (hg38, hg19)](https://sourceforge.net/projects/rseqc/files/BED/Human_Homo_sapiens/)
* [Mouse (mm10,mm9)](https://sourceforge.net/projects/rseqc/files/BED/Mouse_Mus_musculus/)
* [Fly (dm3)](https://sourceforge.net/projects/rseqc/files/BED/fly_D.melanogaster/)
* [Zebrafish (danRer7)](https://sourceforge.net/projects/rseqc/files/BED/Zebrafish_Danio_rerio/)

Note

1. BED file for other species and the most recent release of these files can be downloaded from [UCSC Table Browser](https://genome.ucsc.edu/cgi-bin/hgTables?command=start)
2. Make sure the gene model and the genome assembly are matched.

## Download ribosome RNA (update on 07/08/2015)[¶](#download-ribosome-rna-update-on-07-08-2015 "Link to this heading")

We only provide rRNA bed files for human and mouse. We download these ribosome RNAs from UCSC table browser,
we provide them here to facilitate users with NO WARRANTY in completeness.

* [GRCh38\_rRNA.bed](http://sourceforge.net/projects/rseqc/files/BED/Human_Homo_sapiens/GRCh38_rRNA.bed.gz/download)
* [hg19\_rRNA.bed](http://sourceforge.net/projects/rseqc/files/BED/Human_Homo_sapiens/hg19_rRNA.bed.gz/download)
* [mm10\_rRNA.bed](http://sourceforge.net/projects/rseqc/files/BED/Mouse_Mus_musculus/mm10_rRNA.bed.gz/download)
* [mm9\_rRNA.bed](http://sourceforge.net/projects/rseqc/files/BED/Mouse_Mus_musculus/mm9_rRNA.bed.gz/download)

# Installation[¶](#installation "Link to this heading")

## Use pip3 to install RSeQC (v3.0.0 or newer)[¶](#use-pip3-to-install-rseqc-v3-0-0-or-newer "Link to this heading")

```
pip3 install RSeQC
```

or you can simply use “pip install RSeQC” if your pip is a soft link to pip3 (use “pip show pip” to check)

## Use pip2 to install RSeQC (v2.6.6 or older)[¶](#use-pip2-to-install-rseqc-v2-6-6-or-older "Link to this heading")

```
pip2 install RSeQC
```

or you can simply use “pip install RSeQC” if your pip is a soft link to pip2 (use “pip show pip” to check)

# Input format[¶](#input-format "Link to this heading")

RSeQC accepts 4 file formats as input:

* [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) file is tab separated, 12-column, plain text file to represent gene model. Here is an [example](http://dldcc-web.brc.bcm.edu/lilab/liguow/RSeQC/dat/sample.bed).
* [SAM](http://samtools.sourceforge.net/) or [BAM](http://genome.ucsc.edu/goldenPath/help/bam.html) files are used to store reads alignments. SAM file is human readable plain text file, while BAM is binary version of SAM, a compact and index-able representation of reads alignments. Here is an [example](http://dldcc-web.brc.bcm.edu/lilab/liguow/RSeQC/dat/sample.sam).
* Chromosome size file is a two-column, plain text file. Here is an [example](http://dldcc-web.brc.bcm.edu/lilab/liguow/RSeQC/dat/sample.hg19.chrom.sizes) for human hg19 assembly. Use this [script](http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/fetchChromSizes) to download chromosome size files of other genomes.
* [Fasta](http://en.wikipedia.org/wiki/FASTA_format) file.

Note

If you have GFF/GTF format gene files, we found [bedopts](https://github.com/bedops/bedops) might be useful to convert them to BED.

# Fetch chromsome size file from UCSC[¶](#fetch-chromsome-size-file-from-ucsc "Link to this heading")

download this [script](http://sourceforge.net/projects/rseqc/files/other/fetchChromSizes/download)
and save as ‘fetchChromSizes’:

```
# Make sure it's executable
chmod +x fetchChromSizes

fetchChromSizes hg19 >hg19.chrom.sizes

fetchChromSizes danRer7  >zebrafish.chrom.sizes
```

# Usage Information[¶](#usage-information "Link to this heading")

## bam2fq.py[¶](#bam2fq-py "Link to this heading")

**Convert alignments in BAM or SAM format into fastq format.**

Options:
:   `--version`
    :   show program’s version number and exit

    `-h, --help`
    :   show this help message and exit

    `-i INPUT_FILE, --input-file=INPUT_FILE`
    :   Alignment file in BAM or SAM format.

    `-o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX`
    :   Prefix of output fastq files(s).

    `-s, --single-end`
    :   Specificy ‘-s’ or ‘–single-end’ for single-end
        sequencing.

    `-c, --compress`
    :   Specificy ‘-c’ or ‘–compress’ to compress output
        fastq file(s) using ‘gzip’ command.

Example:

```
#pair-end
$ python ../scripts/bam2fq.py -i test_PairedEnd_StrandSpecific_hg19.sam  -o bam2fq_out1
Convert BAM/SAM file into fastq format ...  Done
read_1 count: 649507
read_2 count: 350495

#single-end BAM file
$ python ../scripts/bam2fq.py -i test_SingleEnd_StrandSpecific_hg19.bam -s -o bam2fq_out2
Convert BAM/SAM file into fastq format ...  Done
read count: 1000000
```

## bam2wig.py[¶](#bam2wig-py "Link to this heading")

**Convert BAM file into wig/bigWig format.**

1. bam2wig.py converts all types of RNA-seq data from [BAM](http://genome.ucsc.edu/goldenPath/help/bam.html) format into [wiggle](http://genome.ucsc.edu/goldenPath/help/wiggle.html) format.
2. If UCSC [wigToBigWig](http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/) tool was found, output [wiggle](http://genome.ucsc.edu/goldenPath/help/wiggle.html) file will be converted into [bigwig](http://genome.ucsc.edu/FAQ/FAQformat.html#format6.1) format automatically.
3. [BAM](http://genome.ucsc.edu/goldenPath/help/bam.html) file must be sorted and indexed properly using [SAMtools](http://samtools.sourceforge.net/samtools.shtml). Below example shows how to sort and index BAM file using [samTools](http://samtools.sourceforge.net/samtools.shtml)

```
# sort and index BAM files
samtools sort -m 1000000000  input.bam input.sorted.bam
samtools index input.sorted.bam
```

Options:
:   `--version`
    :   show program’s version number and exit

    `-h, --help`
    :   show this help message and exit

    `-i INPUT_FILE, --input-file=INPUT_FILE`
    :   Alignment file in BAM format. BAM file must be sorted
        and indexed using samTools. .bam and .bai files should
        be placed in the same directory.

    `-s CHROMSIZE, --chromSize=CHROMSIZE`
    :   Chromosome size file. Tab or space separated text file
        with 2 columns: first column is chromosome name/ID,
        second column is chromosome size. Chromosome names
        (such as “chr1”) should be consistent between this
        file and the BAM file.

    `-o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX`
    :   Prefix of output w