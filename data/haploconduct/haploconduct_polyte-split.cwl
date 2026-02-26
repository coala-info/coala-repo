cwlVersion: v1.2
class: CommandLineTool
baseCommand: polyte-split.py
label: haploconduct_polyte-split
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
    doc: min_overlap_len used in diploid assembly step
    inputBinding:
      position: 101
      prefix: --diploid_overlap_len
  - id: hap_cov
    type: float
    doc: average coverage per haplotype
    inputBinding:
      position: 101
      prefix: --hap_cov
  - id: input_p1
    type:
      - 'null'
      - File
    doc: path to input fastq containing paired-end reads (/1)
    inputBinding:
      position: 101
      prefix: --input_p1
  - id: input_p2
    type:
      - 'null'
      - File
    doc: path to input fastq containing paired-end reads (/2)
    inputBinding:
      position: 101
      prefix: --input_p2
  - id: input_s
    type:
      - 'null'
      - File
    doc: path to input fastq containing single-end reads
    inputBinding:
      position: 101
      prefix: --input_s
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
  - id: pool_size
    type:
      - 'null'
      - int
    doc: number of regions to be processed in parallel
    inputBinding:
      position: 101
      prefix: --pool_size
  - id: reference
    type: File
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
  - id: sfo_threads
    type:
      - 'null'
      - int
    doc: number of threads used per region
    inputBinding:
      position: 101
      prefix: --sfo_threads
  - id: split_only
    type:
      - 'null'
      - boolean
    doc: don't do assembly, only data splitting
    inputBinding:
      position: 101
      prefix: --split_only
  - id: split_overlap
    type:
      - 'null'
      - int
    doc: size of overlap between regions over which the reads are divided
    inputBinding:
      position: 101
      prefix: --split_overlap
  - id: split_size
    type:
      - 'null'
      - int
    doc: size of regions over which the reads are divided
    inputBinding:
      position: 101
      prefix: --split_size
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
stdout: haploconduct_polyte-split.out
