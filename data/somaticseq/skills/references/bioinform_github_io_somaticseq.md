# SomaticSeq

## An ensemble approach to accurately detect somatic mutations

## Publication [Open access]

If you use SomaticSeq in your work, please cite the following:

* Fang LT, Afshar PT, Chhibber A, Mohiyuddin M, Fan Y, Mu JC, Gibeling G, Barr S, Bani Asadi N, Gerstein MB, *et al*.
  An ensemble approach to accurately detect somatic mutations using SomaticSeq.
  *Genome Biology. 2015;16(1):197. [doi:10.1186/s13059-015-0758-2](http://dx.doi.org/10.1186/s13059-015-0758-2)*

The [SEQC2/MAQC-IV Consortium](https://www.fda.gov/science-research/bioinformatics-tools/microarraysequencing-quality-control-maqcseqc#MAQC_IV) has published [numerous whole-genome and whole-exome sequencing replicates from multiple sequencing centers](https://identifiers.org/ncbi/insdc.sra%3ASRP162370) for a pair of tumor-normal reference samples, along with the [high-confidence somatic mutation reference call set](https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/release/latest/). These resources can be used to train machine learning classifers (e.g., [Sahraeian SME *et al*. Genome Biol 2022](https://doi.org/10.1186/s13059-021-02592-9)) or evaluate algorithms and pipelines (e.g., [Xiao W *et al*. Nat Biotechnol 2021](https://doi.org/10.1038/s41587-021-00994-5)). This work is published as:

* Fang LT, Zhu B, Zhao Y, Chen W, Yang Z, Kerrigan L, Langenbach K, de Mars M, Lu C, Idler K, *et al*.
  Establishing community reference samples, data and call sets for benchmarking cancer mutation detection using whole-genome sequencing.
  *Nature Biotechnology. 2021;39(9):1151-1160. [doi:10.1038/s41587-021-00993-6](http://doi.org/10.1038/s41587-021-00993-6) ([SharedIt Link](https://bit.ly/2021nbt))*.

SomaticSeq was the tool that had Bina Technologies, Inc. ranked [#1 and #2 in INDEL and SNV](https://www.businesswire.com/news/home/20150915005709/en/Bina-Places-1st-and-2nd-in-DREAM-Challenge) in the Stage 5 of the [ICGC-TCGA DREAM Somatic Mutation Calling Challenge](https://www.synapse.org/#!Synapse:syn312572/wiki/70726).

Documentation can be directly downloaded [here](https://github.com/bioinform/somaticseq/blob/master/docs/Manual.pdf?raw=true).

|  |  |  |
| --- | --- | --- |
| **A quick 8-minute video explaining SomaticSeq**        [Fang LT, *et al*. Genome Biol (2015)](http://dx.doi.org/10.1186/s13059-015-0758-2) | **SEQC2 somatic mutation reference data and call sets**   1st place award 2021 MCBIOS/MAQC Annual Meeting        [Fang LT, *et al*. Nat Biotechnol (2021)](http://doi.org/10.1038/s41587-021-00993-6) / [PubMed](https://pubmed.ncbi.nlm.nih.gov/34504347/) / [SharedIt](https://bit.ly/2021nbt) | **How to run [SomaticSeq v3.6.3](https://precision.fda.gov/home/apps/app-G7XVKQQ02v051q5PK3yQYJKJ-1) on precisionFDA**        Run in [train or prediction mode](https://youtu.be/F6TSdg0OffM) |

## Download SomaticSeq

* The source code and README's are hosted at [https://github.com/bioinform/somaticseq](https://github.com/bioinform/somaticseq/)
* The packaged releases can be found at <https://github.com/bioinform/somaticseq/releases>
* Docker image can be downloaded at <https://hub.docker.com/r/lethalfang/somaticseq/>

## Software Dependencies

* Python3, plus numpy, scipy, pysam, pandas, and xgboost packages
* BEDtools (bedtools should be in the PATH)
* Optional: dbSNP and COSMIC VCF file (if you want to use those information as a part of your training set)

## Running SomaticSeq

* All VCF, BAM, and FASTA files need to be sorted identically. For VCF files, both .vcf and .vcf.gz are acceptable.
* The following command can be run when those individual mutation callers have completed running.
  To use our entire somatic mutation pipelines, read the README in our [source code](https://github.com/bioinform/somaticseq/). The pipeline is available in both [Docker](https://www.docker.com/) and [Singularity](http://singularity.lbl.gov/).

### Example command to merge caller results and extract SomaticSeq features

#### Tumor-normal **paired** mode

`somaticseq_parallel.py
--output-directory $OUTPUT_DIR
--genome-reference GRCh38.fa
--inclusion-region genome.bed
--exclusion-region blacklist.bed
paired
--tumor-bam-file tumor.bam
--normal-bam-file matched_normal.bam
--mutect2-vcf MuTect2/variants.vcf
--varscan-snv VarScan2/variants.snp.vcf
--varscan-indel VarScan2/variants.indel.vcf
--jsm-vcf JointSNVMix2/variants.snp.vcf
--somaticsniper-vcf SomaticSniper/variants.snp.vcf
--vardict-vcf VarDict/variants.vcf
--muse-vcf MuSE/variants.snp.vcf
--lofreq-snv LoFreq/variants.snp.vcf
--lofreq-indel LoFreq/variants.indel.vcf
--scalpel-vcf Scalpel/variants.indel.vcf
--strelka-snv Strelka/variants.snv.vcf
--strelka-indel Strelka/variants.indel.vcf`

#### Tumor-only **single** mode

`somaticseq_parallel.py
--output-directory $OUTPUT_DIR
--genome-reference GRCh38.fa
--inclusion-region genome.bed
--exclusion-region blacklist.bed
single
--bam-file tumor.bam
--mutect2-vcf MuTect2/variants.vcf
--varscan-vcf VarScan2/variants.vcf
--vardict-vcf VarDict/variants.vcf
--lofreq-vcf LoFreq/variants.vcf
--scalpel-vcf Scalpel/variants.indel.vcf
--strelka-vcf Strelka/variants.vcf`

#### Additional parameters to be specified before **paired** or **single** option to invoke training mode.

* `--somaticseq-train`: FLAG to invoke training mode with no argument, which also requires the following inputs, R and ada package in R
* `--truth-snv`: if you have ground truth VCF file for SNV
* `--truth-indel`: if you have a ground truth VCF file for INDEL

#### Additional input files to be specified before **paired** or **single** option invoke prediction mode (to use classifiers to score variants)

* `--classifier-snv`: classifier (.RData file) previously built for SNV
* `--classifier-indel`: classifier (.RData file) previously built for INDEL

#### Notes

* Without the paramters above to invoke training or prediction mode, SomaticSeq will default to majority-vote consensus mode.
* `--inclusion-region` and/or `--exclusion-region` will require BEDTools in your path.
* To split the job into multiple threads, place `--threads X` before the paired option to indicate X threads. It simply creates multiple BED file (each consisting of 1/X of total base pairs) for SomaticSeq to run on each of those sub-BED files in parallel. It then merges the results. This requires bedtools in your path.
* For all input VCF files, either .vcf or .vcf.gz are acceptable.

### Contact Us

Please report bugs and suggestions to the [report issues](https://github.com/bioinform/somaticseq/issues) page. The developers will be notified immediately.
Alternatively, you may email ltfang@gmail.com.

### References/Tools

* MuTect: [Cibulskis K, Lawrence MS, Carter SL, et al. Sensitive detection of somatic point mutations in impure and heterogeneous cancer samples. Nat Biotechnol. 2013;31(3):213-9.](http://dx.doi.org/10.1038/nbt.2514)
* VarScan2: [Koboldt DC, Zhang Q, Larson DE, et al. VarScan 2: somatic mutation and copy number alteration discovery in cancer by exome sequencing. Genome Res. 2012;22(3):568-76.](http://dx.doi.org/10.1101/gr.129684.111)
* JointSNVMix2: [Roth A, Ding J, Morin R, et al. JointSNVMix: a probabilistic model for accurate detection of somatic mutations in normal/tumour paired next-generation sequencing data. Bioinformatics. 2012;28(7):907-13.](http://dx.doi.org/10.1093/bioinformatics/bts053)
* SomaticSniper:  [Larson DE, Harris CC, Chen K, et al. SomaticSniper: identification of somatic point mutations in whole genome sequencing data. Bioinformatics. 2012;28(3):311-7.](http://dx.doi.org/10.1093/bioinformatics/btr665)
* VarDict: [Lai Z, Markovets A, Ahdesmaki M, Chapman B, et al. VarDict: a novel and versatile variant caller for next-generation sequencing in cancer research. Nucleic Acids Research. 2016.](http://dx.doi.org/10.1093/nar/gkw227)
* Indelocator: [Banerji S, Cibulskis K, Rangel-escareno C, et al. Sequence analysis of mutations and translocations across breast cancer subtypes. Nature. 2012;486(7403):405-9.](http://dx.doi.org/10.1038/nature11154)
* MuSE: [Fan Y, Xi L, Hughes DS, et al. MuSE: accounting for tumor heterogeneity using a sample-specific error model improves sensitivity and specificity in mutation calling from sequencing data. Genome Biol. 2016;17(1):178.](http://dx.doi.org/10.1186/s13059-016-1029-6)
* LoFreq: [Wilm A, Aw PP, Bertrand D, et al. LoFreq: a sequence-quality aware, ultra-sensitive variant caller for uncovering cell-population heterogeneity from high-throughput sequencing datasets. Nucleic Acids Res. 2012;40(22):11189-201.](http://dx.doi.org/10.1093/nar/gks918)* Scalpel: [Narzisi G, O'rawe JA, Iossifov I, et al. Accurate de novo and transmitted indel detection in exome-capture data using microassembly. Nat Methods. 2014;11(10):1033-6.](http://dx.doi.org/10.1038/nmeth.3069)* Strelka2: [Kim S, Scheffler K, Halpern AL, et al. Strelka2: fast and accurate calling of germline and somatic variants. Nat Methods. 2018;15(8):591-594.](https://doi.org/10.1038/s41592-018-0051-x)