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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: vcf file to write to
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
