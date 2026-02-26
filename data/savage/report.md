# savage CWL Generation Report

## savage

### Tool Description
SAVAGE - Strain Aware VirAl GEnome assembly. SAVAGE assembles individual (viral) haplotypes from NGS data. It expects as input single- and/or paired-end Illumina sequencing reads. Please note that the paired-end reads are expected to be in forward-forward format, as output by PEAR.

### Metadata
- **Docker Image**: quay.io/biocontainers/savage:0.4.2--py27h3e4de3e_0
- **Homepage**: https://github.com/HaploConduct/HaploConduct/tree/master/savage
- **Package**: https://anaconda.org/channels/bioconda/packages/savage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/savage/overview
- **Total Downloads**: 29.3K
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

