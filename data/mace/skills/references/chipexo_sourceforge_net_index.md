### Navigation

* [index](genindex.html "General Index")
* MACE: Model based Analysis of ChIP-exo 1.0 documentation »

[![MACE log](_images/Logo.png)](http://chipexo.sourceforge.net/)

# Introduction[¶](#introduction "Permalink to this headline")

[ChIP-exo](http://en.wikipedia.org/wiki/ChIP-exo) allows for precise mapping of protein-DNA
interactions. It uses λ phage exonuclease to digest the 5’ end of protein-unbound DNA
fragments and thereby creates a homogenous 5’ end at a fixed distance from the protein
binding location. After sequencing and aligning reads to the reference genome, the 5′ ends
of reads align primarily at two genomic locations corresponding to two borders of protein binding site.
([Rhee & Pugh, 2011 Cell](http://www.ncbi.nlm.nih.gov/pubmed/22153082);
[Rhee & Pugh, 2011 Nature](http://www.ncbi.nlm.nih.gov/pubmed/22258509);
[Mendenhall & Bernstein, 2012 Genome Biol.](http://www.ncbi.nlm.nih.gov/pubmed/22283870))

MACE is a bioinformatics tool dedicated to analyze ChIP-exo data. It operates in 4 major steps::
:   1. Sequencing depth normalization and nucleotide composition bias correction.
    2. Signal consolidation and noise reduction using [Shannon’s entropy](http://en.wikipedia.org/wiki/Shannon_entropy).
    3. Single base resolution border detection using [Chebyshev Inequality](http://en.wikipedia.org/wiki/Chebyshev_Inequality).
    4. Border matching using [Gale-Shapley’s stable matching algorithm](http://en.wikipedia.org/wiki/Gale%E2%80%93Shapley_algorithm).

[![alternate text](_images/workFlow.png)](_images/workFlow.png)

# Release notes[¶](#release-notes "Permalink to this headline")

MACE (v1.2) released on April 15, 2015.

* add option (-m) to **preprocessor.py** let users choose the consolidation method.

> * EM: Entropy weighted mean (default and recommend)
> * AM: Arithmetic mean
> * GM: Geometric mean
> * SNR: Signal-to-noise ratio (i.e., the ratio of mean to standard deviation)

# Download[¶](#download "Permalink to this headline")

[MACE-1.2.tar.gz](http://sourceforge.net/projects/chipexo/files/MACE-1.2.tar.gz/download)

[MACE-1.1.tar.gz](http://sourceforge.net/projects/chipexo/files/MACE-1.1.tar.gz/download)

# Installation[¶](#installation "Permalink to this headline")

Prerequisite:

* [gcc](http://gcc.gnu.org/)
* [python2.7](http://www.python.org/getit/releases/2.7/)
* [numpy](http://pypi.python.org/pypi/numpy)
* [GNU Scientific Library (GSL)](http://gnu.askapache.com/gsl/) following the instructions.
* Mac OS X users need to download and install [Xcode](https://developer.apple.com/xcode/).

Procedure to install MACE (Linux & MacOS X):

```
tar zxf MACE-VERSION.tar.gz

cd MACE-VERSION

#Install MACE. type 'python setup.py --help' to see install options. Note: python2.7 is needed.
python setup.py install

#Add MACE modules to python module searching path($PYTHONPATH). This step is unnecessary if MACE was installed to default location.
export PYTHONPATH=/home/user/MACE/usr/local/lib/python2.7/site-packages:$PYTHONPATH

#Add MACE scripts to Shell searching path ($PATH). This step is unnecessary if MACE was installed to default location.
export PATH=/home/user/MACE/usr/local/bin:$PATH
```

# Walkthrough example using Frank Pugh’s CTCF ChIP-exo data[¶](#walkthrough-example-using-frank-pugh-s-ctcf-chip-exo-data "Permalink to this headline")

Please **skip Step1 and Step2** if you choose to use our alignment files.

## Step1: Download raw sequence data[¶](#step1-download-raw-sequence-data "Permalink to this headline")

Download CTCF ChIP-exo data (Accession number [SRA044886](http://www.ncbi.nlm.nih.gov/sra?term=SRA044886)) published in
[Cell, 2011.](http://www.ncbi.nlm.nih.gov/pubmed/22153082)

```
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR346/SRR346401/SRR346401.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR346/SRR346402/SRR346402.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR346/SRR346403/SRR346403.fastq.gz
```

## Step2: Align reads to reference genome[¶](#step2-align-reads-to-reference-genome "Permalink to this headline")

Mapping reads to reference genome. In this example, we use [Bowtie](http://bowtie-bio.sourceforge.net/index.shtml)
to align reads to human reference genome (GRCh37/hg19). Please note Pugh’s CTCF ChIP-exo data was sequenced using SOLiD genome sequencer,
so we need the color space human genome index files. Bowtie prebuild these files for download (color space genome index files). Any aligner is fine, as long
as it can generate [BAM](http://genome.ucsc.edu/goldenPath/help/bam.html) or [SAM](http://genome.sph.umich.edu/wiki/SAM) format alignments file:

```
bowtie -S -C -q -m 1 PATH/bowtie/indexes/colorspace/hg19c SRR346401.fastq CTCF_replicate1.sam
bowtie -S -C -q -m 1 PATH/bowtie/indexes/colorspace/hg19c SRR346402.fastq CTCF_replicate2.sam
bowtie -S -C -q -m 1 PATH/bowtie/indexes/colorspace/hg19c SRR346403.fastq CTCF_replicate3.sam
```

Convert SAM into [BAM](http://genome.ucsc.edu/goldenPath/help/bam.html) format, then sort and
index [BAM](http://genome.ucsc.edu/goldenPath/help/bam.html) files using [samtools](http://samtools.sourceforge.net/). You only need the index step if the aligner you used already produced sorted
[BAM](http://genome.ucsc.edu/goldenPath/help/bam.html) file:

```
samtools view -bS CTCF_replicate1.sam > CTCF_replicate1.bam
samtools sort  CTCF_replicate1.bam  CTCF_replicate1.sorted
samtools index CTCF_replicate1.sorted.bam

samtools view -bS CTCF_replicate2.sam > CTCF_replicate2.bam
samtools sort  CTCF_replicate2.bam  CTCF_replicate2.sorted
samtools index CTCF_replicate2.sorted.bam

samtools view -bS CTCF_replicate3.sam > CTCF_replicate3.bam
samtools sort  CTCF_replicate3.bam  CTCF_replicate3.sorted
samtools index CTCF_replicate3.sorted.bam
```

You can download our sorted and indexed [BAM](http://genome.ucsc.edu/goldenPath/help/bam.html) files (**Skip Step1, Step2**):

```
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF_replicate1.sorted.bam
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF_replicate1.sorted.bam.bai
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF_replicate2.sorted.bam
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF_replicate2.sorted.bam.bai
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF_replicate3.sorted.bam
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF_replicate3.sorted.bam.bai
```

## Step3: Preproprocessing includes sequencing depth normalization, nucleotide composition bias correction, signal consolidation and noise reduction[¶](#step3-preproprocessing-includes-sequencing-depth-normalization-nucleotide-composition-bias-correction-signal-consolidation-and-noise-reduction "Permalink to this headline")

Replicate BAM files are separated by ‘,’. Reads mapped to forward and reverse strand will
define two boundaries of binding sites, so finally two [wiggle](http://genome.ucsc.edu/goldenPath/help/wiggle.html)
format files will be produced.
[wiggle](http://genome.ucsc.edu/goldenPath/help/wiggle.html) files will be converted
into [bigwig](http://genome.ucsc.edu/goldenPath/help/bigWig.html) format automatically
if ‘[WigToBigWig](http://hgdownload.cse.ucsc.edu/admin/exe/)‘ executable can be found in
your system $PATH, otherwise you need to convert them manually.:

```
preprocessor.py -i CTCF_replicate1.sorted.bam,CTCF_replicate2.sorted.bam,CTCF_replicate3.sorted.bam -r hg19.chrom.sizes -o CTCF_MACE
```

Convert [wiggle](http://genome.ucsc.edu/goldenPath/help/wiggle.html) into [bigwig](http://genome.ucsc.edu/goldenPath/help/bigWig.html) format manually. You need to download [WigToBigWig](http://hgdownload.cse.ucsc.edu/admin/exe/) program from UCSC.:

```
wigToBigWig CTCF_hg19_Forward.wig hg19.chrom.sizes  CTCF_MACE_Forward.bw
wigToBigWig CTCF_hg19_Reverse.wig hg19.chrom.sizes  CTCF_MACE_Reverse.bw
```

You can download our bigwig files directly (**Skip Step3**):

```
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_MACE_Forward.bw
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_MACE_Reverse.bw
```

## Step4: Border detection and border pairing[¶](#step4-border-detection-and-border-pairing "Permalink to this headline")

Run mace.py to perform ChIP-Exo “border peak” calling and “border pairing” from two BigWig files:

```
mace.py -s hg19.chrom.sizes -f CTCF_MACE_Forward.bw -r CTCF_MACE_Reverse.bw -o CTCF_MACE
```

border pairs will be saved in file **prefix.border\_pair.bed** (chrom, start (0-based, exclusive),
end (1-based, inclusive), label, pvalue). *SFB* = broder pairs derived from Single Forward Border, *SRB* = border pair derived from
Single Reverse Border, *GSB*, Gale-Sharpley paired Border. Below is an example

```
chr1    104966  104993  SFB     0.048907955391
chr1    521563  521602  SFB     0.0305608536849
chr1    714165  714215  SRB     0.018255126205
chr1    793499  793565  SRB     0.0121099793964
chr1    840126  840167  GSB     0.00494958418067
chr1    873592  873668  GSB     0.00159503506178
chr1    886925  886980  GSB     0.00402015835584
chr1    919668  919696  GSB     0.00292883762243
chr1    919680  919751  GSB     0.00791031727722
chr1    937367  937412  SFB     0.0306385665784
...
```

mace.py produces these files:

> 1. **prefix.border.bed**: This file contains single border (1nt resolution) whose coverage signal is significantly higher than local background level. Intermediate result.
> 2. **prefix.border\_cluster.bed**: Single borders are clustered together. Each cluster might represent a single binding event. Intermediate result.
> 3. **prefix.border\_pair\_elite.bed**: high quality border pairs used to build model and estimate optimal border pair size. Intermediate result.
> 4. **prefix.border\_pair.bed**: this file contains all detected border pairs. **Final result**.

## Step5: visualize results using [UCSC genome browser](http://genome.ucsc.edu/cgi-bin/hgGateway)[¶](#step5-visualize-results-using-ucsc-genome-browser "Permalink to this headline")

Copy the following lines and pasted into [UCSC](http://genome.ucsc.edu/cgi-bin/hgCustom).
Note the Assembly version is hg19. You need to convert peak and peak\_pair files into [BigBed](http://genome.ucsc.edu/FAQ/FAQformat.html#format1.5).:

```
#MACE border pair and predicted motif
track type=bigBed name="CTCF MACE Border Pairs" visibility=2 color=0,0,255 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_MACE_borderPair.bb
track type=bigBed name="CTCF FIMO Motif" visibility=2 color=255,0,0  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_FIMO_motif.bb

#MACE consolidated signal
track type=bigWig name="CTCF MACE Forward Signal" visibility=2 color=0,0,102  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_MACE_Forward.bw
track type=bigWig name="CTCF MACE Reverse Signal" visibility=2 color=102,0,0  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_MACE_Reverse.bw

#Raw signals
track type=bigWig name="CTCF Raw Signal (rep1 Forward) " visibility=2 color=0,0,153  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_raw_rep1_Forward.bw
track type=bigWig name="CTCF Raw Signal (rep1 Reverse) " visibility=2 color=153,0,0  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_raw_rep1_Reverse.bw
track type=bigWig name="CTCF Raw Signal (rep2 Forward) " visibility=2 color=0,0,153  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_raw_rep2_Forward.bw
track type=bigWig name="CTCF Raw Signal (rep2 Reverse) " visibility=2 color=153,0,0  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_raw_rep2_Reverse.bw
track type=bigWig name="CTCF Raw Signal (rep3 Forward) " visibility=2 color=0,0,153  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_raw_rep3_Forward.bw
track type=bigWig name="CTCF Raw Signal (rep3 Reverse) " visibility=2 color=153,0,0  windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF_raw_rep3_Reverse.bw
```

## One binding site of CTCF as an example[¶](#one-binding-site-of-ctcf-as-an-example "Permalink to this headline")

An example shows border pair detection and denoising effect.
Total 11 tracks were displayed in UCSC genome browser. From top to
bottom, [1] - [3] forward strand coverage of three biological replicates; [4] - [6)] reverse
strand coverage of three biological replicates; [7] Forward coverage signal consolidated from track [1] - [3]; [8]
Reverse coverage signal consolidated from track [4] – [6]; [9] in silico predicted CTCF motif;
[10] peak pairs called by MACE; [11] phastCon conservation score in mammals.

[![alternate text](_images/example.png)](_images/example.png)

# Usage[¶](#usage "Permalink to this headline")

preprocessor.py takes BAM files as input. Consolidate the signals and output signals in wig/bigwig format.

## preprocessor.py[¶](#preprocessor-py "Permalink to this headline")

Options:
:   |  |  |
    | --- | --- |
    | `--version` | show program’s version number and exit |
    | `-h, --help` | show this help message and exit |
    | `-i INPUT_FILE, --inputFile=INPUT_FILE` | |
    |  | Input file in BAM format. BAM file must be sorted and indexed using samTools. Replicates separated by comma(‘,’) e.g. “-i rep1.bam,rep2.bam,rep3.bam” |
    | `-r CHROMSIZE, --chromSize=CHROMSIZE` | |
    |  | Chromosome size file. Tab or space separated text file with 2 columns: first column is chromosome name, second column is size of the chromosome. |
    | `-o OUTPUT_PREFIX, --outPrefix=OUTPUT_PREFIX` | |
    |  | Prefix of output wig files(s). “Prefix\_Forward.wig” and “Prefix\_Reverse.wig” will be generated |
    | `-w WORD_SIZE, --kmerSize=WORD_SIZE` | |
    |  | Kmer size [6,12] to correct nucleotide composition bias. kmerSize < 0.5\*read\_lenght. larger KmerSize might make program slower. Set kmerSize = 0 to turn off nucleotide compsition bias correction. default=6 |
    | `-b BIN, --bin=BIN` | |
    |  | Chromosome chunk size. Each chomosome will be cut into small chunks of this size. Decrease chunk size will save more RAM. default=100000 (bp) |
    | `-d REFREADN, --depth=REFREADN` | |
    |  | Reference reads count (default = 10 million). Sequencing depth will be normailzed to this number, so that wig files are comparable between replicates. |
    | `-q QUAL_CUT, --qCut=QUAL_CUT` | |
    |  | phred scaled mapping quality threshhold to determine “uniqueness” of alignments. default=30 |
    | `-m NORM_METHOD, --method=NORM_METHOD` | |
    |  | methods (“EM”, “AM”, “GM”, or “SNR”) used to consolidate replicates and reduce noise. “EM” = Entropy weighted mean, “AM”=Arithmetic mean, “GM”=Geometric mean, “SNR”=Signal-to-noise ratio. default=EM |

## mace.py[¶](#mace-py "Permalink to this headline")

mace.py first compares th