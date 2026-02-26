cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor varcount
label: surpyvor_varcount
doc: "VCF to plot from\n\nTool homepage: https://github.com/wdecoster/surpyvor"
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
outputs:
  - id: plotout
    type:
      - 'null'
      - File
    doc: output file to write figure to
    outputBinding:
      glob: $(inputs.plotout)
  - id: countsout
    type:
      - 'null'
      - File
    doc: output file to write counts to
    outputBinding:
      glob: $(inputs.countsout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
