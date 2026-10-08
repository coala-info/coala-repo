cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmlrc2-convert
label: fmlrc2_convert
doc: "FMLRC2 BWT converter: convert a raw (plain text) BWT of short reads into the
  compressed multi-string BWT (.npy) used by fmlrc2.\n\nTool homepage: https://github.com/HudsonAlpha/fmlrc2"
inputs:
  - id: comp_msbwt_path
    type: string
    doc: The location to store the compressed BWT
    inputBinding:
      position: 2
  - id: input_bwt
    type: File
    doc: The raw BWT
    inputBinding:
      position: 1
      prefix: --input
outputs:
  - id: comp_msbwt
    type: File
    doc: Compressed multi-string BWT (.npy)
    outputBinding:
      glob: $(inputs.comp_msbwt_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmlrc2:0.1.8--h7f95895_0
