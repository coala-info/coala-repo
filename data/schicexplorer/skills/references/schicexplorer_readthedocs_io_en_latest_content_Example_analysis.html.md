[scHiCExplorer](../index.html)

latest

* [Installation](installation.html)
* [scHiCExplorer tools](list-of-tools.html)
* [News](News.html)
* Analysis of single-cell Hi-C data
  + [Download of the fastq files](#download-of-the-fastq-files)
  + [Demultiplexing](#demultiplexing)
  + [Mapping](#mapping)
  + [Creation of Hi-C interaction matrices](#creation-of-hi-c-interaction-matrices)
  + [Quality control](#quality-control)
  + [Removal of chromosomes / contigs / scaffolds](#removal-of-chromosomes-contigs-scaffolds)
  + [Normalization](#normalization)
  + [Correction](#correction)
  + [Analysis](#analysis)
    - [Clustering on raw data](#clustering-on-raw-data)
    - [Clustering on kNN graph or PCA with exact methods](#clustering-on-knn-graph-or-pca-with-exact-methods)
    - [Clustering with dimensional reduction by local sensitive hashing](#clustering-with-dimensional-reduction-by-local-sensitive-hashing)
    - [Clustering with dimensional reduction by short range vs. long range contact ratios](#clustering-with-dimensional-reduction-by-short-range-vs-long-range-contact-ratios)
    - [Clustering with dimensional reduction by A/B compartments](#clustering-with-dimensional-reduction-by-a-b-compartments)
    - [Consensus matrices](#consensus-matrices)
  + [Bulk matrix](#bulk-matrix)

[scHiCExplorer](../index.html)

* [Docs](../index.html) »
* Analysis of single-cell Hi-C data
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/Example_analysis.rst)

---

# Analysis of single-cell Hi-C data[¶](#analysis-of-single-cell-hi-c-data "Permalink to this headline")

* [Download of the fastq files](#download-of-the-fastq-files)
* [Demultiplexing](#demultiplexing)
* [Mapping](#mapping)
* [Creation of Hi-C interaction matrices](#creation-of-hi-c-interaction-matrices)
* [Quality control](#quality-control)
* [Removal of chromosomes / contigs / scaffolds](#removal-of-chromosomes-contigs-scaffolds)
* [Normalization](#normalization)
* [Correction](#correction)
* [Analysis](#analysis)

  + [Clustering on raw data](#clustering-on-raw-data)
  + [Clustering on kNN graph or PCA with exact methods](#clustering-on-knn-graph-or-pca-with-exact-methods)
  + [Clustering with dimensional reduction by local sensitive hashing](#clustering-with-dimensional-reduction-by-local-sensitive-hashing)
  + [Clustering with dimensional reduction by short range vs. long range contact ratios](#clustering-with-dimensional-reduction-by-short-range-vs-long-range-contact-ratios)
  + [Clustering with dimensional reduction by A/B compartments](#clustering-with-dimensional-reduction-by-a-b-compartments)
  + [Consensus matrices](#consensus-matrices)
* [Bulk matrix](#bulk-matrix)

The analysis of single-cell Hi-C data deals is partially similar to regular Hi-C data analysis, the pre-processing of data i.e. mapping and the creation
of a Hi-C interaction matrix and the correction of the data works can be adapted from a Hi-C data analysis. However, single-cell Hi-C deals
with different issues as the be mentioned the pre-processing of the fastq files (demultiplexing) to associate the reads to one sample (to one cell).
Everything that applies to Hi-C also applies to single-cell Hi-C expect in single-cell the work is done with a few thousand cells and not one. Additional, the read coverage
in single-cell Hi-C is not in the hundreds of millions but on the used data form Nagano 2017 on average 1.5 million. This leads to other necessary treatments in the quality
control of the samples and a need for a normalization to a equal read coverage for all cells.

In this tutorial we work with the ‘diploid’ data from Nagano 2017 (GSE94489).

**Disclaimer**

scHiCExplorer is a general tool to process and analysis single-cell Hi-C data. In this tutorial single-cell Hi-C data from Nagano 2017 (GSE94489) is used and scHiCExplorer provides a tool to demultiplex the FASTQ files. However, if all pre-processing (demultiplexing, trimming etc) is achieved by third-party tools
and per cell the mapped forward and reverse strand files are present, scHiCExplorer can process them.

**Disclaimer**

The raw fastq data is around 1,04 TB of size and the download speed is limited to a few Mb/s by NCBI. To decrease the download time it is recommended to download the files in parallel if enough disk space is available.
Furthermore, please consider the data needs to be demultiplexed and mapped which needs additional disk space.

If you do not want to download, demultiplex, map and build the matrices on your own, two precomputed raw scool matrices are provided on [Zenodo](https://doi.org/10.5281/zenodo.3557682) in 1Mb and 10kb resolution.
For this tutorial we use the 1Mb resolution of the matrix to reduce computation time. The 10kb takes significant longer and needs more memory to compute.

**WARNING** Please consider you need to convert the matrices first to the new scool file format as it is introduced with scHiCExplorer 5 and cooler 0.8.9. Use for this **scHicManageScool** and its update function.

## [Download of the fastq files](#id1)[¶](#download-of-the-fastq-files "Permalink to this headline")

As the very first step the raw, non-demultiplexed fastq files need to be downloaded. Please download the files directly from NCBI GEO and not e.g. from EMBL ENA, we
have seen that these files miss the barcode information.

To download the fastq files the SRR sample number must be known, for not all samples only one SRR number was given, these samples were therefore not included in this tutorial.

```
SRR5229019  GSM2476401      Diploid_11
SRR5229021  GSM2476402      Diploid_12
SRR5229023  GSM2476403      Diploid_13
SRR5229025  GSM2476404      Diploid_15_16_17_18
SRR5229027  GSM2476405      Diploid_1_6
SRR5229029  GSM2476406      Diploid_19
SRR5229031  GSM2476407      Diploid_20
SRR5229033  GSM2476408      Diploid_2_14
SRR5229035  GSM2476409      Diploid_21
SRR5229037  GSM2476410      Diploid_22
SRR5229039  GSM2476411      Diploid_23
SRR5229041  GSM2476412      Diploid_24
SRR5229043  GSM2476413      Diploid_25
SRR5229045  GSM2476414      Diploid_26
SRR5229047  GSM2476415      Diploid_3
SRR5229049  GSM2476416      Diploid_4
SRR5229051  GSM2476417      Diploid_5_10
SRR5229053  GSM2476418      Diploid_7
SRR5229055  GSM2476419      Diploid_8
SRR5229057  GSM2476420      Diploid_9
SRR5507552  GSM2598387      Diploid_28_29
SRR5507553  GSM2598388      Diploid_30_31
SRR5507554  GSM2598389      Diploid_32_33
SRR5507555  GSM2598390      Diploid_34_35
```

Excluded: GSM2598386 / Diploid\_27

Download the each file via:

```
$ fastq-dump --accession SRR5229019 --split-files --defline-seq \'@$sn[_$rn]/$ri\' --defline-qual \'+\'  --split-spot --stdout SRR5229019  > SRR5229019.fastq
```

Alternatively, download all with one command:

```
$ echo SRR5229019,SRR5229021,SRR5229023,SRR5229025,SRR5229027,SRR5229031,SRR5229033,SRR5229035,SRR5229037,SRR5229039,SRR5229041,SRR5229043,SRR5229045,SRR5229047,SRR5229049,SRR5229051,SRR5229053,SRR5229055,SRR5229057,SRR5507553,SRR5507554,SRR5507555 |  sed "s/,/\n/g" | xargs -n1 -P 22 -I {} sh -c "fastq-dump --accession {} --split-files --defline-seq \'@$sn[_$rn]/$ri\' --defline-qual \'+\'  --split-spot --stdout {}  > {}.fastq"
```

Please be aware that the additional parameters are only necessary if the files are downloaded via the bash. If you plan to download the files on hicexplorer.usegalaxy.eu and use there fastq-dump, the here shown additional parameters are handled in the background and only the accession number is required.

The downloaded fastq files must be in the following format:

```
@HWI-M02293:190:000000000-AHGUV:1:1101:12370:1000/1
NAAACTTCAAGGAAGCCAGAACAAGGATAGGAAAGNNNNGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNTNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
+
#8ACCGGGGGGGGGGFGGGGGGGGGGG9FFDFGGG####################################################################################################################
@HWI-M02293:190:000000000-AHGUV:1:1101:12370:1000/2
NNNNNNNN
+
########
@HWI-M02293:190:000000000-AHGUV:1:1101:12370:1000/3
NNNNNNNN
+
########
@HWI-M02293:190:000000000-AHGUV:1:1101:12370:1000/4
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
+
#######################################################################################################################################################
@HWI-M02293:190:000000000-AHGUV:1:1101:13757:1000/1
NCCCTGTACTGGGGCATATAAAGTTTTACATGCACNTNTTNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNANNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
+
#8BCCGGGGGFFFGGGGGGGGGGGGGGGGGGFGGG####################################################################################################################
@HWI-M02293:190:000000000-AHGUV:1:1101:13757:1000/2
NNNNNNNN
+
########
@HWI-M02293:190:000000000-AHGUV:1:1101:13757:1000/3
NNNNNNNN
+
########
@HWI-M02293:190:000000000-AHGUV:1:1101:13757:1000/4
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
+
#######################################################################################################################################################
```

Please check this before the demultiplexing starts. If this format is not present, the demultiplexing will not work and creates only an empty output folder.

## [Demultiplexing](#id2)[¶](#demultiplexing "Permalink to this headline")

Each downloaded file needs to be demultiplexed. To do so the [barcodes per sample](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE94489&format=file&file=GSE94489%5FREADME%2Etxt) and the [SRR to sample](https://github.com/joachimwolff/scHiCExplorer/blob/master/samples.txt) mapping needs to be provided:

```
$ scHicDemultiplex -f "FASTQ_FILE" --srrToSampleFile samples.txt --barcodeFile GSE94489_README.txt --threads 20
```

scHicDemultiplex creates a folder ‘demultiplexed’ containing the demultiplexed fastq files split as forward and reverse reads and follows the scheme:

```
sample_id_barcode_RX.fastq.gz
```

For example:

```
Diploid_15_AGGCAGAA_CTCTCTAT_R1.fastq.gz
```

Please consider that the time to demultiplex the file SRR5229025, which itself is 4.1 GB takes already ~35 mins, to demultiplex the full 1 TB dataset will take around 6 days to compute.

## [Mapping](#id3)[¶](#mapping "Permalink to this headline")

After demultiplexing, each forward and reverse strand file needs to be mapped as usual in Hi-C as single-paired files. For this tutorial we use bwa mem and the mm10 index:

```
$ wget http://hgdownload-test.cse.ucsc.edu/goldenPath/mm10/bigZips/chromFa.tar.gz -O genome_mm10/chromFa.tar.gz
$ tar -xvzf genome_mm10/chromFa.tar.gz
$ cat genome_mm10/*.fa > genome_mm10/mm10.fa
```

```
$ bwa index -p bwa/mm10_index genome_mm10/mm10.fa
```

```
$ bwa mem -A 1 -B 4 -E 50 -L 0 -t 8 bwa/mm10_index Diploid_15_AGGCAGAA_CTCTCTAT_R1.fastq.gz | samtools view -Shb - > Diploid_15_AGGCAGAA_CTCTCTAT_R1.bam
$ ls demultiplexed |  xargs -n1 -P 5 -I {} sh -c "bwa mem -A 1 -B 4 -E 50 -L 0 -t 8 bwa/mm10_index demultiplexed/{} | samtools view -Shb - > {}.bam"
```

## [Creation of Hi-C interaction matrices](#id4)[¶](#creation-of-hi-c-interaction-matrices "Permalink to this headline")

As a last step, the matrices for each cell need to be created, we use the tool ‘hicBuildMatrix’ from HiCExplorer:

```
$ hicBuildMatrix -s  Diploid_15_AGGCAGAA_CTCTCTAT_R1.bam Diploid_15_AGGCAGAA_CTCTCTAT_R2.bam --binSize 1000000 --QCfolder  Diploid_15_AGGCAGAA_CTCTCTAT_QC -o Diploid_15_AGGCAGAA_CTCTCTAT.cool --threads 4
```

To make this step more automated, it is recommend to use either a platform like hicexplorer.usegalaxy.eu or to use a batch script:

```
$ ls *.bam |  tr '\n' ' ' | xargs -n 2 -P 1 -d ' ' | xargs -n1 -P1-I {} bash -c 'multinames=$1;outname=$(echo $multinames | cut -d" " -f 1 | sed -r "s?(^.*)_R[12]\..*?\\1?"); mkdir ${outname}_QC && hicBuildMatrix -s $multinames --binSize 1000000 --QCfolder  ${outname}_QC -o ${outname}.cool --threads 4' -- {}
```

After the Hi-C interaction matrices for each cell is created, the matrices are pooled together to one scool matrix:

```
$ scHicMergeToScool --matrices matrices/* --outFileName nagano2017_raw.scool
```

Call scHicInfo to get an information about the used scool file:

```
$ scHicInfo --matrix nagano2017_raw.scool
```

```
Filename: nagano2017_raw.scool
Contains 3882 single-cell matrices
The information stored via cooler.info of the first cell is:

bin-size 1000000
bin-type fixed
creation-date 2019-05-16T11:46:31.826214
format HDF5::Cooler
format-url https://github.com/mirnylab/cooler
format-version 3
generated-by cooler-0.8.3
genome-assembly unknown
metadata {}
nbins 2744
nchroms 35
nnz 55498
storage-mode symmetric-upper
sum 486056
```

## [Quality control](#id5)[¶](#quality-control "Permalink to this headline")

Quality control is the crucial step in preprocessing of all HTS related data. For single-cell experiments the read coverage
per sample needs to be on a minimal level, and all matrices needs to be not broken and contain all the same chromosomes. Especially the last two issues are
likely to rise in single-cell Hi-C data because the read coverage is with around 1 million reads, in contrast to regular Hi-C with a few
hundred million, quite low and therefore it is more likely that simply no data for small chromosomes is present.
To guarantee these requirements the quality control works in three steps:

1. Only matrices which contain all listed chromosomes are accepted
2. Only matrices which have a minimum read coverage are accepted
3. The matrix must have a minium density of recorded data points close to the main diagonal.

```
$ scHicQualityControl --matrix nagano2017_raw.scool --outputscool nagano2017_qc.scool --minimumReadCoverage 100000 --minimumDensity 0.02 --maximumRegionToConsider 30000000 --outFileNameReadCoverage read_coverage.png --outFileNameDensity density.png --threads 20 --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chrX
```

For this tutorial a minimum read coverage of 1 million and a density of 0.1% is used in range of 30MB around the main diagonal. The above command creates certain files:

1. A scool matrix containing only samples with matrices that passed the quality settings.
2. A plot showing the density of all samples. Use this plot to adjust the minimumDensity parameter.
3. A plot showing the read coverage of all samples, use this plot to adjust the minimum read coverage parameter.
4. A text report presenting quality control information.

![../_images/density.png](../_images/density.png)
![../_images/read_coverage.png](../_images/read_coverage.png)

```
# QC report for single-cell Hi-C data generated by scHiCExplorer 1
scHi-C sample contained 3882 cells:
Number of removed matrices containing bad chromosomes 0
Number of 