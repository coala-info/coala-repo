cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmap-fusion_GMAP-fusion
label: gmap-fusion_GMAP-fusion
doc: "GMAP-Fusion is a tool for detecting gene fusions from RNA-Seq data.\n\nTool
  homepage: https://github.com/GMAP-fusion/GMAP-fusion"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: number threads for GMAP
    default: 4
    inputBinding:
      position: 101
      prefix: --CPU
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: E-value threshold for blast searches
    default: 0.001
    inputBinding:
      position: 101
      prefix: -E
  - id: genome_lib_dir
    type: Directory
    doc: directory containing genome lib (see http://FusionFilter.github.io for 
      details)
    inputBinding:
      position: 101
      prefix: --genome_lib_dir
  - id: left_fq
    type: File
    doc: Illumina paired-end reads /1
    inputBinding:
      position: 101
      prefix: --left_fq
  - id: max_fuzzy_overlap
    type:
      - 'null'
      - int
    doc: maximum allowed overlap of extended length from breakpoint
    default: 12
    inputBinding:
      position: 101
      prefix: --max_fuzzy_overlap
  - id: max_promiscuity
    type:
      - 'null'
      - int
    doc: maximum number of partners allowed for a given fusion.
    default: 3
    inputBinding:
      position: 101
      prefix: --max_promiscuity
  - id: min_chim_len
    type:
      - 'null'
      - int
    doc: minimum length for a chimeric alignment
    default: 30
    inputBinding:
      position: 101
      prefix: --min_chim_len
  - id: min_j
    type:
      - 'null'
      - int
    doc: minimum number of junction frags
    default: 1
    inputBinding:
      position: 101
      prefix: --min_J
  - id: min_novel_junction_support
    type:
      - 'null'
      - int
    doc: minimum number of junction reads required for novel (non-reference) 
      exon-exon junction support.
    default: 3
    inputBinding:
      position: 101
      prefix: --min_novel_junction_support
  - id: min_sumjs
    type:
      - 'null'
      - int
    doc: minimum sum (junction + spanning) frags
    default: 2
    inputBinding:
      position: 101
      prefix: --min_sumJS
  - id: output
    type:
      - 'null'
      - string
    doc: output directory name
    default: GMAP_Fusion
    inputBinding:
      position: 101
      prefix: --output
  - id: right_fq
    type: File
    doc: Illumina paired-end reads /2
    inputBinding:
      position: 101
      prefix: --right_fq
  - id: split_breakpoint_extend_length
    type:
      - 'null'
      - int
    doc: in assessing breakpoint quality, the length to extend each split 
      sequence beyond the proposed breakpoint.
    default: 25
    inputBinding:
      position: 101
      prefix: --split_breakpoint_extend_length
  - id: transcripts
    type: string
    doc: transcript fasta file
    inputBinding:
      position: 101
      prefix: --transcripts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmap-fusion:0.4.0--hdfd78af_3
stdout: gmap-fusion_GMAP-fusion.out
