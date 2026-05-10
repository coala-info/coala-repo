cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor_carrierplot
label: surpyvor_carrierplot
doc: "Plot carrier plots from VCF files.\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: variants
    type: File
    doc: VCF to plot from
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out more information while running.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: plotout_path
    type: string
    doc: Output or path parameter `plotout_path`
    inputBinding:
      position: 103
      prefix: --plotout
outputs:
  - id: plotout
    type:
      - 'null'
      - File
    doc: output file to write figure to
    outputBinding:
      glob: $(inputs.plotout_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
