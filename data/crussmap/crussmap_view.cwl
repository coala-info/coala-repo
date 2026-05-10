cwlVersion: v1.2
class: CommandLineTool
baseCommand: crussmap_view
label: crussmap_view
doc: "View chain file in tsv/csv format\n\nTool homepage: https://github.com/wjwei-handsome/crussmap"
inputs:
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Output in csv format, default is false
    inputBinding:
      position: 101
      prefix: --csv
  - id: input
    type:
      - 'null'
      - File
    doc: 'Input chain file: *.chain/*.chain.gz supported; if not set, read from STDIN'
    inputBinding:
      position: 101
      prefix: --input
  - id: rewrite
    type:
      - 'null'
      - boolean
    doc: Rewrite output file, default is false
    inputBinding:
      position: 101
      prefix: --rewrite
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path, if not set, output to STDOUT
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crussmap:1.0.1--h5c46d4b_0
