cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools_tagcount
label: fastools_tagcount
doc: "Count tags in a FASTA file.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
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
  - id: mismatches
    type:
      - 'null'
      - int
    doc: amount of mismatches allowed
    default: 2
    inputBinding:
      position: 103
      prefix: --mismatches
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_tagcount.out
