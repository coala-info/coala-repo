cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - surpyvor
  - svlentruncate
label: surpyvor_svlentruncate
doc: "Truncates SVLEN in VCF files.\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: vcf
    type: File
    doc: vcf file to parse
    inputBinding:
      position: 1
  - id: length
    type:
      - 'null'
      - int
    doc: maximal SVLEN, replace SVLEN by this value if larger
    inputBinding:
      position: 102
      prefix: --length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out more information while running.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: vcf file to write to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
