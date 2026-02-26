cwlVersion: v1.2
class: CommandLineTool
baseCommand: remove_tail.py
label: bctools_remove_tail.py
doc: "Remove a certain number of nucleotides from the 3'-tails of sequences in FASTQ
  format.\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs:
  - id: infile
    type: File
    doc: Path to fastq file.
    inputBinding:
      position: 1
  - id: length
    type: int
    doc: Remove this many nts.
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print lots of debugging information
    inputBinding:
      position: 103
      prefix: --debug
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write results to this file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
