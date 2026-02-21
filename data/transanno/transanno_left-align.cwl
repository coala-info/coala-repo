cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transanno
  - left-align
label: transanno_left-align
doc: "Left align and normalize chain file\n\nTool homepage: https://github.com/informationsea/transanno"
inputs:
  - id: original_chain
    type: File
    doc: Original chain file
    inputBinding:
      position: 1
  - id: new
    type: File
    doc: New assembly FASTA (.fai file is required)
    inputBinding:
      position: 102
      prefix: --new
  - id: original
    type: File
    doc: Original assembly FASTA (.fai file is required)
    inputBinding:
      position: 102
      prefix: --original
outputs:
  - id: output
    type: File
    doc: Output chain file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
