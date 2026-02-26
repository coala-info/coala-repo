cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor lengthplot
label: surpyvor_lengthplot
doc: "Plot variant lengths from a VCF file.\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: vcf
    type: File
    doc: vcf file to parse
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: Plot all variants and not just the first in the file
    inputBinding:
      position: 102
      prefix: --all
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
  - id: counts
    type:
      - 'null'
      - File
    doc: output file to write counts to
    outputBinding:
      glob: $(inputs.counts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
