cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - gbfiletool
  - sort
label: mitoz_tools_gbfiletool_sort
doc: "Sort the gene order of circular GenBank records so that a chosen gene comes first (input should all be circular records).\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: input_genbank
    type: File
    doc: "genbank input file"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_genbank
    type: string
    doc: "genbank out file"
    inputBinding:
      position: 2
      prefix: -o
  - id: first_gene
    type: string
    doc: "the first gene in output"
    inputBinding:
      position: 3
      prefix: -g
outputs:
  - id: genbank_out
    type: File
    doc: "Output GenBank file."
    outputBinding:
      glob: $(inputs.output_genbank)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
