cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplogrep3
  - distance
label: haplogrep3_distance
doc: "Calculate the distance between the haplogroups of two classification files.\n\nTool homepage: https://github.com/genepi/haplogrep3"
inputs:
  - id: file1
    type: File
    doc: "input haplogroups"
    inputBinding:
      position: 101
      prefix: --file1
  - id: file2
    type: File
    doc: "input haplogroups"
    inputBinding:
      position: 101
      prefix: --file2
  - id: output
    type: string
    doc: "output haplogroups including distance"
    inputBinding:
      position: 101
      prefix: --output
  - id: tree
    type: string
    doc: "Tree Id"
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: distances
    type: File
    doc: "Haplogroups including distance"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
