cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - famotif2bed
label: fastools_famotif2bed
doc: "Find a given sequence in a FASTA file and write the results to a Bed file.\n\
  \nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: motif
    type: string
    doc: The sequence to be found
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
