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
  - id: output
    type: string
    doc: output file
    inputBinding:
      position: 2
  - id: motif
    type: string
    doc: The sequence to be found
    inputBinding:
      position: 3
outputs:
  - id: out_output
    type: File
    doc: output file
    outputBinding:
      glob: '$(inputs.output)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
