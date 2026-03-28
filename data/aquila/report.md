# aquila CWL Generation Report

## aquila_Aquila_step0_sortbam

### Tool Description
sort bam by qname

### Metadata
- **Docker Image**: quay.io/biocontainers/aquila:1.0.0--py_0
- **Homepage**: https://github.com/maiziex/Aquila
- **Package**: https://anaconda.org/channels/bioconda/packages/aquila/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aquila/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/maiziex/Aquila
- **Stars**: N/A
### Original Help Text
```text
usage: Aquila_step0_sortbam [-h] --bam_file BAM_FILE [--out_dir OUT_DIR]
                            [--num_threads_for_samtools_sort NUM_THREADS_FOR_SAMTOOLS_SORT]

sort bam by qname:

optional arguments:
  -h, --help            show this help message and exit
  --bam_file BAM_FILE, -b BAM_FILE
                        Required parameter, BAM file, called by "longranger
                        align"
  --out_dir OUT_DIR, -o OUT_DIR
                        Directory to store Aquila assembly results, default =
                        ./Assembly_results
  --num_threads_for_samtools_sort NUM_THREADS_FOR_SAMTOOLS_SORT, -t NUM_THREADS_FOR_SAMTOOLS_SORT
                        The number of threads you can define for samtools
                        sort, default = 20
```


## aquila_Aquila_step1

### Tool Description
Aquila_step1 tool for assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/aquila:1.0.0--py_0
- **Homepage**: https://github.com/maiziex/Aquila
- **Package**: https://anaconda.org/channels/bioconda/packages/aquila/overview
- **Validation**: PASS

### Original Help Text
```text
usage: use "python3 Aquila_step1 --help" for more information

Author: xzhou15@cs.stanford.edu

optional arguments:
  -h, --help            show this help message and exit
  --bam_file BAM_FILE, -bam BAM_FILE
                        Required parameter; BAM file, called by longranger
                        align
  --vcf_file VCF_FILE, -v VCF_FILE
                        Required parameter; VCF file, called by FreeBayes
  --chr_start CHR_START, -start CHR_START
                        chromosome start from, default = 1
  --chr_end CHR_END, -end CHR_END
                        chromosome end by,default = 23
  --sample_name SAMPLE_NAME, -name SAMPLE_NAME
                        Required parameter; Sample Name you can define by
                        yourself, for example: S12878
  --out_dir OUT_DIR, -o OUT_DIR
                        Directory to store assembly results, default =
                        ./Assembly_results
  --uniq_map_dir UNIQ_MAP_DIR, -uniq_dir UNIQ_MAP_DIR
                        Required Parameter; Directory for 100-mer uniqness,
                        run ./install to download "Uniquess_map" for hg38
  --num_threads NUM_THREADS, -t_chr NUM_THREADS
                        number of threads, default = 8 (recommended)
  --num_threads_for_samtools_sort NUM_THREADS_FOR_SAMTOOLS_SORT, -t NUM_THREADS_FOR_SAMTOOLS_SORT
                        number of threads for samtools sort, default = 20
  --num_threads_for_extract_reads NUM_THREADS_FOR_EXTRACT_READS, -t_extract NUM_THREADS_FOR_EXTRACT_READS
                        number of threads for extracting raw reads, default =
                        8 (recommended)
  --block_threshold BLOCK_THRESHOLD, -bt BLOCK_THRESHOLD
                        phase block threshold, default = 200000
  --block_len_use BLOCK_LEN_USE, -bl BLOCK_LEN_USE
                        phase block len threshold, default = 100000
  --mbq_threshold MBQ_THRESHOLD, -mbq MBQ_THRESHOLD
                        phred-scaled quality score for the assertion made in
                        ALT, default = 13
  --boundary BOUNDARY, -bound BOUNDARY
                        boundary for long fragments with the same barcode,
                        default = 50000 (recommended)
```


## aquila_Aquila_step2

### Tool Description
Aquila_step2

### Metadata
- **Docker Image**: quay.io/biocontainers/aquila:1.0.0--py_0
- **Homepage**: https://github.com/maiziex/Aquila
- **Package**: https://anaconda.org/channels/bioconda/packages/aquila/overview
- **Validation**: PASS

### Original Help Text
```text
usage: use "python3 Aquila_step2 --help" for more information

Author: xzhou15@cs.stanford.edu

optional arguments:
  -h, --help            show this help message and exit
  --chr_start CHR_START, -start CHR_START
                        chromosome start from, default = 1
  --chr_end CHR_END, -end CHR_END
                        chromosome end by, default = 23
  --out_dir OUT_DIR, -o OUT_DIR
                        Required parameter; Directory to store assembly
                        results
  --reference REFERENCE, -ref REFERENCE
                        Required parameter; reference fasta file, run
                        ./install to download "source/ref.fa" for GRCh38
  --num_threads NUM_THREADS, -t NUM_THREADS
                        number of threads, default = 30, this correponds to
                        number of small files get assembled simulateoulsy
  --num_threads_spades NUM_THREADS_SPADES, -t_spades NUM_THREADS_SPADES
                        number of threads for spades, default = 5
  --block_len_use BLOCK_LEN_USE, -bl BLOCK_LEN_USE
                        phase block len threshold, default = 100000
```


## Metadata
- **Skill**: generated
