cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplogrep3
  - build-tree
label: haplogrep3_build-tree
doc: "Build a haplogrep phylotree XML file from a Nextstrain tree.json file.\n\nTool homepage: https://github.com/genepi/haplogrep3"
inputs:
  - id: input
    type: File
    doc: "input nextstrain tree.json file"
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: "output haplogrep xml file"
    inputBinding:
      position: 101
      prefix: --output
  - id: output_weights
    type: string
    doc: "output haplogrep xml file"
    inputBinding:
      position: 101
      prefix: --output-weights
  - id: voc
    type: File
    doc: "variants of concerns"
    inputBinding:
      position: 101
      prefix: --voc
outputs:
  - id: tree_xml
    type: File
    doc: "Haplogrep phylotree XML file"
    outputBinding:
      glob: $(inputs.output)
  - id: weights_xml
    type: File
    doc: "Haplogrep weights XML file"
    outputBinding:
      glob: $(inputs.output_weights)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
