cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor
label: msisensor
doc: "homopolymer and miscrosatelite analysis using bam files\n\nTool homepage: https://github.com/ding-lab/msisensor"
inputs:
  - id: command
    type: string
    doc: 'Key commands: scan, msi'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Command-specific options
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor:0.5--hc755212_3
stdout: msisensor.out
