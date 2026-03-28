.. MACE documentation master file, created by
sphinx-quickstart on Tue Oct 23 00:48:24 2012.
You can adapt this file completely to your liking, but it should at least
contain the root `toctree` directive.
.. image:: \_static/Logo.png
:height: 220 px
:width: 450 px
:scale: 70 %
:alt: MACE log
:target: http://chipexo.sourceforge.net/
Introduction
=====================================================
`ChIP-exo `\_ allows for precise mapping of protein-DNA
interactions. It uses λ phage exonuclease to digest the 5’ end of protein-unbound DNA
fragments and thereby creates a homogenous 5’ end at a fixed distance from the protein
binding location. After sequencing and aligning reads to the reference genome, the 5′ ends
of reads align primarily at two genomic locations corresponding to two borders of protein binding site.
(`Rhee & Pugh, 2011 Cell `\_;
`Rhee & Pugh, 2011 Nature `\_;
`Mendenhall & Bernstein, 2012 Genome Biol. `\_)
MACE is a bioinformatics tool dedicated to analyze ChIP-exo data. It operates in 4 major steps::
1) Sequencing depth normalization and nucleotide composition bias correction.
2) Signal consolidation and noise reduction using `Shannon's entropy `\_.
3) Single base resolution border detection using `Chebyshev Inequality `\_.
4) Border matching using `Gale-Shapley’s stable matching algorithm `\_.
.. image:: \_static/workFlow.png
:height: 850 px
:width: 850 px
:scale: 80 %
:alt: alternate text
Release notes
================
MACE (v1.2) released on April 15, 2015.
\* add option (-m) to \*\*preprocessor.py\*\* let users choose the consolidation method.
\* EM: Entropy weighted mean (default and recommend)
\* AM: Arithmetic mean
\* GM: Geometric mean
\* SNR: Signal-to-noise ratio (i.e., the ratio of mean to standard deviation)
Download
===============
`MACE-1.2.tar.gz `\_
`MACE-1.1.tar.gz `\_
Installation
===============
Prerequisite:
\* `gcc `\_
\* `python2.7 `\_
\* `numpy `\_
\* `GNU Scientific Library (GSL) `\_ following the instructions.
\* Mac OS X users need to download and install `Xcode `\_.
Procedure to install MACE (Linux & MacOS X)::
tar zxf MACE-VERSION.tar.gz
cd MACE-VERSION
#Install MACE. type 'python setup.py --help' to see install options. Note: python2.7 is needed.
python setup.py install
#Add MACE modules to python module searching path($PYTHONPATH). This step is unnecessary if MACE was installed to default location.
export PYTHONPATH=/home/user/MACE/usr/local/lib/python2.7/site-packages:$PYTHONPATH
#Add MACE scripts to Shell searching path ($PATH). This step is unnecessary if MACE was installed to default location.
export PATH=/home/user/MACE/usr/local/bin:$PATH
Walkthrough example using Frank Pugh's CTCF ChIP-exo data
=========================================================
Please \*\*skip Step1 and Step2\*\* if you choose to use our alignment files.
Step1: Download raw sequence data
-----------------------------------
Download CTCF ChIP-exo data (Accession number `SRA044886 `\_) published in
`Cell, 2011. `\_ ::
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR346/SRR346401/SRR346401.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR346/SRR346402/SRR346402.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR346/SRR346403/SRR346403.fastq.gz
Step2: Align reads to reference genome
--------------------------------------
Mapping reads to reference genome. In this example, we use `Bowtie `\_
to align reads to human reference genome (GRCh37/hg19). Please note Pugh's CTCF ChIP-exo data was sequenced using SOLiD genome sequencer,
so we need the color space human genome index files. Bowtie prebuild these files for download (`color space genome index files `\_). Any aligner is fine, as long
as it can generate `BAM `\_ or `SAM `\_ format alignments file::
bowtie -S -C -q -m 1 PATH/bowtie/indexes/colorspace/hg19c SRR346401.fastq CTCF\_replicate1.sam
bowtie -S -C -q -m 1 PATH/bowtie/indexes/colorspace/hg19c SRR346402.fastq CTCF\_replicate2.sam
bowtie -S -C -q -m 1 PATH/bowtie/indexes/colorspace/hg19c SRR346403.fastq CTCF\_replicate3.sam
Convert SAM into `BAM `\_ format, then sort and
index `BAM `\_ files using `samtools `\_. You only need the index step if the aligner you used already produced sorted
`BAM `\_ file::
samtools view -bS CTCF\_replicate1.sam > CTCF\_replicate1.bam
samtools sort CTCF\_replicate1.bam CTCF\_replicate1.sorted
samtools index CTCF\_replicate1.sorted.bam
samtools view -bS CTCF\_replicate2.sam > CTCF\_replicate2.bam
samtools sort CTCF\_replicate2.bam CTCF\_replicate2.sorted
samtools index CTCF\_replicate2.sorted.bam
samtools view -bS CTCF\_replicate3.sam > CTCF\_replicate3.bam
samtools sort CTCF\_replicate3.bam CTCF\_replicate3.sorted
samtools index CTCF\_replicate3.sorted.bam
You can download our sorted and indexed `BAM `\_ files (\*\*Skip Step1, Step2\*\*)::
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF\_replicate1.sorted.bam
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF\_replicate1.sorted.bam.bai
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF\_replicate2.sorted.bam
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF\_replicate2.sorted.bam.bai
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF\_replicate3.sorted.bam
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bam/CTCF\_replicate3.sorted.bam.bai
Step3: Preproprocessing includes sequencing depth normalization, nucleotide composition bias correction, signal consolidation and noise reduction
----------------------------------------------------------------------------------------------------------------------------------------------------
Replicate BAM files are separated by ','. Reads mapped to forward and reverse strand will
define two boundaries of binding sites, so finally two `wiggle `\_
format files will be produced.
`wiggle `\_ files will be converted
into `bigwig `\_ format automatically
if '`WigToBigWig `\_' executable can be found in
your system $PATH, otherwise you need to convert them manually.::
preprocessor.py -i CTCF\_replicate1.sorted.bam,CTCF\_replicate2.sorted.bam,CTCF\_replicate3.sorted.bam -r hg19.chrom.sizes -o CTCF\_MACE
Convert `wiggle `\_ into `bigwig `\_ format manually. You need to download `WigToBigWig `\_ program from UCSC.::
wigToBigWig CTCF\_hg19\_Forward.wig hg19.chrom.sizes CTCF\_MACE\_Forward.bw
wigToBigWig CTCF\_hg19\_Reverse.wig hg19.chrom.sizes CTCF\_MACE\_Reverse.bw
You can download our bigwig files directly (\*\*Skip Step3\*\*)::
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_MACE\_Forward.bw
wget http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_MACE\_Reverse.bw
Step4: Border detection and border pairing
-------------------------------------------
Run mace.py to perform ChIP-Exo "border peak" calling and "border pairing" from two BigWig files::
mace.py -s hg19.chrom.sizes -f CTCF\_MACE\_Forward.bw -r CTCF\_MACE\_Reverse.bw -o CTCF\_MACE
border pairs will be saved in file \*\*prefix.border\_pair.bed\*\* (chrom, start (0-based, exclusive),
end (1-based, inclusive), label, pvalue). \*SFB\* = broder pairs derived from Single Forward Border, \*SRB\* = border pair derived from
Single Reverse Border, \*GSB\*, Gale-Sharpley paired Border. Below is an example ::
chr1 104966 104993 SFB 0.048907955391
chr1 521563 521602 SFB 0.0305608536849
chr1 714165 714215 SRB 0.018255126205
chr1 793499 793565 SRB 0.0121099793964
chr1 840126 840167 GSB 0.00494958418067
chr1 873592 873668 GSB 0.00159503506178
chr1 886925 886980 GSB 0.00402015835584
chr1 919668 919696 GSB 0.00292883762243
chr1 919680 919751 GSB 0.00791031727722
chr1 937367 937412 SFB 0.0306385665784
...
mace.py produces these files:
1) \*\*prefix.border.bed\*\*: This file contains single border (1nt resolution) whose coverage signal is significantly higher than local background level. Intermediate result.
2) \*\*prefix.border\_cluster.bed\*\*: Single borders are clustered together. Each cluster might represent a single binding event. Intermediate result.
3) \*\*prefix.border\_pair\_elite.bed\*\*: high quality border pairs used to build model and estimate optimal border pair size. Intermediate result.
4) \*\*prefix.border\_pair.bed\*\*: this file contains all detected border pairs. \*\*Final result\*\*.
Step5: visualize results using `UCSC genome browser `\_
-------------------------------------------------------------------------------------------------
Copy the following lines and pasted into `UCSC `\_.
Note the Assembly version is hg19. You need to convert peak and peak\_pair files into `BigBed `\_.::
#MACE border pair and predicted motif
track type=bigBed name="CTCF MACE Border Pairs" visibility=2 color=0,0,255 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_MACE\_borderPair.bb
track type=bigBed name="CTCF FIMO Motif" visibility=2 color=255,0,0 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_FIMO\_motif.bb
#MACE consolidated signal
track type=bigWig name="CTCF MACE Forward Signal" visibility=2 color=0,0,102 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_MACE\_Forward.bw
track type=bigWig name="CTCF MACE Reverse Signal" visibility=2 color=102,0,0 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_MACE\_Reverse.bw
#Raw signals
track type=bigWig name="CTCF Raw Signal (rep1 Forward) " visibility=2 color=0,0,153 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_raw\_rep1\_Forward.bw
track type=bigWig name="CTCF Raw Signal (rep1 Reverse) " visibility=2 color=153,0,0 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_raw\_rep1\_Reverse.bw
track type=bigWig name="CTCF Raw Signal (rep2 Forward) " visibility=2 color=0,0,153 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_raw\_rep2\_Forward.bw
track type=bigWig name="CTCF Raw Signal (rep2 Reverse) " visibility=2 color=153,0,0 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_raw\_rep2\_Reverse.bw
track type=bigWig name="CTCF Raw Signal (rep3 Forward) " visibility=2 color=0,0,153 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_raw\_rep3\_Forward.bw
track type=bigWig name="CTCF Raw Signal (rep3 Reverse) " visibility=2 color=153,0,0 windowingFunction=maximum db=hg19 bigDataUrl=http://dldcc-web.brc.bcm.edu/lilab/MACE/bigfile/CTCF\_raw\_rep3\_Reverse.bw
One binding site of CTCF as an example
---------------------------------------
An example shows border pair detection and denoising effect.
Total 11 tracks were displayed in UCSC genome browser. From top to
bottom, [1] - [3] forward strand coverage of three biological replicates; [4] - [6)] reverse
strand coverage of three biological replicates; [7] Forward coverage signal consolidated from track [1] - [3]; [8]
Reverse coverage signal consolidated from track [4] – [6]; [9] in silico predicted CTCF motif;
[10] peak pairs called by MACE; [11] phastCon conservation score in mammals.
.. image:: \_static/example.png
:height: 850 px
:width: 1250 px
:scale: 60 %
:alt: alternate text
Usage
================
preprocessor.py takes BAM files as input. Consolidate the signals and output signals in wig/bigwig format.
preprocessor.py
----------------
Options:
--version show program's version number and exit
-h, --help show this help message and exit
-i INPUT\_FILE, --inputFile=INPUT\_FILE
Input file in BAM format. BAM file must be sorted and
indexed using samTools. Replicates separated by
comma(',') e.g. "-i rep1.bam,rep2.bam,rep3.bam"
-r CHROMSIZE, --chromSize=CHROMSIZE
Chromosome size file. Tab or space separated text file
with 2 columns: first column is chromosome name,
second column is size of the chromosome.
-o OUTPUT\_PREFIX, --outPrefix=OUTPUT\_PREFIX
Prefix of output wig files(s). "Prefix\_Forward.wig"
and "Prefix\_Reverse.wig" will be generated
-w WORD\_SIZE, --kmerSize=WORD\_SIZE
Kmer size [6,12] to correct nucleotide composition
bias. kmerSize < 0.5\*read\_lenght. larger KmerSize
might make program slower. Set kmerSize = 0 to turn
off nucleotide compsition bias correction. default=6
-b BIN, --bin=BIN Chromosome chunk size. Each chomosome will be cut into
small chunks of this size. Decrease chunk size will
save more RAM. default=100000 (bp)
-d REFREADN, --depth=REFREADN
Reference reads count (default = 10 million).
Sequencing depth will be normailzed to this number, so
that wig files are comparable between replicates.
-q QUAL\_CUT, --qCut=QUAL\_CUT
phred scaled mapping quality threshhold to determine
"uniqueness" of alignments. default=30
-m NORM\_METHOD, --method=NORM\_METHOD
methods ("EM", "AM", "GM", or "SNR") used to
consolidate replicates and reduce noise. "EM" =
Entropy weighted mean, "AM"=Arithmetic mean,
"GM"=Geometric mean, "SNR"=Signal-to-noise ratio.
default=EM
mace.py
---------------------------
mace.py first compares the signal at each nucleotide position to its background (specified by "-w"). If the signal at a position is significantly (determined by "-p") higher than its background, MACE consider
this position as "candidate border". For most TF binding sites, we would detect multiple \*\*left borders\*\* and multiple \*\*right borders\*\*. Assume we have detected \*m\* \*\*left borders\*\* and \*n\* \*\*right borders\*\*,
we have \*m\* x \*n\* border pairs in total. In theory, there is only real border pair at each TF binding site, it's difficult to pick out this real one, but we can rank all these border pairs. The rank of each border pair is
determined by two factors: signals of the two borders and the distance between the two borders. The higher the signal, the more likely the two borders are real. But only consider the signal is unfair, because
other confounding factors (such as GC content, DNA sequence complexity, sequencing bias) could also affect the coverage signal. We also need to consider the size of the border pair (i.e. the genome distance between two borders),
if the size of a particular border pair is much larger (or smaller) than the real TF-DNA binding size, this border pair is less likely to be real. We don't know the real TF-DNA binding size in advance,
but if we assume the TF-DNA binding size is constant across the entire genome, we could estimate it using a subset of border pairs that we called \*\*elite border pairs\*\*. In these elite border pairs, the left and right
border are so prominent that we can pair them without ambiguity. The criterion to select elite border pairs is specified by "-n". If "-n 2" was specified, we asked the signal of elite border must be at least 2 fold
higher than its background.
Options:
--version show program's version number and exit
-h, --help show this help message and exit
-f FORWARD\_BW, --forward=FORWARD\_BW
BigWig format file containing coverage calcualted from
reads mapped to \*forward\* strand.
-r REVERSE\_BW, --r