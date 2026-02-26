cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools_add
label: fastools_add
doc: "Add a sequence to the 5' end of each read in a FASTQ file.\n\nTool homepage:
  https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: seq
    type: string
    doc: a sequence (str)
    inputBinding:
      position: 2
  - id: quality
    type:
      - 'null'
      - int
    doc: quality score
    default: 40
    inputBinding:
      position: 103
      prefix: -q
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
