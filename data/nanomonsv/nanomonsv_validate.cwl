cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomonsv validate
label: nanomonsv_validate
doc: "Validate SV calls using BAM files and reference genome.\n\nTool homepage: https://github.com/friend1ws/nanomonsv"
inputs:
  - id: sv_list_file
    type: File
    doc: Path to GenomonSV format SV list file
    inputBinding:
      position: 1
  - id: tumor_bam
    type: File
    doc: Path to tumor BAM file
    inputBinding:
      position: 2
  - id: reference_fa
    type: File
    doc: Path to the reference genome sequence
    inputBinding:
      position: 3
  - id: control_bam
    type:
      - 'null'
      - File
    doc: Path to control BAM file
    inputBinding:
      position: 104
      prefix: --control_bam
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 104
      prefix: --debug
  - id: qv10
    type:
      - 'null'
      - boolean
    doc: Parameter preset for sequencing data with a base quality of around 10. 
      Recommended for ONT data called by Guppy before version 5
    inputBinding:
      position: 104
      prefix: --qv10
  - id: qv15
    type:
      - 'null'
      - boolean
    doc: Parameter preset for sequencing data with a base quality of around 15. 
      Recommended for ONT data called by Guppy version 5, 6.
    inputBinding:
      position: 104
      prefix: --qv15
  - id: qv20
    type:
      - 'null'
      - boolean
    doc: Parameter preset for sequencing data with a base quality of around 20. 
      Recommended for ONT data with Q20+ chemistry.
    inputBinding:
      position: 104
      prefix: --qv20
  - id: qv25
    type:
      - 'null'
      - boolean
    doc: Parameter preset for sequencing data with a base quality above 25. 
      Recommended for PacBio Hifi data.
    inputBinding:
      position: 104
      prefix: --qv25
  - id: sort_option
    type:
      - 'null'
      - string
    doc: options for sort command
    default: 1G
    inputBinding:
      position: 104
      prefix: --sort_option
  - id: validation_score_ratio_thres
    type:
      - 'null'
      - float
    doc: Threshould for threshould for SV segment validation by alignment
    inputBinding:
      position: 104
      prefix: --validation_score_ratio_thres
  - id: var_read_min_mapq
    type:
      - 'null'
      - int
    doc: Threshould for mapping quality in validate step
    inputBinding:
      position: 104
      prefix: --var_read_min_mapq
outputs:
  - id: output
    type: File
    doc: Path to output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomonsv:0.8.1--pyhdfd78af_0
