cwlVersion: v1.2
class: CommandLineTool
baseCommand: crussmap_bed
label: crussmap_bed
doc: "Converts BED file. Regions mapped to multiple locations to the new assembly
  will be split\n\nTool homepage: https://github.com/wjwei-handsome/crussmap"
inputs:
  - id: bed
    type: File
    doc: bed file path
    inputBinding:
      position: 101
      prefix: --bed
  - id: input
    type:
      - 'null'
      - File
    doc: input chain file path
    inputBinding:
      position: 101
      prefix: --input
  - id: rewrite
    type:
      - 'null'
      - boolean
    doc: rewrite output file, default is false
    inputBinding:
      position: 101
      prefix: --rewrite
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
  - id: unmap_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `unmap_path`
    inputBinding:
      position: 103
      prefix: --unmap
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output bed file path, if not set, output to STDOUT
    outputBinding:
      glob: $(inputs.output_path)
  - id: unmap
    type:
      - 'null'
      - File
    doc: unmapped bed file path, if not set, output to STDOUT
    outputBinding:
      glob: $(inputs.unmap_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crussmap:1.0.1--h5c46d4b_0
