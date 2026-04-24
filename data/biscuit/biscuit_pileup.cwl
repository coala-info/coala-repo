cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - pileup
label: biscuit_pileup
doc: "Pileup tool for DNA methylation and genetic variant calling from bisulfite sequencing
  data.\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: reference
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 1
  - id: input_bams
    type:
      type: array
      items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 2
  - id: contamination_rate
    type:
      - 'null'
      - float
    doc: Contamination rate
    inputBinding:
      position: 103
      prefix: -C
  - id: double_count_cytosines
    type:
      - 'null'
      - boolean
    doc: Double count cytosines in overlapping mate reads (avoided by default)
    inputBinding:
      position: 103
      prefix: -d
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error rate
    inputBinding:
      position: 103
      prefix: -E
  - id: max_cytosine_retention
    type:
      - 'null'
      - int
    doc: Maximum cytosine retention in a read
    inputBinding:
      position: 103
      prefix: -t
  - id: max_nm_tag
    type:
      - 'null'
      - int
    doc: Maximum NM tag
    inputBinding:
      position: 103
      prefix: -n
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: Minimum alignment score (from AS-tag)
    inputBinding:
      position: 103
      prefix: -a
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality
    inputBinding:
      position: 103
      prefix: -b
  - id: min_dist_3prime
    type:
      - 'null'
      - int
    doc: Minimum distance to 3' end of a read
    inputBinding:
      position: 103
      prefix: '-3'
  - id: min_dist_5prime
    type:
      - 'null'
      - int
    doc: Minimum distance to 5' end of a read
    inputBinding:
      position: 103
      prefix: '-5'
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 103
      prefix: -m
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    inputBinding:
      position: 103
      prefix: -l
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Mutation rate
    inputBinding:
      position: 103
      prefix: -M
  - id: no_filter_duplicates
    type:
      - 'null'
      - boolean
    doc: NO filtering of duplicate flagged reads
    inputBinding:
      position: 103
      prefix: -u
  - id: no_filter_improper_pairs
    type:
      - 'null'
      - boolean
    doc: NO filtering of improper pair flagged reads
    inputBinding:
      position: 103
      prefix: -p
  - id: no_filter_secondary
    type:
      - 'null'
      - boolean
    doc: NO filtering secondary mapping
    inputBinding:
      position: 103
      prefix: -c
  - id: no_redistribution
    type:
      - 'null'
      - boolean
    doc: NO redistribution of ambiguous (Y/R) calls in SNP genotyping
    inputBinding:
      position: 103
      prefix: -r
  - id: nome_seq_mode
    type:
      - 'null'
      - boolean
    doc: NOMe-seq mode
    inputBinding:
      position: 103
      prefix: -N
  - id: normal_bam
    type:
      - 'null'
      - File
    doc: Somatic mode, normal BAM
    inputBinding:
      position: 103
      prefix: -I
  - id: prior_prob_het
    type:
      - 'null'
      - float
    doc: Prior probability for heterozygous variant
    inputBinding:
      position: 103
      prefix: -P
  - id: prior_prob_hom
    type:
      - 'null'
      - float
    doc: Prior probability for homozygous variant
    inputBinding:
      position: 103
      prefix: -Q
  - id: region
    type:
      - 'null'
      - string
    doc: Region (optional, will process the whole bam if not specified)
    inputBinding:
      position: 103
      prefix: -g
  - id: somatic_mode
    type:
      - 'null'
      - boolean
    doc: Somatic mode, must provide -T and -I arguments
    inputBinding:
      position: 103
      prefix: -S
  - id: somatic_mutation_rate
    type:
      - 'null'
      - float
    doc: Somatic mutation rate
    inputBinding:
      position: 103
      prefix: -x
  - id: stats_prefix
    type:
      - 'null'
      - string
    doc: Pileup statistics output prefix
    inputBinding:
      position: 103
      prefix: -w
  - id: step
    type:
      - 'null'
      - int
    doc: Step of window dispatching
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: -@
  - id: tumor_bam
    type:
      - 'null'
      - File
    doc: Somatic mode, tumor BAM
    inputBinding:
      position: 103
      prefix: -T
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level (0: no added info printed, 0<INT<=5: print diagnostic info,
      INT>5: print diagnostic and debug info)'
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
