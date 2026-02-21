cwlVersion: v1.2
class: CommandLineTool
baseCommand: bash5tools.py
label: pbh5tools_bash5tools.py
doc: "Tool for extracting data from .bas.h5 files\n\nTool homepage: https://github.com/zkennedy/pbh5tools"
inputs:
  - id: input_file
    type: File
    doc: input .bas.h5 filename
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Catch exceptions in debugger (requires ipdb)
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: min_length
    type:
      - 'null'
      - int
    doc: min read length
    default: 0
    inputBinding:
      position: 102
      prefix: --minLength
  - id: min_passes
    type:
      - 'null'
      - int
    doc: min number of CCS passes, valid only with --readType=ccs
    default: 0
    inputBinding:
      position: 102
      prefix: --minPasses
  - id: min_read_score
    type:
      - 'null'
      - int
    doc: min read score, valid only with --readType={unrolled,subreads}
    default: 0
    inputBinding:
      position: 102
      prefix: --minReadScore
  - id: out_type
    type:
      - 'null'
      - string
    doc: output file type (fasta, fastq)
    default: fasta
    inputBinding:
      position: 102
      prefix: --outType
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Print runtime profile at exit
    default: false
    inputBinding:
      position: 102
      prefix: --profile
  - id: read_type
    type:
      - 'null'
      - string
    doc: read type (ccs, subreads, or unrolled)
    inputBinding:
      position: 102
      prefix: --readType
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set the verbosity level
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: out_file_prefix
    type:
      - 'null'
      - File
    doc: output filename prefix
    outputBinding:
      glob: $(inputs.out_file_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
