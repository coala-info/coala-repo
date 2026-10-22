cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tgtools
  - import
  - transphylo
label: tgtools_import_transphylo
doc: "Convert a TransPhylo transmission probability matrix to trjson format.\n\nTool homepage: https://github.com/jodyphelan/tgtools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --output
  - id: min_probability
    type: float
    doc: Minimum probability for edge
    inputBinding:
      position: 101
      prefix: --min-probability
outputs:
  - id: graph
    type: File
    doc: graph in trjson format
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgtools:0.0.4--pyhdfd78af_0
