cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - segul
  - partition
label: segul_partition
doc: "Alignment partition conversion\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: command
    type: string
    doc: Subcommand to execute (convert, help)
    inputBinding:
      position: 1
  - id: log_path
    type: string
    doc: Output or path parameter `log_path`
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Log file path
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
