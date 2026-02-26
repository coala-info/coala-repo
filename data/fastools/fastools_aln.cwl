cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - aln
label: fastools_aln
doc: "Calculate the Levenshtein distance between two FASTA files.\n\nTool homepage:
  https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: input files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_aln.out
