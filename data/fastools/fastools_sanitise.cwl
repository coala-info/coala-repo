cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - sanitise
label: fastools_sanitise
doc: "Convert a FASTA/FASTQ file to a standard FASTA/FASTQ file.\n\nTool homepage:
  https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
