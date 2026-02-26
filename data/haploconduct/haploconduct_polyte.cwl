cwlVersion: v1.2
class: CommandLineTool
baseCommand: polyte.py
label: haploconduct_polyte
doc: "POLYTE assembles individual haplotypes from NGS data. It expects as\ninput single-
  and/or paired-end Illumina sequencing reads.\n\nTool homepage: https://github.com/HaploConduct/HaploConduct"
inputs:
  - id: average_read_len
    type:
      - 'null'
      - int
    doc: average length of the input reads; will be computed from the input if 
      not specified
    inputBinding:
      position: 101
      prefix: --average_read_len
  - id: count_strains
    type:
      - 'null'
      - boolean
    doc: 'compute a lower bound on the number of strains in this sample; note: this
      requires a reference genome.'
    inputBinding:
      position: 101
      prefix: --count_strains
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: use this option for diploid genome assembly
    inputBinding:
      position: 101
      prefix: --diploid
  - id: diploid_contig_len
    type:
      - 'null'
      - int
    doc: minimum contig length required for diploid step contigs
    inputBinding:
      position: 101
      prefix: --diploid_contig_len
  - id: diploid_overlap_len
    type:
      - 'null'
      - int
    doc: min_overlap_len used in diploid assembly step; by default equal to 
      assembly min_overlap_len.
    inputBinding:
      position: 101
      prefix: --diploid_overlap_len
  - id: hap_cov
    type: float
    doc: average coverage per haplotype
    inputBinding:
      position: 101
      prefix: --hap_cov
  - id: insert_size
    type: int
    doc: mean insert size for paired-end input
    inputBinding:
      position: 101
      prefix: --insert_size
  - id: max_tip_len
    type:
      - 'null'
      - int
    doc: maximum extension length for a sequence to be called a tip
    inputBinding:
      position: 101
      prefix: --max_tip_len
  - id: min_clique_size
    type:
      - 'null'
      - int
    doc: minimum clique size used during error correction
    inputBinding:
      position: 101
      prefix: --min_clique_size
  - id: min_overlap_len
    type:
      - 'null'
      - int
    doc: minimum overlap length required between reads
    inputBinding:
      position: 101
      prefix: --min_overlap_len
  - id: min_overlap_len_ec
    type:
      - 'null'
      - int
    doc: minimum overlap length required between reads during error correction
    inputBinding:
      position: 101
      prefix: --min_overlap_len_EC
  - id: mismatch_rate
    type:
      - 'null'
      - float
    doc: specify maximal distance between contigs for merging into master 
      strains (stage c)
    inputBinding:
      position: 101
      prefix: --mismatch_rate
  - id: no_assembly
    type:
      - 'null'
      - boolean
    doc: skip all assembly steps, only run diploid mode (if specified)
    inputBinding:
      position: 101
      prefix: --no_assembly
  - id: no_ec
    type:
      - 'null'
      - boolean
    doc: skip error correction in initial iteration (i.e. no cliques)
    inputBinding:
      position: 101
      prefix: --no_EC
  - id: no_overlaps
    type:
      - 'null'
      - boolean
    doc: skip overlap computations (use existing overlaps file instead)
    inputBinding:
      position: 101
      prefix: --no_overlaps
  - id: no_preprocessing
    type:
      - 'null'
      - boolean
    doc: skip preprocessing procedure
    inputBinding:
      position: 101
      prefix: --no_preprocessing
  - id: original_fastq
    type:
      - 'null'
      - File
    doc: original fastq file before splitting
    inputBinding:
      position: 101
      prefix: --original_fastq
  - id: original_pe_count
    type:
      - 'null'
      - int
    doc: number of paired-end sequences in input before splitting
    inputBinding:
      position: 101
      prefix: --original_PE_count
  - id: original_se_count
    type:
      - 'null'
      - int
    doc: number of single-end sequences in input before splitting
    inputBinding:
      position: 101
      prefix: --original_SE_count
  - id: paired_end_reads_1
    type:
      - 'null'
      - File
    doc: path to input fastq containing paired-end reads (/1)
    inputBinding:
      position: 101
      prefix: --p1
  - id: paired_end_reads_2
    type:
      - 'null'
      - File
    doc: path to input fastq containing paired-end reads (/2)
    inputBinding:
      position: 101
      prefix: --p2
  - id: ref_guided_mode
    type:
      - 'null'
      - boolean
    doc: perform reference-guided assembly
    inputBinding:
      position: 101
      prefix: --ref_guided_mode
  - id: reference
    type:
      - 'null'
      - File
    doc: reference genome in fasta format
    inputBinding:
      position: 101
      prefix: --ref
  - id: sfo_err
    type:
      - 'null'
      - float
    doc: 'input parameter for sfo: maximal mismatch rate'
    inputBinding:
      position: 101
      prefix: --sfo_err
  - id: single_end_reads
    type:
      - 'null'
      - File
    doc: path to input fastq containing single-end reads
    inputBinding:
      position: 101
      prefix: --s
  - id: stddev
    type: float
    doc: standard deviation of insert size for paired-end input
    inputBinding:
      position: 101
      prefix: --stddev
  - id: threads
    type:
      - 'null'
      - int
    doc: allowed number of cores
    inputBinding:
      position: 101
      prefix: --num_threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploconduct:0.2.1--py27h78a066a_0
stdout: haploconduct_polyte.out
