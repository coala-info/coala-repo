cwlVersion: v1.2
class: CommandLineTool
baseCommand: recontig make-mapping
label: recontig_make-mapping
doc: "make a contig conversion file from two fasta files\n\nTool homepage: https://github.com/blachlylab/recontig"
inputs:
  - id: from_fa
    type: File
    doc: First FASTA file
    inputBinding:
      position: 1
  - id: to_fa
    type: File
    doc: Second FASTA file
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print extra debug information
    inputBinding:
      position: 103
      prefix: --debug
  - id: no_enforce_md5sums
    type:
      - 'null'
      - boolean
    doc: contigs mapping may be output to mapping file even if md5sums do not 
      match
    inputBinding:
      position: 103
      prefix: --no-enforce-md5sums
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: silence warnings
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print extra information
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: name of file out
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recontig:1.5.0--h9ee0642_0
