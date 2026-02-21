# Sample output files for tximport

This data package provides a set of output files from running a number
of various transcript abundance quantifiers on 6 samples from the
[GEUVADIS Project](http://www.geuvadis.org/web/geuvadis). The
files are contained in the `inst/extdata` directory.

A citation for the GEUVADIS Project is:

> Lappalainen, et al., “Transcriptome and genome sequencing uncovers
> functional variation in humans”, Nature 501, 506-511 (26 September
> 2013) [doi:10.1038/nature12531](http://dx.doi.org/10.1038/nature12531).

The purpose of this vignette is to detail which versions of software
were run, and exactly what calls were made.

# Sample information and quantification files

A small file, `samples.txt` is included in the `inst/extdata` directory:

```
dir <- system.file("extdata", package="tximportData")
samples <- read.table(file.path(dir,"samples.txt"), header=TRUE)
samples
```

```
##   pop center                assay    sample experiment       run
## 1 TSI  UNIGE NA20503.1.M_111124_5 ERS185497  ERX163094 ERR188297
## 2 TSI  UNIGE NA20504.1.M_111124_7 ERS185242  ERX162972 ERR188088
## 3 TSI  UNIGE NA20505.1.M_111124_6 ERS185048  ERX163009 ERR188329
## 4 TSI  UNIGE NA20507.1.M_111124_7 ERS185412  ERX163158 ERR188288
## 5 TSI  UNIGE NA20508.1.M_111124_2 ERS185362  ERX163159 ERR188021
## 6 TSI  UNIGE NA20514.1.M_111124_4 ERS185217  ERX163062 ERR188356
```

Further details can be found in a more extended table:

```
samples.ext <- read.delim(file.path(dir,"samples_extended.txt"), header=TRUE)
colnames(samples.ext)
```

```
##  [1] "Source.Name"
##  [2] "Comment.ENA_SAMPLE."
##  [3] "Characteristics.Organism."
##  [4] "Term.Source.REF"
##  [5] "Term.Accession.Number"
##  [6] "Characteristics.Strain."
##  [7] "Characteristics.population."
##  [8] "Comment.1000g.Phase1.Genotypes."
##  [9] "Protocol.REF"
## [10] "Protocol.REF.1"
## [11] "Extract.Name"
## [12] "Comment.LIBRARY_SELECTION."
## [13] "Comment.LIBRARY_SOURCE."
## [14] "Comment.SEQUENCE_LENGTH."
## [15] "Comment.LIBRARY_STRATEGY."
## [16] "Comment.LIBRARY_LAYOUT."
## [17] "Comment.NOMINAL_LENGTH."
## [18] "Comment.NOMINAL_SDEV."
## [19] "Protocol.REF.2"
## [20] "Performer"
## [21] "Assay.Name"
## [22] "Technology.Type"
## [23] "Comment.ENA_EXPERIMENT."
## [24] "Comment.READ_INDEX_1_BASE_COORD."
## [25] "Protocol.REF.3"
## [26] "Scan.Name"
## [27] "Comment.SUBMITTED_FILE_NAME."
## [28] "Comment.ENA_RUN."
## [29] "Comment.FASTQ_URI."
## [30] "Protocol.REF.4"
## [31] "Derived.Array.Data.File"
## [32] "Comment..Derived.ArrayExpress.FTP.file."
## [33] "Factor.Value.population."
## [34] "Factor.Value.laboratory."
## [35] "date"
```

The quantification outputs themselves can be found in sub-directories:

```
list.files(dir)
```

```
##  [1] "alevin"                  "cufflinks"
##  [3] "gencode"                 "kallisto"
##  [5] "kallisto_boot"           "oarfish"
##  [7] "refseq"                  "rsem"
##  [9] "sailfish"                "salmon"
## [11] "salmon_dm"               "salmon_ec"
## [13] "salmon_gibbs"            "samples.txt"
## [15] "samples_extended.txt"    "tx2gene.csv"
## [17] "tx2gene.ensembl.v87.csv" "tx2gene.gencode.v27.csv"
## [19] "tx2gene_alevin.tsv"
```

```
list.files(file.path(dir,"cufflinks"))
```

```
## [1] "isoforms.attr_table"  "isoforms.count_table" "isoforms.fpkm_table"
```

```
list.files(file.path(dir,"rsem","ERR188021"))
```

```
## [1] "ERR188021.genes.results.gz"    "ERR188021.isoforms.results.gz"
```

```
list.files(file.path(dir,"kallisto","ERR188021"))
```

```
## [1] "abundance.h5"     "abundance.tsv.gz" "run_info.json"
```

```
list.files(file.path(dir,"salmon","ERR188021"))
```

```
## [1] "aux_info"               "cmd_info.json"          "libParams"
## [4] "lib_format_counts.json" "logs"                   "quant.sf.gz"
```

```
list.files(file.path(dir,"sailfish","ERR188021"))
```

```
## [1] "cmd_info.json" "quant.sf"
```

```
list.files(file.path(dir,"alevin"))
```

```
## [1] "mouse1_LPS2_50"      "mouse1_unst_50"      "mouse1_unst_50_boot"
```

# Genome and gene annotation file

* For Cufflinks and Sailfish, the Illumina iGenomes was used as the index, see details below.
* For RSEM, Salmon and kallisto (without inference replicates),
  the Gencode v27 CHR transcripts were used (`gencode.v27.transcripts.fa`).
* For the `salmon_gibbs` and `kallisto_boot` directories,
  the Ensembl v87 cDNA transcripts were used (`Homo_sapiens.GRCh38.cdna.all.fa`).
* For the `salmon_dm` directory, the Ensembl Drosophila melanogaster
  v92 transcripts were used (either just cDNA or combining cDNA with
  non-coding transcripts).

Illumina iGenomes: The human genome and annotations were downloaded from
[Illumina iGenomes](https://support.illumina.com/sequencing/sequencing_software/igenome.html)
for the UCSC hg19 version. The human genome FASTA file used was in the
`Sequence/WholeGenomeFasta` directory and the gene annotation GTF file used
was the `genes.gtf` file in the `Annotation/Genes` directory. This GTF
file contains RefSeq transcript IDs and UCSC gene names. The
`Annotation` directory contained a `README.txt` file with the text:

> The contents of the annotation directories were downloaded from UCSC
> on: June 02, 2014.

The `genes.gtf` file was filtered to include only chromosomes
1-22, X, Y, and M.

# Cufflinks

Tophat2 version 2.0.11 was run with the call:

```
tophat -p 20 -o tophat_out/$f genome fastq/$f\_1.fastq.gz fastq/$f\_2.fastq.gz;
```

Cufflinks version 2.2.1 was run with the call:

```
cuffquant -p 40 -b $GENO -o cufflinks/$f genes.gtf tophat_out/$f/accepted_hits.bam;
```

Cuffnorm was run with the call:

```
cuffnorm genes.gtf -o cufflinks/ \
cufflinks/ERR188297/abundances.cxb \
cufflinks/ERR188088/abundances.cxb \
cufflinks/ERR188329/abundances.cxb \
cufflinks/ERR188288/abundances.cxb \
cufflinks/ERR188021/abundances.cxb \
cufflinks/ERR188356/abundances.cxb
```

# RSEM

RSEM version 1.2.31 was run with the call:

```
rsem-calculate-expression --num-threads 6 --bowtie2 --paired-end <(zcat fastq/$f\_1.fastq.gz) <(zcat fastq/$f\_2.fastq.gz) index rsem/$f/$f
```

# kallisto

kallisto version 0.43.1 was run with the call:

```
kallisto quant --bias -i index -t 6 -o kallisto/$f fastq/$f\_1.fastq.gz fastq/$f\_2.fastq.gz
```

For the files in `kallisto_boot` directory, kallisto version 0.43.0
was run, quantifying against the Ensembl transcripts (v87) in
`Homo_sapiens.GRCh38.cdna.all.fa`, using the call:

```
kallisto quant -i index -t 6 -b 5 -o kallisto_0.43.0/$f fastq/$f\_1.fastq.gz fastq/$f\_2.fastq.gz
```

# Salmon

Salmon version 0.8.2 was run with the call:

```
salmon quant -p 6 --gcBias -i index -l IU -1 fastq/$f\_1.fastq.gz -2 fastq/$f\_2.fastq.gz -o salmon/$f
```

For the files in the `salmon_gibbs` directory, Salmon version 0.8.1
was run, quantifying against the Ensembl transcripts (v87) in
`Homo_sapiens.GRCh38.cdna.all.fa`, using the call:

```
salmon quant -p 6 --numGibbsSamples 5 -i index -l IU -1 fastq/$f\_1.fastq.gz -2 fastq/$f\_2.fastq.gz -o salmon_gibbs/$f
```

For the files in the `salmon_dm` directory (Drosophila melanogaster),
Salmon version 0.10.2 was run (once with only cDNA, once combining
cDNA with non-coding transcripts):

```
salmon quant -l A --gcBias --seqBias --posBias -i Drosophila_melanogaster.BDGP6.cdna.v92_salmon_0.10.2 -o SRR1197474 -1 SRR1197474_1.fastq.gz -2 SRR1197474_2.fastq.gz
```

For the files in the `salmon_ec` directory,
Salmon version 1.1.0 was run with `--dumpEq` on the files from
Tasic, B., Yao, Z., Graybuck, L.T. *et al.*
“Shared and distinct transcriptomic cell types across neocortical
areas” (2018)
[doi: 10.1038/s41586-018-0654-5](https://doi.org/10.1038/s41586-018-0654-5)
These files were generated by Jeroen Gilis. The raw data is from:
<https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA476008&o=acc_s%3Aa>

# alevin

Two small examples of `alevin` output (50 cells each) were generated by
Jeroen Gilis. The dataset is a subset from the paper,
Hagai *et al.* “Gene expression variability across cells and species
shapes innate immunity” (2018)
[doi: 10.1038/s41586-018-0657-2](https://doi.org/10.1038/s41586-018-0657-2)
Salmon/alevin version 1.6.0 was run, and using the tx2gene data that
is included in the package under `tx2gene_alevin.tsv`.

# oarfish

Three samples were processed with `oarfish` v0.9.0, downloaded from the
[fastq download page](http://sg-nex-data.s3-website-ap-southeast-1.amazonaws.com/#data/sequencing_data_ont/fastq/) of the [SG-NEx Project](https://registry.opendata.aws/sgnex/). See also this [GitHub page](https://github.com/GoekeLab/sg-nex-data).

The samples were `SGNex_H9_cDNA` replicates 2-4, run 4.

These three samples were quantified with `oarfish` against human GENCODE v48 supplemented with “novel” sequences of length 1,000 bp across chr1-22 (500 per chromosome = 11,000 new transcripts named `novel1`, `novel2`, …).

Code for the quantification steps are posted to a
[GitHub repo](https://github.com/mikelove/oarfish4tximportData).

Briefly the following lines were used:

```
oarfish --only-index --annotated gencode.v48.transcripts.fa.gz --novel novel.fa.gz --seq-tech ont-cdna --threads 32 --index-out gencode_plus_novel
oarfish --reads reads/SGNex_H9_cDNA_replicateXYZ_run4.fastq.gz --index gencode_plus_novel --output quants/sgnex_h9_rep2 --seq-tech ont-cdna --filter-group no-filters --threads 32
```

Citation for the SG-NEx Project:

> Chen, Y., Davidson, N.M., Wan, Y.K. et al. A systematic benchmark of Nanopore long-read RNA sequencing for transcript-level analysis in human cell lines. Nat Methods 22, 801–812 (2025). <https://doi.org/10.1038/s41592-025-02623-4>

# Sailfish

Sailfish version 0.9.0 was run with the call:

```
sailfish quant -p 10 --biasCorrect -i sailfish_0.9.0/index -l IU -1 <(zcat fastq/$f\_1.fastq.gz) -2 <(zcat fastq/$f\_2.fastq.gz) -o sailfish_0.9.0/$f
```

# Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## loaded via a namespace (and not attached):
## [1] compiler_4.5.1 tools_4.5.1    knitr_1.50     xfun_0.54      evaluate_1.0.5
```