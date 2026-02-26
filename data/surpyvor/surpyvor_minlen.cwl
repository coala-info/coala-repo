cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - surpyvor
  - minlen
label: surpyvor_minlen
doc: "Filter SVs by minimum length\n\nTool homepage: https://github.com/wdecoster/surpyvor"
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
    doc: minimal SV length
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
