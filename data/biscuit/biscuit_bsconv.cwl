cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - bsconv
label: biscuit_bsconv
doc: "Filter and convert bisulfite sequencing reads based on CpH retention and other
  criteria.\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference genome in FASTA format
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 2
  - id: filter_unclear_strand
    type:
      - 'null'
      - boolean
    doc: Filter unclear bs-strand (YD:u) reads
    inputBinding:
      position: 103
      prefix: -u
  - id: max_cpa_retention
    type:
      - 'null'
      - int
    doc: 'Filter: maximum CpA retention'
    inputBinding:
      position: 103
      prefix: -a
  - id: max_cpc_retention
    type:
      - 'null'
      - int
    doc: 'Filter: maximum CpC retention'
    inputBinding:
      position: 103
      prefix: -c
  - id: max_cph_retention
    type:
      - 'null'
      - int
    doc: 'Filter: maximum CpH retention'
    inputBinding:
      position: 103
      prefix: -m
  - id: max_cph_retention_fraction
    type:
      - 'null'
      - float
    doc: 'Filter: maximum CpH retention fraction'
    default: 1.0
    inputBinding:
      position: 103
      prefix: -f
  - id: max_cpt_retention
    type:
      - 'null'
      - int
    doc: 'Filter: maximum CpT retention'
    inputBinding:
      position: 103
      prefix: -t
  - id: max_cpy_retention
    type:
      - 'null'
      - int
    doc: 'Filter: maximum CpY retention'
    inputBinding:
      position: 103
      prefix: -x
  - id: max_cpy_retention_fraction
    type:
      - 'null'
      - float
    doc: 'Filter: maximum CpY retention fraction'
    default: 1.0
    inputBinding:
      position: 103
      prefix: -y
  - id: region
    type:
      - 'null'
      - string
    doc: Region (optional, will process the whole bam if not specified)
    inputBinding:
      position: 103
      prefix: -g
  - id: show_filtered_reads
    type:
      - 'null'
      - boolean
    doc: Show filtered reads instead of remaining reads
    inputBinding:
      position: 103
      prefix: -v
  - id: tab_separated_format
    type:
      - 'null'
      - boolean
    doc: 'Print in tab-separated format, print order: CpA_R, CpA_C, CpC_R, CpC_C,
      CpG_R, CpG_C, CpT_R, CpT_C'
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Output BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
