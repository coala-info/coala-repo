cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - segul
  - maf
label: segul_maf
doc: "Multi alignment format (MAF) analyses and conversion of genomic files to other
  formats\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (e.g., maf)
    inputBinding:
      position: 1
  - id: log
    type:
      - 'null'
      - File
    doc: Log file path
    inputBinding:
      position: 102
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
stdout: segul_maf.out
