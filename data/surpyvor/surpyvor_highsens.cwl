cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - surpyvor
  - highsens
label: surpyvor_highsens
doc: "Merge variants from multiple VCF files.\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: variants
    type:
      type: array
      items: File
    doc: vcf files to merge
    inputBinding:
      position: 1
  - id: distance
    type:
      - 'null'
      - int
    doc: distance between variants to merge
    inputBinding:
      position: 102
      prefix: --distance
  - id: minlength
    type:
      - 'null'
      - int
    doc: Minimum length of variants to consider
    inputBinding:
      position: 102
      prefix: --minlength
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
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
