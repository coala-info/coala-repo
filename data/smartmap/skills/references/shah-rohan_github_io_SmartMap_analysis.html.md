# Analysis of MultiMap Data

In this workflow, we will aim to walk through and enable replication of the MultiMap analysis.

## Dependencies

This workflow requires the following tools to be installed and added to the PATH environment variable:

* Bowtie2 v. 2.3.5.1
* Hisat2 v. 2.1.0
* Python v. 3.8.5
* R v. 4.0.4
* Samtools v. 1.10
* Bedtools v. 2.27.1
* SRA Toolkit v. 2.10.9
* NEAT-genReads v. 2.0
* MACS2 v. 2.2.7.1
* MultiMap v. 0.2.0

This workflow is best run in a bash shell on an Ubuntu system. We have tested this workflow on Ubuntu 20.04 LTS. No other software environment (e.g. Conda) is necessary for this analysis provided the above are installed and added to the PATH environment variable. If that is not possible, the scripts and commands below should be modified to directly point to the relevant executable.

## Downloading and Unpacking Workflow

The workflow can be downloaded and unpacked from Zenodo from [here](https://dx.doi.org/10.5281/zenodo.4586639). Once this is done, please unpack the workflow using the following command:

```
```
x
```

```
tar -xvzf multimap_workflow.tar.gz
```
```

Once this is done, please navigate into the unpacked `multimap_workflow` directory to begin analysis.

## Included Resources

Several resources are included for convenience and for reproducibility. First, there are several custom genomes required to analyze the referenced ICeChIP-seq data; these reference genomes (consisting of the base genome plus sequences for nucleosomal standards) are included in the `reference_genomes` directory, as are the Bowtie2 indices needed. In addition, the necessary calibration tables (indicating which nucleosomal standards correspond to which histone modifications) are also included in the `windows` directory.

Second, we have included several of our simulated datasets. These are included because the random selection of true origin loci and the simulation of paired-end sequencing data, by its nature, is a random process; as such, we felt it is important to provide the actual data used for this analysis.

The size of the FASTQ files prevents us from including the simulated FASTQ files in this workflow due to total size constraints. However, we have separately uploaded these files to [this separate Zenodo workflow](https://dx.doi.org/10.5281/zenodo.4584103) for download if you wish to analyze the data from this stage.

In addition, this workflow includes the BED files containing the Gold Standard reads for both the true origin analysis with 50bp PE reads and with 100bp PE reads. In addition, we have included the BED files of the aligned reads for the 100bp PE reads, as well as for 50bp PE reads with either no specified maximum number of alignments (the "no-k" condition) or with a maximum of 51 alignments per read. We have also included the BED file listing the simulated target loci. These are all found in the `simulated/presimulated` directory.

Due to size limitations, we were unable to include the BED file of aligned 50bp PE reads with a maximum of 101 alignments per read; if you wish to conduct this analysis, you will need to align the dataset on your system from the FASTQ files linked above.

We also include several datasets that will be useful for downstream analysis. These include the UMAP50 scores for hg38, mm10, and dm3 (contained in the `umap` directory), a list of repeat promoters with sectioning into windows (contained in the `promoters` directory), and a list of 200bp genomic windows (contained in the `windows` directory).

## Simulating Paired-End Reads

To generate simulated paired-end reads, there are two steps: random selection of loci and simulation of the paired-end reads covering those loci. Here, we will simulate both the 200bp loci with 50bp PE reads and with 100bp PE reads.

The first step is accomplished using Bedtools.

```
```
xxxxxxxxxx
```

```
bedtools random -n 6000000 -l 200 -g reference_genomes/hg38/hg38.len | awk '{print $1"\t"$2"\t"$3"\t"$4}'| sort -k1,1 -k2,2n > simulated/hg38_6mil_200bp_ID.bed
```
```

This file is the list of simulated target loci. We then generate the reads using the NEAT-genReads tool.

```
```
xxxxxxxxxx
```

```
python gen_reads.py -r reference_genomes/hg38/hg38.fa -R 50 -c 30 -tr simulated/hg38_6mil_200bp_ID.bed --pe 175 10 --bam --gz -o simulated/hg38_6mil_200bp_30xCov
```

```
​
```

```
python gen_reads.py -r reference_genomes/hg38/hg38.fa -R 100 -c 30 -tr simulated/hg38_6mil_200bp_ID.bed --pe 175 10 --bam --gz -o simulated/hg38_6mil_200bp_30xCov_100bp
```
```

The resulting files will be a Gold Standard BAM file and a pair of simulated FASTQ files for the 50bp read length and 100bp read length datasets. For simplicity, we will then move the FASTQ files to the `fastq` directory.

```
```
xxxxxxxxxx
```

```
mv simulated/hg38_6mil_200bp_30xCov_read1.fq.gz fastq/hg38_6mil_200bp_30xCov_read1.fq.gz
```

```
mv simulated/hg38_6mil_200bp_30xCov_read1.fq.gz fastq/hg38_6mil_200bp_30xCov_read2.fq.gz
```

```
mv simulated/hg38_6mil_200bp_30xCov_100bp_read1.fq.gz fastq/hg38_6mil_200bp_30xCov_100bp_read1.fq.gz
```

```
mv simulated/hg38_6mil_200bp_30xCov_100bp_read2.fq.gz fastq/hg38_6mil_200bp_30xCov_100bp_read2.fq.gz
```
```

We will now create our BED files from the Gold Standard BAM files.

```
```
xxxxxxxxxx
```

```
samtools view simulated/hg38_6mil_200bp_30xCov_golden.bam | awk '$2==99{print $3"\t"$4"\t"$4+$9-1"\t"$1}' > simulated/hg38_6mil_200bp_30xCov_golden.bed
```

```
samtools view simulated/hg38_6mil_200bp_30xCov_100bp_golden.bam | awk '$2==99{print $3"\t"$4"\t"$4+$9-1"\t"$1}' > simulated/hg38_6mil_200bp_30xCov_100bp_golden.bed
```
```

## Downloading Biological Datasets

The MNase-seq and ICeChIP-seq datasets are all downloaded from the Short Read Archive (SRA), and the ATAC-seq and RNA-seq datasets are all downloaded from the ENCODE Consortium.

We will be downloading the MNase-seq and ICeChIP-seq datasets from the SRA database, where they have been deposited.

To do this, we will first prefetch the SRA data, then validate and convert to FASTQ files, which we will place in the `fastq` directory. We have created a script `sra_download.sh` to accomplish these tasks. Of note: on our system, the SRA toolkit local cache location is `~/data/ncbi/`. If this is not the case on your system, the script will require modification; the default location is `~/ncbi/public/` for the cache.

In addition, we will download the ATAC-seq and RNA-seq datasets from the ENCODE consortium website. This is also done by the `sra_download.sh` script. To download all these files, run the command:

```
```
xxxxxxxxxx
```

```
bash scripts/fastq_download.sh
```
```

At the conclusion of this script, you should have gzipped FASTQ files corresponding to all the MNase-seq, ICeChIP-seq, ATAC-seq, and RNA-seq analyses in the `fastq` directory.

## Aligning Reads

The next step is to align and filter the reads for the various datasets. This will be a very computationally-intensive section. On our system, we ran this using 48 cores; the below scripts should be modified if you would like to change that number of cores for your system. For all but the RNA-seq analysis, we will use Bowtie2 for alignment; for the RNA-seq analysis, we will use Hisat2. The Bowtie2 indices are already provided for your convenience in `reference_genomes`. The Hisat2 indices, for the sake of saving space, have been omitted; however, the Hisat2 index for hg38 with the ENCODE ERCC standards can be easily built. From the main directory, run:

```
```
xxxxxxxxxx
```

```
gunzip reference_genomes/hg38_ENCODE/hg38_ENCODE.fa.gz
```

```
hisat2-build -p 48 reference_genomes/hg38_ENCODE/hg38_ENCODE.fa reference_genomes/hg38_ENCODE/hg38_ENCODE
```
```

This will place the Hisat2 indices in the directory `reference_genomes/hg38_hisat2/hg38/`.

Next, we will align the datasets and process them into the extended BED files that can be read into the MultiMap software. The commands to align all these datasets are organized into the `align_datasets.sh` script.

```
```
xxxxxxxxxx
```

```
bash scripts/align_datasets.sh
```
```

## Filtering and Processing Alignments

If you are using the provided simulated data files, the BED files should be decompressed and moved into the `analysis/aligned` directory at this time. There are then several housekeeping items that can be done now. First, for the random alignment selection dataset, we wish to partition and randomly select alignments from the simulated data with -k 51 and 50bp reads. This can be accomplished with the following script:

```
```
xxxxxxxxxx
```

```
bash scripts/random_read.sh
```
```

In addition, we can run the following command to generate files that counts the distribution of the number of alignments per read. This command outputs the number of alignments per read, the number of alignments with that degeneracy, and the number of reads with the same.

```
```
xxxxxxxxxx
```

```
for i in analysis/aligned/*.bed; do (awk '{if ($4==storedval){a++; next} b[a]++; a = 1; storedval = $4} END {b[a]++; for (j in b){print j"\t"b[j]"\t"b[j]/j}}' $i | sort -k1,1n > $i".counts"); done
```

```
mv analysis/aligned/*.counts analysis/counts/
```
```

Finally, we will use generate the genome-wide bedgraph file and use it to compute average score over the simulated windows. If you are using the provided simulation files, the Gold Standard bed files should be decompressed and moved into the `simulated` directory at this time.

```
```
xxxxxxxxxx
```

```
bash scripts/golden_analysis.sh
```
```

## Running MultiMap

At this point, we now wish to run MultiMap on our datasets.

We will be running the following analyses on the simulated dataset with the 50bp reads and maximum of 51 reported alignments per read:

* Scored mode

  + Zero through 10 iterations of multiread analysis
  + Uniread analysis
  + Zero through eight iterations of slow fitting with a rate of 0.25
* Unscored mode

  + Zero or one iteration of multiread analysis
  + Uniread analysis

For the random alignment and uniread alignment analyses, we will only run uniread analysis in scored mode. For the simulation with a maximum of 101 reported alignments per read, we will run only multiread analysis in scored mode. For all other analyses, we will run uniread and multiread analyses with one iteration in scored mode. The RNA-seq analyses must be run in strand-specific mode.

We will run all of these commands using the `run_multimaps.sh` script, as follows. We will also move logfiles from the `bedgraphs` directory to the `logfiles` directory.

```
```
xxxxxxxxxx
```

```
bash scripts/run_multimaps.sh
```

```
mv analysis/bedgraphs/*.log analysis/logfiles
```
```

You should now have all the MultiMap and uniread analyses in the `analysis/bedgraphs` directory.

## Analysis of Simulated Datasets

We will now analyze the simulated datasets by computing the coverage of each simulated dataset over the true origin loci. If you are using the provided simulated data, you should move the list of loci into the `simulated` directory at this time.

The script `compute_simulated_windows.sh` will compute the average UMAP50 score over the true origin loci, as well as computing the average depth of each simulated dataset under MultiMap or uniread conditions over the same. The output will be several files ready for analysis in R. To run this script, use the command:

```
```
xxxxxxxxxx
```

```
bash scripts/compute_simulated_windows.sh
```

```
rm analysis/windows/*.txt
```
```

These files are now ready for downstream analysis. First, several of the analyses simply involve computing mean absolute error or mean error; these are sufficiently straightforward to compute directly in the bash shell.

```
```
xxxxxxxxxx
```

```
# Compute mean absolute error for scored iterations 0-10
```

```
awk 'function abs(v) {return v < 0 ? -v : v} {for (i=7; i<=NF; i++){a[i]+=abs($i-$6)}} END {for (i=7; i<=NF; i++){print a[i]/NR}}' analysis/windows/hg38_6mil_200bp_ID_UMAP50_golden_iter-0-10.tab
```

```
​
```

```
# Compute mean error for scored iterations 0-10
```

```
awk '{for (i=7; i<=NF; i++){a[i]+=$i-$6}} END {for (i=7; i<=NF; i++){print a[i]/NR}}' analysis/windows/hg38_6mil_200bp_ID_UMAP50_golden_iter-0-10.tab
```

```
​
```

```
# Compute mean absolute error for multimap, random alignment, and uniread alignment
```

```
awk 'function abs(v) {return v < 0 ? -v : v} {for (i=7; i<=NF; i++){a[i]+=abs($i-$6)}} END {for (i=7; i<=NF; i++){print a[i]/NR}}' analysis/windows/hg38_6mil_200bp_ID_UMAP50_golden_multimap_randomread_uniread.tab
```

```
​
```

```
# Compute mean absolute error for slow fit analysis
```

```
awk 'function abs(v) {return v < 0 ? -v : v} {for (i=7; i<=NF; i++){a[i]+=abs($i-$6)}} END {for (i=7; i<=NF; i++){print a[i]/NR}}' analysis/windows/hg38_6mil_200bp_ID_UMAP50_golden_slowfit25_iter-0-8.tab
```
```

The other analyses, including those generating graphs or doing more involved computation, require use of R scripts. These tools will output into the `analysis/processed` directory data for direct plotting in the graphing software of choice (as tab-delimited files) or EPS files for the QQ plots with color gradient, which are not easily transferred to another software. If you wish to save the ggplots from R instead, add a ggsave command after each plot you wish to save.

```
```
xxxxxxxxxx
```

```
# Comparison of the different multimap or uniread modalities
```

```
Rscript scripts/score_iter_analysis.R
```

```
​
```

```
# Comparison of the k101 analysis to the k51 analyses
```

```
Rscript scripts/k101_analysis.R
```

```
​
```

```
# Comparison of multimap and uniread with 100bp reads
```

```
Rscript scripts/simulated_100bp_analysis.R
```
```

We also wish to examine the proportion of alignments overlapping with the true origin reads. This will tell us three things. First, this analysis will output the proportion of alignments that intersect with the true origin of the read as a function of weight. This is analogous to the classic definition of MAPQ. Second, this analysis will tell us the average overlap proportion score of alignments as a function of weight, where the overlap proportion score is used as a metric for the proportion of a read's overall weight that overlaps with a given true origin of the read due to a given alignment. This is meant to simultaneously measure how well the assigned weight correlates with both the confidence of the alignment selection and its overlap with the true origin of the read. Third, this analysis will give us the overlap proportions between the alignment and the true read origin. To conduct this analysis, run the `overlap_analysis.sh` script.

```
```
xxxxxxxxxx
```

```
bash scripts/overlap_analysis.sh
```

```
rm analysis/windows/*.txt
```
```

This will generate the TAB files of the overlap analyses in the `analysis/windows` directory with the extension `weight_prop_overlapwt_overlap.tab`, containing the weight, proportion of alignments intersecting, weighted overlap propo