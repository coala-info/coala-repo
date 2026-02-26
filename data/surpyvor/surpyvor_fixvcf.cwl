cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor_fixvcf
label: surpyvor_fixvcf
doc: "Fix problems related to using jasmine\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: vcf
    type: File
    doc: vcf file to parse
    inputBinding:
      position: 1
  - id: fai
    type: File
    doc: index of corresponding fasta file
    inputBinding:
      position: 102
      prefix: --fai
  - id: jasmine
    type:
      - 'null'
      - boolean
    doc: Fix problems related to using jasmine
    inputBinding:
      position: 102
      prefix: --jasmine
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
