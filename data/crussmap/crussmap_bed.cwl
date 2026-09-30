cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crussmap
  - bed
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
    doc: output bed file path, if not set, output to STDOUT
    inputBinding:
      position: 102
      prefix: --output
  - id: unmap_path
    type:
      - 'null'
      - string
    doc: unmapped bed file path, if not set, output to STDOUT
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
