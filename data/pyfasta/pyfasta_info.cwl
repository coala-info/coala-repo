cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfasta_info
label: pyfasta_info
doc: "Print headers and lengths of the given fasta file in order of length.\n\nTool
  homepage: https://github.com/brentp/pyfasta"
inputs:
  - id: input_fasta
    type: File
    doc: The fasta file to process
    inputBinding:
      position: 1
  - id: max_records
    type:
      - 'null'
      - int
    doc: max number of records to print. use -1 for all
    inputBinding:
      position: 102
      prefix: --n
  - id: show_gc
    type:
      - 'null'
      - boolean
    doc: show gc content
    inputBinding:
      position: 102
      prefix: --gc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
stdout: pyfasta_info.out
