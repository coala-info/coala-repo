cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tgtools
  - import
  - hmmIBD
label: tgtools_import_hmmIBD
doc: "Convert hmmIBD output to trjson format.\n\nTool homepage: https://github.com/jodyphelan/tgtools"
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
  - id: min_ibd
    type: float
    doc: Minimum IBD value
    inputBinding:
      position: 101
      prefix: --min-ibd
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
