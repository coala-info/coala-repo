# haploconduct CWL Generation Report

## haploconduct_savage

### Tool Description
SAVAGE - Strain Aware VirAl GEnome assembly. SAVAGE assembles individual (viral) haplotypes from NGS data. It expects as input single- and/or paired-end Illumina sequencing reads. Please note that the paired-end reads are expected to be in forward-forward format, as output by PEAR.

### Metadata
- **Docker Image**: quay.io/biocontainers/haploconduct:0.2.1--py27h78a066a_0
- **Homepage**: https://github.com/HaploConduct/HaploConduct
- **Package**: https://anaconda.org/channels/bioconda/packages/haploconduct/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haploconduct/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HaploConduct/HaploConduct
- **Stars**: N/A
### Original Help Text
```text
usage: savage.py [-h] [-s INPUT_S] [-p1 INPUT_P1] [-p2 INPUT_P2]
                 [-m MIN_OVERLAP_LEN] [-t THREADS] --split SPLIT_NUM
                 [--revcomp] [-o OUTDIR] [--ref REFERENCE] [--no_stage_a]
                 [--no_stage_b] [--no_stage_c] [--no_overlaps]
                 [--no_preprocessing] [--no_assembly] [--count_strains]
                 [--ignore_subreads] [--merge_contigs MERGE_CONTIGS]
                 [--min_clique_size MIN_CLIQUE_SIZE]
                 [--overlap_len_stage_c OVERLAP_STAGE_C]
                 [--contig_len_stage_c CONTIG_LEN_STAGE_C] [--keep_branches]
                 [--sfo_mm SFO_MM] [--diploid]
                 [--diploid_contig_len DIPLOID_CONTIG_LEN]
                 [--diploid_overlap_len DIPLOID_OVERLAP_LEN]
                 [--average_read_len AVERAGE_READ_LEN] [--no_filtering]
                 [--max_tip_len MAX_TIP_LEN]

Program: SAVAGE - Strain Aware VirAl GEnome assembly
Version: 0.4.2
Release date: December 23, 2019
Contact: Jasmijn Baaijens

SAVAGE assembles individual (viral) haplotypes from NGS data. It expects as
input single- and/or paired-end Illumina sequencing reads. Please note that the
paired-end reads are expected to be in forward-forward format, as output by
PEAR.

Run savage -h for a complete description of required and optional arguments.

For the complete manual, please visit https://bitbucket.org/jbaaijens/savage

optional arguments:
  -h, --help            show this help message and exit

basic arguments:
  -s INPUT_S            path to input fastq containing single-end reads
  -p1 INPUT_P1          path to input fastq containing paired-end reads (/1)
  -p2 INPUT_P2          path to input fastq containing paired-end reads (/2)
  -m MIN_OVERLAP_LEN, --min_overlap_len MIN_OVERLAP_LEN
                        minimum overlap length required between reads
  -t THREADS, --num_threads THREADS
                        allowed number of cores
  --split SPLIT_NUM     split the data set into patches s.t. 500 < coverage/split_num < 1000
  --revcomp             use this option when paired-end input reads are in forward-reverse orientation;
                        this option will take reverse complements of /2 reads (specified with -p2)
                        please see the SAVAGE manual for more information about input read orientations
  -o OUTDIR, --outdir OUTDIR
                        specify output directory

reference-guided mode:
  --ref REFERENCE       reference genome in fasta format

advanced arguments:
  --no_stage_a          skip Stage a (initial contig formation)
  --no_stage_b          skip Stage b (extending initial contigs)
  --no_stage_c          skip Stage c (merging maximized contigs into master strains)
  --no_overlaps         skip overlap computations (use existing overlaps file instead)
  --no_preprocessing    skip preprocessing procedure (i.e. creating data patches)
  --no_assembly         skip all assembly steps; only use this option when using --count_strains separate from assembly (e.g. on a denovo assembly)
  --count_strains       compute a lower bound on the number of strains in this sample; note: this requires a reference genome.
  --ignore_subreads     ignore subread info from previous stage
  --merge_contigs MERGE_CONTIGS
                        specify maximal distance between contigs for merging into master strains (stage c)
  --min_clique_size MIN_CLIQUE_SIZE
                        minimum clique size used during error correction
  --overlap_len_stage_c OVERLAP_STAGE_C
                        min_overlap_len used in stage c
  --contig_len_stage_c CONTIG_LEN_STAGE_C
                        minimum contig length required for stage c input contigs
  --keep_branches       disable merging along branches by removing them from the graph (stage b & c)
  --sfo_mm SFO_MM       input parameter -e=SFO_MM for sfo: maximal mismatch rate 1/SFO_MM
  --diploid             use this option for diploid genome assembly
  --diploid_contig_len DIPLOID_CONTIG_LEN
                        minimum contig length required for diploid step contigs
  --diploid_overlap_len DIPLOID_OVERLAP_LEN
                        min_overlap_len used in diploid assembly step
  --average_read_len AVERAGE_READ_LEN
                        average length of the input reads; will be computed from the input if not specified
  --no_filtering        disable kallisto-based filtering of contigs
  --max_tip_len MAX_TIP_LEN
                        maximum extension length for a sequence to be called a tip
```


## haploconduct_polyte

### Tool Description
POLYTE assembles individual haplotypes from NGS data. It expects as
input single- and/or paired-end Illumina sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/haploconduct:0.2.1--py27h78a066a_0
- **Homepage**: https://github.com/HaploConduct/HaploConduct
- **Package**: https://anaconda.org/channels/bioconda/packages/haploconduct/overview
- **Validation**: PASS

### Original Help Text
```text
usage: polyte.py [-h] [-s INPUT_S] [-p1 INPUT_P1] [-p2 INPUT_P2]
                 [-m MIN_OVERLAP_LEN] [-m_EC MIN_OVERLAP_LEN_EC] [-t THREADS]
                 --hap_cov HAP_COV --insert_size INSERT_SIZE --stddev STDDEV
                 [--ref REFERENCE] [--ref_guided_mode] [--no_EC]
                 [--no_overlaps] [--no_preprocessing] [--no_assembly]
                 [--count_strains] [--mismatch_rate MERGE_CONTIGS]
                 [--min_clique_size MIN_CLIQUE_SIZE] [--sfo_err SFO_ERR]
                 [--diploid] [--diploid_contig_len DIPLOID_CONTIG_LEN]
                 [--diploid_overlap_len DIPLOID_OVERLAP_LEN]
                 [--average_read_len AVERAGE_READ_LEN]
                 [--max_tip_len MAX_TIP_LEN]
                 [--original_SE_count ORIGINAL_SE_COUNT]
                 [--original_PE_count ORIGINAL_PE_COUNT]
                 [--original_fastq ORIGINAL_FASTQ]

Program: POLYTE
Version: 0.1.0
Release date: 
Contact: Jasmijn Baaijens - j.a.baaijens@cwi.nl

POLYTE assembles individual haplotypes from NGS data. It expects as
input single- and/or paired-end Illumina sequencing reads.

Run polyte.py -h for a complete description of required and optional arguments.

For the complete manual, please visit https://github.com/HaploConduct/HaploConduct

optional arguments:
  -h, --help            show this help message and exit

basic arguments:
  -s INPUT_S            path to input fastq containing single-end reads
  -p1 INPUT_P1          path to input fastq containing paired-end reads (/1)
  -p2 INPUT_P2          path to input fastq containing paired-end reads (/2)
  -m MIN_OVERLAP_LEN, --min_overlap_len MIN_OVERLAP_LEN
                        minimum overlap length required between reads
  -m_EC MIN_OVERLAP_LEN_EC, --min_overlap_len_EC MIN_OVERLAP_LEN_EC
                        minimum overlap length required between reads during error correction
  -t THREADS, --num_threads THREADS
                        allowed number of cores
  --hap_cov HAP_COV     average coverage per haplotype
  --insert_size INSERT_SIZE
                        mean insert size for paired-end input
  --stddev STDDEV       standard deviation of insert size for paired-end input

reference-guided mode:
  --ref REFERENCE       reference genome in fasta format
  --ref_guided_mode     perform reference-guided assembly

advanced arguments:
  --no_EC               skip error correction in initial iteration (i.e. no cliques)
  --no_overlaps         skip overlap computations (use existing overlaps file instead)
  --no_preprocessing    skip preprocessing procedure
  --no_assembly         skip all assembly steps, only run diploid mode (if specified)
  --count_strains       compute a lower bound on the number of strains in this sample; note: this requires a reference genome.
  --mismatch_rate MERGE_CONTIGS
                        specify maximal distance between contigs for merging into master strains (stage c)
  --min_clique_size MIN_CLIQUE_SIZE
                        minimum clique size used during error correction
  --sfo_err SFO_ERR     input parameter for sfo: maximal mismatch rate
  --diploid             use this option for diploid genome assembly
  --diploid_contig_len DIPLOID_CONTIG_LEN
                        minimum contig length required for diploid step contigs
  --diploid_overlap_len DIPLOID_OVERLAP_LEN
                        min_overlap_len used in diploid assembly step; by default equal to assembly min_overlap_len.
  --average_read_len AVERAGE_READ_LEN
                        average length of the input reads; will be computed from the input if not specified
  --max_tip_len MAX_TIP_LEN
                        maximum extension length for a sequence to be called a tip

split mode:
  --original_SE_count ORIGINAL_SE_COUNT
                        number of single-end sequences in input before splitting
  --original_PE_count ORIGINAL_PE_COUNT
                        number of paired-end sequences in input before splitting
  --original_fastq ORIGINAL_FASTQ
                        original fastq file before splitting
```


## haploconduct_polyte-split

### Tool Description
POLYTE assembles individual haplotypes from NGS data. It expects as
input single- and/or paired-end Illumina sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/haploconduct:0.2.1--py27h78a066a_0
- **Homepage**: https://github.com/HaploConduct/HaploConduct
- **Package**: https://anaconda.org/channels/bioconda/packages/haploconduct/overview
- **Validation**: PASS

### Original Help Text
```text
usage: polyte-split.py [-h] [-s INPUT_S] [-p1 INPUT_P1] [-p2 INPUT_P2]
                       [-m MIN_OVERLAP_LEN] [-m_EC MIN_OVERLAP_LEN_EC]
                       [-t THREADS] --hap_cov HAP_COV --insert_size
                       INSERT_SIZE --stddev STDDEV --ref REFERENCE
                       [--split_size SPLIT_SIZE]
                       [--split_overlap SPLIT_OVERLAP] [--split_only]
                       [--no_assembly] [--count_strains]
                       [--mismatch_rate MERGE_CONTIGS]
                       [--min_clique_size MIN_CLIQUE_SIZE] [--sfo_err SFO_ERR]
                       [--diploid] [--diploid_contig_len DIPLOID_CONTIG_LEN]
                       [--diploid_overlap_len DIPLOID_OVERLAP_LEN]
                       [--average_read_len AVERAGE_READ_LEN]
                       [--max_tip_len MAX_TIP_LEN] [--pool_size POOL_SIZE]
                       [--sfo_threads SFO_THREADS]

Program: POLYTE
Version: 0.1.0
Release date: 
Contact: Jasmijn Baaijens - j.a.baaijens@cwi.nl

POLYTE assembles individual haplotypes from NGS data. It expects as
input single- and/or paired-end Illumina sequencing reads.

Run polyte.py -h for a complete description of required and optional arguments.

For the complete manual, please visit https://github.com/HaploConduct/HaploConduct

optional arguments:
  -h, --help            show this help message and exit

basic arguments:
  -s INPUT_S            path to input fastq containing single-end reads
  -p1 INPUT_P1          path to input fastq containing paired-end reads (/1)
  -p2 INPUT_P2          path to input fastq containing paired-end reads (/2)
  -m MIN_OVERLAP_LEN, --min_overlap_len MIN_OVERLAP_LEN
                        minimum overlap length required between reads
  -m_EC MIN_OVERLAP_LEN_EC, --min_overlap_len_EC MIN_OVERLAP_LEN_EC
                        minimum overlap length required between reads during error correction
  -t THREADS, --num_threads THREADS
                        allowed number of cores
  --hap_cov HAP_COV     average coverage per haplotype
  --insert_size INSERT_SIZE
                        mean insert size for paired-end input
  --stddev STDDEV       standard deviation of insert size for paired-end input

reference-guided vertical data splitting:
  --ref REFERENCE       reference genome in fasta format
  --split_size SPLIT_SIZE
                        size of regions over which the reads are divided
  --split_overlap SPLIT_OVERLAP
                        size of overlap between regions over which the reads are divided
  --split_only          don't do assembly, only data splitting

advanced arguments:
  --no_assembly         skip all assembly steps, only run diploid mode (if specified)
  --count_strains       compute a lower bound on the number of strains in this sample; note: this requires a reference genome.
  --mismatch_rate MERGE_CONTIGS
                        specify maximal distance between contigs for merging into master strains (stage c)
  --min_clique_size MIN_CLIQUE_SIZE
                        minimum clique size used during error correction
  --sfo_err SFO_ERR     input parameter for sfo: maximal mismatch rate
  --diploid             use this option for diploid genome assembly
  --diploid_contig_len DIPLOID_CONTIG_LEN
                        minimum contig length required for diploid step contigs
  --diploid_overlap_len DIPLOID_OVERLAP_LEN
                        min_overlap_len used in diploid assembly step
  --average_read_len AVERAGE_READ_LEN
                        average length of the input reads; will be computed from the input if not specified
  --max_tip_len MAX_TIP_LEN
                        maximum extension length for a sequence to be called a tip

thread pool settings:
  --pool_size POOL_SIZE
                        number of regions to be processed in parallel
  --sfo_threads SFO_THREADS
                        number of threads used per region
```


## Metadata
- **Skill**: generated
