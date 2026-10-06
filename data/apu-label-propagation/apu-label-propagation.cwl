cwlVersion: v1.2
class: CommandLineTool
baseCommand: apu-label-propagation
label: apu-label-propagation
doc: "Adaptive Positive-Unlabelled (APU) label propagation on NeDBIT gene 
  features.\n\nUsage: apu-label-propagation fileIn flagHeader fileOut sQuantile 
  rnQuantile\n\nTool homepage: https://github.com/AndMastro/NIAPU"
inputs:
  - id: file_in
    type: File
    doc: Input features file (for example NeDBIT features)
    inputBinding:
      position: 1
  - id: flag_header
    type: string
    doc: 0/1 value indicating the presence of a header in the features file
    inputBinding:
      position: 2
  - id: file_out_path
    type: string
    doc: Name of the output gene ranking file
    inputBinding:
      position: 3
  - id: s_quantile
    type: float
    doc: Quantile threshold for the removal of weak links
    inputBinding:
      position: 4
  - id: rn_quantile
    type: float
    doc: Quantile threshold for the Reliable Negative computation
    inputBinding:
      position: 5
outputs:
  - id: file_out
    type: File
    doc: Output gene ranking with APU labels
    outputBinding:
      glob: $(inputs.file_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apu-label-propagation:1.2--h7b50bb2_3
