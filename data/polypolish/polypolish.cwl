cwlVersion: v1.2
class: CommandLineTool
baseCommand: polypolish
label: polypolish
doc: "Polypolish is a tool for polishing genome assemblies with short reads. It uses
  all-mapping short-read alignments to repair errors in a long-read assembly.\n\n\
  Tool homepage: https://github.com/rrwick/Polypolish"
inputs:
  - id: assembly
    type: File
    doc: The genome assembly to be polished (FASTA format)
    inputBinding:
      position: 1
  - id: sam_files
    type:
      type: array
      items: File
    doc: SAM files of short reads aligned to the assembly
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug information to stderr
    inputBinding:
      position: 103
      prefix: --debug
  - id: fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction of reads that must agree on a variant
    inputBinding:
      position: 103
      prefix: --fraction
  - id: max_i
    type:
      - 'null'
      - float
    doc: Maximum mismatch/indel rate for a read to be used for polishing
    inputBinding:
      position: 103
      prefix: --max_i
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum read depth for polishing; positions with fewer reads will not 
      be polished
    inputBinding:
      position: 103
      prefix: --min_count
  - id: v_max
    type:
      - 'null'
      - float
    doc: Maximum variant frequency; if the most common variant is above this 
      threshold, it will be used to polish
    inputBinding:
      position: 103
      prefix: --v_max
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polypolish:0.6.1--h3ab6199_0
stdout: polypolish.out
