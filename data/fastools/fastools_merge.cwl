cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools_merge
label: fastools_merge
doc: "Merge two FASTA files.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: input files
    inputBinding:
      position: 1
  - id: fill
    type:
      - 'null'
      - int
    doc: Add 'N's between the reads
    inputBinding:
      position: 102
      prefix: --fill
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
