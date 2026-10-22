cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tgtools
  - import
  - snp-distance
label: tgtools_import_snp-distance
doc: "Convert a snp-dists SNP distance matrix to trjson format.\n\nTool homepage: https://github.com/jodyphelan/tgtools"
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
  - id: max_dist
    type: int
    doc: Maximum snp distance
    inputBinding:
      position: 101
      prefix: --max-dist
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
