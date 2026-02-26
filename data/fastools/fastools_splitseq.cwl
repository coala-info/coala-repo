cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools splitseq
label: fastools_splitseq
doc: "Split a FASTA/FASTQ file based on containing part of the sequence\n\nTool homepage:
  https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: output
    type: File
    doc: output files
    inputBinding:
      position: 2
  - id: seq
    type: string
    doc: a sequence (str)
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_splitseq.out
