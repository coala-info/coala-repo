cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - gbfiletool
  - comrev
label: mitoz_tools_gbfiletool_comrev
doc: "Get the complement reverse of GenBank records.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
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
