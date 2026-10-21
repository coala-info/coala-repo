# rseqc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rseqc_FPKM-UQ.py | Failed | image problem: htseq-count is not installed in the image, so the tool stops before it counts reads |
| rseqc_FPKM_count.py | PASS |  |
| rseqc_RNA_fragment_size.py | PASS |  |
| rseqc_RPKM_saturation.py | PASS |  |
| rseqc_bam2fq.py | PASS |  |
| rseqc_bam2wig.py | Failed | image problem: wigToBigWig is not in the image, so the bigWig output is silently not written (the tool prints 'command not found' and exits 0); the wiggle output itself is identical to the Galaxy expected file. |
| rseqc_bam_stat.py | PASS |  |
| rseqc_clipping_profile.py | PASS |  |
| rseqc_deletion_profile.py | PASS |  |
| rseqc_divide_bam.py | PASS |  |
| rseqc_geneBody_coverage.py | PASS |  |
| rseqc_geneBody_coverage2.py | PASS |  |
| rseqc_infer_experiment.py | PASS |  |
| rseqc_inner_distance.py | PASS |  |
| rseqc_insertion_profile.py | PASS |  |
| rseqc_junction_annotation.py | PASS |  |
| rseqc_junction_saturation.py | PASS |  |
| rseqc_mismatch_profile.py | PASS |  |
| rseqc_normalize_bigwig.py | PASS |  |
| rseqc_overlay_bigwig.py | PASS |  |
| rseqc_read_GC.py | PASS |  |
| rseqc_read_NVC.py | PASS |  |
| rseqc_read_distribution.py | PASS |  |
| rseqc_read_duplication.py | PASS |  |
| rseqc_read_hexamer.py | PASS |  |
| rseqc_read_quality.py | PASS |  |
| rseqc_sc_bamStat.py | PASS |  |
| rseqc_sc_editMatrix.py | Failed | image problem: R package pheatmap is missing in the image, so the heatmap files are not written (csv tables are). |
| rseqc_sc_seqLogo.py | PASS |  |
| rseqc_sc_seqQual.py | Failed | image problem: R package pheatmap is missing in the image, so the quality heatmap is not written (csv tables are). |
| rseqc_split_bam.py | PASS |  |
| rseqc_split_paired_bam.py | PASS |  |
| rseqc_tin.py | PASS |  |

## rseqc_bam2fq.py

### Tool Description
Convert alignments in BAM or SAM format into fastq format.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam2fq.py [options]

Description: Convert alignments in BAM or SAM format into fastq format.



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output fastq files(s).
  -s, --single-end      Specificy '-s' or '--single-end' for single-end
                        sequencing.
  -c, --compress        Specificy '-c' or '--compress' to compress output
                        fastq file(s) using 'gzip' command.
```

## rseqc_bam2wig.py

### Tool Description
Convert BAM file into wig file. BAM file must be sorted and indexed using SAMtools.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam2wig.py [options]

Convert BAM file into wig file. BAM file must be sorted and indexed using SAMtools.
Note: SAM format file is not supported.



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM format. BAM file must be sorted
                        and indexed using samTools. .bam and .bai files should
                        be placed in the same directory.
  -s CHROMSIZE, --chromSize=CHROMSIZE
                        Chromosome size file. Tab or space separated text file
                        with 2 columns: first column is chromosome name/ID,
                        second column is chromosome size. Chromosome name
                        (such as "chr1") should be consistent between this
                        file and the BAM file.
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output wiggle files(s). One wiggle file will
                        be generated for non strand-specific data, two wiggle
                        files ("Prefix_Forward.wig" and "Prefix_Reverse.wig")
                        will be generated for strand-specific RNA-seq data.
  -t TOTAL_WIGSUM, --wigsum=TOTAL_WIGSUM
                        Specified wigsum. Eg: 1,000,000,000 equals to coverage
                        of 10 million 100nt reads. Ignore this option to
                        disable normalization
  -u, --skip-multi-hits
                        Skip non-unique hit reads.
  -d STRAND_RULE, --strand=STRAND_RULE
                        How read(s) were stranded during sequencing. For
                        example: --strand='1++,1--,2+-,2-+' means that this is
                        a pair-end, strand-specific RNA-seq data, and the
                        strand rule is: read1 mapped to '+' => parental gene
                        on '+'; read1 mapped to '-' => parental gene on '-';
                        read2 mapped to '+' => parental gene on '-'; read2
                        mapped to '-' => parental gene on '+'.  If you are not
                        sure about the strand rule, run 'infer_experiment.py'
                        default=none (Not a strand specific RNA-seq data).
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality to determine "uniquely
                        mapped". default=30
```

## rseqc_clipping_profile.py

### Tool Description
Estimate clipping profile of RNA-seq reads from BAM or SAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: clipping_profile.py [options]

This program is to estimate clipping profile of RNA-seq reads from BAM or SAM file
Note that to use this funciton, CIGAR strings within SAM/BAM file should have 'S' operation 
(This means your reads mapper should support clipped mapping).



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s).
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be considered as "uniquely mapped".
                        default=30
  -s LAYOUT, --sequencing=LAYOUT
                        Sequencing layout. "SE"(single-end) or "PE"(pair-end).
```

## rseqc_deletion_profile.py

### Tool Description
Calculate the distributions of deleted nucleotides across reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deletion_profile.py [options]

Calculate the distributions of deleted nucleotides across reads. 



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_BAM, --input=INPUT_BAM
                        Input BAM file. [required]
  -l READ_ALIGNMENT_LENGTH, --read-align-length=READ_ALIGNMENT_LENGTH
                        Alignment length of read. It is usually set to the
                        orignial read length. For example, all these cigar
                        strings ("101M", "68M140N33M", "53M1D48M") suggest the
                        read alignment length is 101. [required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -n READ_NUMBER, --read-num=READ_NUMBER
                        Number of aligned reads with deletions used to
                        calculate the deletion profile. default=1000000
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality. default=30
```

## rseqc_divide_bam.py

### Tool Description
Equally divide BAM file (m alignments) into n parts, randomly sampled.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: divide_bam.py [options]

Equally divide BAM file (m alignments) into n parts. Each part contains roughly m/n alignments
that are randomly sampled from total alignments. 



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM format. BAM file should be
                        sorted and indexed.
  -n SUBSET_NUM, --subset-num=SUBSET_NUM
                        Number of small BAM files
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output BAM files. Output "Prefix_num.bam".
  -s, --skip-unmap      Skip unmapped reads.
```

## rseqc_FPKM_count.py

### Tool Description
Calculate raw read count, FPM and FPKM for each gene in BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: FPKM_count.py [options]

calculate raw read count, FPM (fragment per million) and FPKM (fragment per million mapped
reads per kilobase exon) for each gene in BED file.



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM format (SAM is not supported).
                        [required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -r REFGENE_BED, --refgene=REFGENE_BED
                        Reference gene model in bed fomat. [required]
  -d STRAND_RULE, --strand=STRAND_RULE
                        How read(s) were stranded during sequencing. For
                        example: --strand='1++,1--,2+-,2-+' means that this is
                        a pair-end, strand-specific RNA-seq, and the strand
                        rule is: read1 mapped to '+' => parental gene on '+';
                        read1 mapped to '-' => parental gene on '-'; read2
                        mapped to '+' => parental gene on '-'; read2 mapped to
                        '-' => parental gene on '+'.  If you are not sure
                        about the strand rule, run 'infer_experiment.py'
                        default=none (Not a strand specific RNA-seq data)
  -u, --skip-multi-hits
                        How to deal with multiple hit reads. Presence this
                        option renders program to skip multiple hits reads.
  -e, --only-exonic     How to count total reads. Presence of this option
                        renders program only used exonic (UTR exons and CDS
                        exons) reads, otherwise use all reads.
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be called "uniquely mapped". default=30
  -s SINGLE_READ, --single-read=SINGLE_READ
                        How to count read-pairs that only have one end mapped.
                        0: ignore it. 0.5: treat it as half fragment. 1: treat
                        it as whole fragment. default=1
```

## rseqc_FPKM-UQ.py

### Tool Description
Calculate count, FPKM, and FPKM-UQ values.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: FPKM-UQ.py [options]


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --bam=BAM_FILE        Alignment file in BAM format. BAM file shoul be sorted
                        and indexed. Ideally, the BAM file should generaet
                        from the TCGA RNA-seq analysis workflow described here
                        https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipeli
                        nes/Expression_mRNA_Pipeline/.
  --gtf=GTF_FILE        Gene model in GTF format.
  --info=INFOR_FILE     Gene model information file.
  -o OUT_FILE, --output=OUT_FILE
                        The prefix of the output file.
  --log2                Convert FPKM and FPKM-UQ values into log2 (x+1) scale.
                        A pseudo count 1 will be added to each
                        gene/transcript.
```

## rseqc_geneBody_coverage2.py

### Tool Description
Calculate the RNA-seq reads coverage over gene body from a bigwig file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: geneBody_coverage2.py [options]

Calculate the RNA-seq reads coverage over gene body.
This module uses bigwig file as input.



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Coverage signal file in bigwig format
  -r REF_GENE_MODEL, --refgene=REF_GENE_MODEL
                        Reference gene model in bed format. [required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -t GRAPH_TYPE, --graph-type=GRAPH_TYPE
                        Graphic file type in "pdf", "jpeg", "bmp", "bmp",
                        "tiff" or "png".default=pdf [optional]
```

## rseqc_infer_experiment.py

### Tool Description
Infer how RNA-seq reads were stranded from alignments on a gene model.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: infer_experiment.py [options]


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Input alignment file in SAM or BAM format
  -r REFGENE_BED, --refgene=REFGENE_BED
                        Reference gene model in bed fomat.
  -s SAMPLE_SIZE, --sample-size=SAMPLE_SIZE
                        Number of reads sampled from SAM/BAM file.
                        default=200000
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be considered as "uniquely mapped".
                        default=30
```

## rseqc_inner_distance.py

### Tool Description
Calculate the inner distance (insert size) of RNA-seq fragments.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: inner_distance.py [options]

Calculate the inner distance (insert size)  of RNA-seq fragments. 

               RNA fragment
 _________________||_________________
|                                    |
|                                    |
||||||||||------------------||||||||||
  read_1      insert_size     read_2

fragment size = read_1 + insert_size + read_2



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s)
  -r REF_GENE, --refgene=REF_GENE
                        Reference gene model in BED format.
  -k SAMPLESIZE, --sample-size=SAMPLESIZE
                        Number of read-pairs used to estimate inner distance.
                        default=1000000
  -l LOWER_BOUND_SIZE, --lower-bound=LOWER_BOUND_SIZE
                        Lower bound of inner distance (bp). This option is
                        used for ploting histograme. default=-250
  -u UPPER_BOUND_SIZE, --upper-bound=UPPER_BOUND_SIZE
                        Upper bound of inner distance (bp). This option is
                        used for plotting histogram. default=250
  -s STEP_SIZE, --step=STEP_SIZE
                        Step size (bp) of histograme. This option is used for
                        plotting histogram. default=5
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be called "uniquely mapped". default=30
```

## rseqc_insertion_profile.py

### Tool Description
Calculate the distributions of inserted nucleotides across reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: insertion_profile.py [options]

Calculate the distributions of inserted nucleotides across reads
Note CIGAR strings within SAM/BAM file should have 'I' operation 



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s).
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be considered as "uniquely mapped".
                        default=30
  -s LAYOUT, --sequencing=LAYOUT
                        Sequencing layout. "SE"(single-end) or "PE"(pair-end).
```

## rseqc_junction_annotation.py

### Tool Description
Annotate splicing reads against a gene model at read level and junction level.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: junction_annotation.py [options]

Annotate splicing reads against gene model in two levels: reads level and  juncion level.
Note:
1) A read, especially long read, can be spliced 2 or more times
2) Multiple splicing reads spanning the same intron can be consolidated into one splicing junction.



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -r REF_GENE_MODEL, --refgene=REF_GENE_MODEL
                        Reference gene model in bed format. This file is
                        better to be a pooled gene model as it will be used to
                        annotate splicing junctions [required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -m MIN_INTRON, --min-intron=MIN_INTRON
                        Minimum intron length (bp). default=50 [optional]
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be considered as "uniquely mapped".
                        default=30
```

## rseqc_junction_saturation.py

### Tool Description
Check if sequencing depth is saturated, based on the discovery of new splice junctions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: junction_saturation.py [options]

Check if sequencing depth is saturated or not, based on the concept that when sequencing depth is 
approaching saturation, less NEW junctions will be discovered. 
See http://rseqc.sourceforge.net/ for details.



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.[required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -r REFGENE_BED, --refgene=REFGENE_BED
                        Reference gene model in bed fomat. This gene model is
                        used to determine known splicing junctions. [required]
  -l PERCENTILE_LOW_BOUND, --percentile-floor=PERCENTILE_LOW_BOUND
                        Sampling starts from this percentile. A integer
                        between 0 and 100. default=5
  -u PERCENTILE_UP_BOUND, --percentile-ceiling=PERCENTILE_UP_BOUND
                        Sampling ends at this percentile. A integer between 0
                        and 100. default=100
  -s PERCENTILE_STEP, --percentile-step=PERCENTILE_STEP
                        Sampling frequency. Smaller value means more sampling
                        times. A integer between 0 and 100. default=5
  -m MINIMUM_INTRON_SIZE, --min-intron=MINIMUM_INTRON_SIZE
                        Minimum intron size (bp). default=50
  -v MINIMUM_SPLICE_READ, --min-coverage=MINIMUM_SPLICE_READ
                        Minimum number of supportting reads to call a
                        junction. default=1
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be called "uniquely mapped". default=30
```

## rseqc_mismatch_profile.py

### Tool Description
Calculate the distribution of mismatches across reads (the MD tag must exist).

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mismatch_profile.py [options]

Calculate the distribution of mismatches across reads. Note that the "MD" tag must exist in BAM file.



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_BAM, --input=INPUT_BAM
                        Input BAM file. [required]
  -l READ_ALIGNMENT_LENGTH, --read-align-length=READ_ALIGNMENT_LENGTH
                        Alignment length of read. It is usually set to the
                        orignial read length. For example, all these cigar
                        strings ("101M", "68M140N33M", "53M1D48M") suggest the
                        read alignment length is 101. [required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -n READ_NUMBER, --read-num=READ_NUMBER
                        Number of aligned reads with mismatches used to
                        calculate the mismatch profile. default=1000000
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality. default=30
```

## rseqc_RNA_fragment_size.py

### Tool Description
Calculate fragment size for each gene or transcript.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNA_fragment_size.py [options]

calculate fragment size for each gene/transcript. For each transcript/gene, it Will report:
1) # of fragment that was used.
2) mean of fragment size
3) median of fragment size
4) stdev of fragment size



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input=INPUT_FILE
                        Input BAM file
  -r REFGENE_BED, --refgene=REFGENE_BED
                        Reference gene model in BED format. Must be strandard
                        12-column BED file. [required]
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be called "uniquely mapped". default=30
  -n FRAGMENT_NUM, --frag-num=FRAGMENT_NUM
                        Minimum number of fragment. default=3
```

## rseqc_RPKM_saturation.py

### Tool Description
For each gene, check whether the RPKM value is saturated by re-sampling reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RPKM_saturation.py [options]
-------------------------------------------------------------------------------------------------
For each gene, check whether the RPKM value was saturated or not. Saturation analysis is based on 
re-sampling. For example, sample 5%, 10%, ... , 95%, 100% from total mapped reads, then 
calculate RPKM value for each step. Strand specific sequencing protocol is supported.
-------------------------------------------------------------------------------------------------


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format. [required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -r REFGENE_BED, --refgene=REFGENE_BED
                        Reference gene model in bed fomat. [required]
  -d STRAND_RULE, --strand=STRAND_RULE
                        How read(s) were stranded during sequencing. For
                        example: --strand='1++,1--,2+-,2-+' means that this is
                        a pair-end, strand-specific RNA-seq, and the strand
                        rule is: read1 mapped to '+' => parental gene on '+';
                        read1 mapped to '-' => parental gene on '-'; read2
                        mapped to '+' => parental gene on '-'; read2 mapped to
                        '-' => parental gene on '+'.  If you are not sure
                        about the strand rule, run 'infer_experiment.py'
                        default=none (Not a strand specific RNA-seq data)
  -l PERCENTILE_LOW_BOUND, --percentile-floor=PERCENTILE_LOW_BOUND
                        Sampling starts from this percentile. A integer
                        between 0 and 100. default=5
  -u PERCENTILE_UP_BOUND, --percentile-ceiling=PERCENTILE_UP_BOUND
                        Sampling ends at this percentile. A integer between 0
                        and 100. default=100
  -s PERCENTILE_STEP, --percentile-step=PERCENTILE_STEP
                        Sampling frequency. Smaller value means more sampling
                        times. A integer between 0 and 100. default=5
  -c RPKM_CUTOFF, --rpkm-cutoff=RPKM_CUTOFF
                        Transcripts with RPKM smaller than this number will be
                        ignored in visualization plot. default=0.01
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be called "uniquely mapped". default=30
```

## rseqc_normalize_bigwig.py

### Tool Description
Normalize a BigWig file to a given total signal (wigsum) and write it as wig or bedGraph.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: normalize_bigwig.py [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i BIGWIG_FILE, --bwfile=BIGWIG_FILE
                        Input BigWig file. [required]
  -o OUTPUT_WIG, --output=OUTPUT_WIG
                        Output wig file. [required]
  -t TOTAL_WIGSUM, --wigsum=TOTAL_WIGSUM
                        Specified wigsum. 100000000 equals to coverage of 1
                        million 100nt reads. default=100000000  [optional]
  -r REFGENE_BED, --refgene=REFGENE_BED
                        Reference gene model in bed format. [optional]
  -c CHUNK_SIZE, --chunk=CHUNK_SIZE
                        Chromosome chunk size. Each chomosome will be cut into
                        samll chunks of this size. Decrease chunk size will
                        save more RAM. default=500000 (bp) [optional]
  -f OUT_FORMAT, --format=OUT_FORMAT
                        Output format. either "wig" or "bgr". "bgr" save disk
                        space but make program slower. default=bgr
```

## rseqc_overlay_bigwig.py

### Tool Description
Combine two BigWig files signal by signal (add, average, divide, max, min, product, subtract or geometric mean) and write a wig file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: overlay_bigwig.py [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i BIGWIG_FILE1, --bwfile1=BIGWIG_FILE1
                        One BigWig file.
  -j BIGWIG_FILE2, --bwfile2=BIGWIG_FILE2
                        Another BigWig file. Both BigWig files should use the
                        same reference genome.
  -a ACTION, --action=ACTION
                        After pairwise align two bigwig files, perform the
                        follow actions (Only select one keyword):"Add" = add
                        signals. "Average" = average signals. "Division"=
                        divide bigwig2 from bigwig1. Add 1 to both bigwig.
                        "Max" = pick the signal that is larger. "Min" = pick
                        the signal that is smaller. "Product" = multiply
                        signals. "Subtract" = subtract signals in 2nd bigwig
                        file from the corresponiding ones in the 1st bigwig
                        file. "geometricMean" = take the geometric mean of
                        signals.
  -o OUTPUT_WIG, --output=OUTPUT_WIG
                        Output wig file
  -c CHUNK_SIZE, --chunk=CHUNK_SIZE
                        Chromosome chunk size. Each chomosome will be cut into
                        samll chunks of this size. Decrease chunk size will
                        save more RAM. default=100000 (bp)
```

## rseqc_read_GC.py

### Tool Description
Calculate the distribution of reads' GC content.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: read_GC.py [options]
-------------------------------------------------------------------------------------------------
Calculate distribution of reads' GC content
-------------------------------------------------------------------------------------------------


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s).
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be called "uniquely mapped". default=30
```

## rseqc_read_NVC.py

### Tool Description
Check the nucleotide frequency at each read position (NVC plot).

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: read_NVC.py [options]
-------------------------------------------------------------------------------------------------
For each nucleotide  position of read (5'->3'), check the nucleotide frequency. The generated R script will
gives NVC (Nucleotide Versus Cycle) plot.
-------------------------------------------------------------------------------------------------


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Input file in BAM or SAM format.[required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -x, --nx              Flag option. Presense of this flag tells program to
                        include N,X in output NVC plot [required]
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be called "uniquely mapped". default=30
```

## rseqc_read_distribution.py

### Tool Description
Check the distribution of reads over exon, intron, UTR and intergenic regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: read_distribution.py [options]

Check reads distribution over exon, intron, UTR, intergenic ... etc
The following reads will be skipped:
	qc_failed
	PCR duplicate
	Unmapped
	Non-primary (or secondary)	



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -r REF_GENE_MODEL, --refgene=REF_GENE_MODEL
                        Reference gene model in bed format.
```

## rseqc_read_duplication.py

### Tool Description
Calculate reads' duplication rate (sequence-based and mapping-based).

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: read_duplication.py [options]

Calculte reads' duplication rate. 
Sequence-based: Reads with identical sequence are considered as "duplicate reads".
Mapping-based: Reads mapped to the exact same location are considered as "duplicate reads".



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s).
  -u UPPER_LIMIT, --up-limit=UPPER_LIMIT
                        Upper limit of reads' occurrence. Only used for
                        plotting, default=500 (times)
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be considered as "uniquely mapped".
                        default=30
```

## rseqc_read_hexamer.py

### Tool Description
Calculate the hexamer frequency table of reads, a reference genome and reference mRNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
read_hexamer.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_READ, --input=INPUT_READ
                        Read sequence in fasta or fastq format. Multiple
                        fasta/fastq files should be separated by ','. For
                        example: read.fq,read2.fa,read3,fa
  -r REF_GENOME, --refgenome=REF_GENOME
                        Reference genome sequence in fasta format. Optional
  -g REF_GENE, --refgene=REF_GENE
                        Reference mRNA sequence in fasta format. Optional
```

## rseqc_read_quality.py

### Tool Description
Calculate the Phred quality score for each position on the read.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: read_quality.py [options]
-------------------------------------------------------------------------------------------------
Calculating Phred Quality Score for each position on read. Note that each read should have 
the fixed (same) length
-------------------------------------------------------------------------------------------------


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format. [required]
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
  -r REDUCE_FOLD, --reduce=REDUCE_FOLD
                        To avoid making huge vector in R, nucleotide with
                        particular phred score less frequent than this number
                        will be ignored. Increase this number save more memory
                        while reduce precision. Set to 1 achieves maximum
                        precision (i.e. every nucleotide will be considered).
                        This option only applies to the 'boxplot'. default=1
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) for an
                        alignment to be called "uniquely mapped". default=30
```

## rseqc_sc_bamStat.py

### Tool Description
Report single cell RNA-seq read mapping statistics from a Cell Ranger BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
Reports single cell RNA-seq (scRNA-seq) reads mapping statistics.
It processes the BAM file generated by the Cell Ranger workflow.


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i BAM_FILE, --infile=BAM_FILE
                        Input file in BAM foramt. Must have BAM alignment tags
                        indicated below.
  --cb-tag=CB_TAG       BAM alignment tag. Used to indicate error-corrected
                        cellular barcode. default='CB'
  --re-tag=RE_TAG       BAM alignment tag. Used to indicate the region type of
                        the alignment (E = exonic, N = intronic, I =
                        intergenic). default='RE'
  --tx-tag=TX_TAG       BAM alignment tag. Used to indicate reads aligned to
                        the same strand as the annotated transcripts.
                        default='TX'
  --an-tag=AN_TAG       BAM alignment tag. Used to indicate reads aligned to
                        the antisense strand of the annotated transcripts.
                        default='AN'
  --umi-tag=UMI_TAG     BAM alignment tag. Used to indicat the error-corrected
                        UMI. default='UB'
  --xf-tag=XF_TAG       BAM alignment tag. Used to indicate reads confidently
                        mapped to the feature. default='xf'
  --chrM-id=MIT_CONTIG_NAME
                        The name of mitochondrial chromosome in BAM file.
                        default='chrM'
  --verbose             Logical to determine if detailed running information
                        is printed to screen.
```

## rseqc_sc_editMatrix.py

### Tool Description
Generate heatmaps of the positions, types and frequencies of edits in error-corrected cell barcodes and UMIs.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
This program generates heatmaps to visualize the **positions** (X-axis),
type of edits (Y-axis, such as "C" to "T") and  **frequencies** (color)
of error-corrected nucleotides in cell barcodes and UMIs.



Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --infile=IN_FILE
                        Input file in BAM foramt.
  -o OUT_FILE, --outfile=OUT_FILE
                        The prefix of output files.
  --limit=READS_NUM     Number of alignments to process. default=none
  --cr-tag=CR_TAG       Tag of cellular barcode reported by the sequencer in
                        BAM file. default='CR'
  --cb-tag=CB_TAG       Tag of error-corrected cellular barcode in BAM file.
                        default='CB'
  --ur-tag=UR_TAG       Tag of UMI reported by the sequencer in BAM file.
                        default='UR'
  --ub-tag=UB_TAG       Tag of error-corrected UMI in BAM file. default='UB'
  --cell-width=CELL_WIDTH
                        Points of cell width in the heatmap. default=15
  --cell-height=CELL_HEIGHT
                        Points of cell height in the heatmap. default=10
  --font-size=FONT_SIZE
                        Font size. If --display-num was set, fontsize_number =
                        0.8 * font_size. default=8
  --angle=COL_ANGLE     The angle (must be 0, 45, 90, 270, 315) of column text
                        lables under the heatmap. default=45
  --text-color=TEXT_COLOR
                        The color of numbers in each cell. default=black
  --file-type=FILE_TYPE
                        The file type of heatmap. Choose one of 'pdf', 'png',
                        'tiff', 'bmp', 'jpeg'. default=pdf
  --verbose             If set, detailed running information is printed to
                        screen.
  --no-num              If set, will not print numerical values to cells.
                        default=False
```

## rseqc_sc_seqLogo.py

### Tool Description
Generate a DNA sequence logo from a fasta or fastq file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
This program generates a DNA sequence logo from fasta or fastq format file.
It is useful to visualize the nucleotide compositions of sample barcodes,
cell barcodes and molecular barcodes.


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --infile=IN_FILE
                        Input DNA sequence file in FASTQ
                        (https://en.wikipedia.org/wiki/FASTQ_format#),FASTA
                        (https://en.wikipedia.org/wiki/FASTA_format) or pure
                        sequence format. All sequences must be the same
                        length. This file can be plain text or compressed
                        format (".gz", ".Z",".z",".bz", ".bz2", ".bzip2").
  -o OUT_FILE, --outfile=OUT_FILE
                        The prefix of output files.
  --iformat=IN_FORMAT   The format of input file. Must be 'fq' or 'fa'.
                        default='fq'
  --oformat=OUT_FORMAT  The format of output logo file. Must be 'pdf', 'png'
                        or 'svg'. default='pdf'
  -n MAX_SEQ, --nseq-limit=MAX_SEQ
                        Only process this many sequences and stop.
                        default=none (generate logo fromALL sequences).
  --font-name=FONT_NAME
                        The font of logo characters. For a list of valid font
                        names, run logomaker.list_font_names().default='sans'
  --stack-order=STACK_ORDER
                        Must be 'big_on_top', 'small_on_top', or 'fixed'.
                        'big_on_top' : nucleotide with the highestfrequency
                        will be on the top; 'small_on_top' : nucleotide with
                        the lowest frequency will be on thetop; 'fixed' :
                        nucleotides from top to bottom are in the same order
                        as characters appear in thedata frame.
                        default='big_on_top'
  --flip-below          If set, characters below the X-axis (which correspond
                        to negative values in the matrix)will be flipped
                        upside down. default=False
  --shade-below=SHADE_BELOW
                        The amount of shading to use for characters drawn
                        below the X-axis. 0 <= shade_below <= 1.Larger values
                        correspond to more shading. default=0.0
  --fade-below=FADE_BELOW
                        The amount of fading to use for characters drawn below
                        the X-axis. 0 <= shade_below <= 1. Larger values
                        correspond to more fading. default=0.0
  --excludeN            If set, exclude all DNA sequences containing "N".
  --highlight-start=HI_START
                        Highlight logo from this position. Must be within [0,
                        sequence_length-1].default=none (no highlight)
  --highlight-end=HI_END
                        Highlight logo to this position. Must be within [0,
                        len(logo)-1].default=none (no highlight)
  --verbose             If set, print detailed information for debugging.
```

## rseqc_sc_seqQual.py

### Tool Description
Generate a heatmap from a FASTQ file to visualize the sequencing quality.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
This program generates heatmap from a FASTQ file to visualize the sequencing quality.


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --infile=IN_FILE
                        Input file in FASTQ
                        (https://en.wikipedia.org/wiki/FASTQ_format#) format.
  -o OUT_FILE, --outfile=OUT_FILE
                        The prefix of output files.
  -n MAX_SEQ, --nseq-limit=MAX_SEQ
                        Only process this many sequences and stop.
                        default=none (generate logo from ALL sequences).
  --cell-width=CELL_WIDTH
                        Cell width (in points) of the heatmap. default=12
  --cell-height=CELL_HEIGHT
                        Cell height (in points) of the heatmap. default=10
  --font-size=FONT_SIZE
                        Font size in points. If --display-num was set,
                        fontsize_number = 0.8 * font_size. default=6
  --angle=COL_ANGLE     The angle (must be 0, 45, 90, 270, 315) of column text
                        lables under the heatmap. default=45
  --text-color=TEXT_COLOR
                        The color of numbers in each cell. default=black
  --file-type=FILE_TYPE
                        The file type of heatmap. Choose one of 'pdf', 'png',
                        'tiff', 'bmp', 'jpeg'. default=pdf
  --no-num              if set, will not print numerical values to cells.
                        default=False
  --verbose             If set, will produce detailed information for
                        debugging.
```

## rseqc_split_bam.py

### Tool Description
Split a BAM file according to an input gene list (bed).

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: split_bam.py [options]
-------------------------------------------------------------------------------------------------
Split bam file according to input gene list (bed).
-------------------------------------------------------------------------------------------------


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format. BAM file should
                        be sorted and indexed.
  -r GENE_LIST, --genelist=GENE_LIST
                        Gene list in bed foramt. All reads hits to exon
                        regions (defined by this gene list) will be saved into
                        one BAM file, the remaining reads will saved into
                        another BAM file.
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output BAM files. "prefix.in.bam" file
                        contains reads mapped to the gene list specified by
                        "-r", "prefix.ex.bam" contains reads that cannot
                        mapped to gene list. "prefix.junk.bam" contains
                        qcfailed or unmapped reads.
```

## rseqc_split_paired_bam.py

### Tool Description
Split a paired-end BAM file into two single-end BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: split_paired_bam.py [options]
-------------------------------------------------------------------------------------------------
Split bam file (pair-end) into 2 single-end bam file
-------------------------------------------------------------------------------------------------


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format. BAM file should
                        be sorted and indexed
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output BAM files. "prefix.R1.bam" file
                        contains the 1st read, "prefix.R2.bam" file contains
                        the 2nd read
```

## rseqc_tin.py

### Tool Description
Calculate the transcript integrity number (TIN) for each transcript in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tin.py [options]
-------------------------------------------------------------------------------------------------
This program calculates transcript integrity number (TIN) for each transcript (or gene) in
BED file. TIN is conceptually similar to RIN (RNA integrity number) but provides transcript
level measurement of RNA quality and is more sensitive to measure low quality RNA samples:

1) TIN score of a transcript is used to measure the RNA integrity of the transcript.
2) Median TIN score across all transcripts can be used to measure RNA integrity  of that
   "RNA sample".
3) TIN ranges from 0 (the worst) to 100 (the best). TIN = 60 means: 60% of the transcript
   has been covered if the reads coverage were uniform.
4) TIN will be assigned to 0 if the transcript has no coverage or covered reads is fewer than
   cutoff.
-------------------------------------------------------------------------------------------------


Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILES, --input=INPUT_FILES
                        Input BAM file(s). "-i" takes these input: 1) a single
                        BAM file. 2) "," separated BAM files (no spaces
                        allowed). 3) directory containing one or more bam
                        files. 4) plain text file containing the path of one
                        or more bam files (Each row is a BAM file path). All
                        BAM files should be sorted and indexed using samtools.
                        [required]
  -r REF_GENE_MODEL, --refgene=REF_GENE_MODEL
                        Reference gene model in BED format. Must be strandard
                        12-column BED file. [required]
  -c MINIMUM_COVERAGE, --minCov=MINIMUM_COVERAGE
                        Minimum number of read mapped to a transcript.
                        default=10
  -n SAMPLE_SIZE, --sample-size=SAMPLE_SIZE
                        Number of equal-spaced nucleotide positions picked
                        from mRNA. Note: if this number is larger than the
                        length of mRNA (L), it will be halved until it's
                        smaller than L. default=100
  -s, --subtract-background
                        Subtract background noise (estimated from intronic
                        reads). Only use this option if there are substantial
                        intronic reads.
```

## Metadata
- **Skill**: generated

## rseqc_bam_stat.py

### Tool Description
Summarizing mapping statistics of a BAM or SAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bam_stat.py [options]

Summarizing mapping statistics of a BAM or SAM file. 

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file=INPUT_FILE
                        Alignment file in BAM or SAM format.
  -q MAP_QUAL, --mapq=MAP_QUAL
                        Minimum mapping quality (phred scaled) to determine
                        "uniquely mapped" reads. default=30
```
## rseqc_geneBody_coverage.py

### Tool Description
Calculate the RNA-seq reads coverage over gene body.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
- **Homepage**: https://rseqc.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rseqc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: geneBody_coverage.py [options]

Calculate the RNA-seq reads coverage over gene body. 

Note:
1) Only input sorted and indexed BAM file(s). SAM format is not supported.
2) Genes/transcripts with mRNA length < 100 will be skipped (Number specified to "-l" cannot be < 100). 

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILES, --input=INPUT_FILES
                        Input file(s) in BAM format. "-i" takes these input:
                        1) a single BAM file. 2) "," separated BAM files. 3)
                        directory containing one or more bam files. 4) plain
                        text file containing the path of one or more bam file
                        (Each row is a BAM file path). All BAM files should be
                        sorted and indexed using samtools.
  -r REF_GENE_MODEL, --refgene=REF_GENE_MODEL
                        Reference gene model in bed format. [required]
  -l MIN_MRNA_LENGTH, --minimum_length=MIN_MRNA_LENGTH
                        Minimum mRNA length (bp). mRNA smaller than
                        "min_mRNA_length" will be skipped. default=100
  -f OUTPUT_FORMAT, --format=OUTPUT_FORMAT
                        Output file format, 'pdf', 'png' or 'jpeg'.
                        default=pdf
  -o OUTPUT_PREFIX, --out-prefix=OUTPUT_PREFIX
                        Prefix of output files(s). [required]
```
