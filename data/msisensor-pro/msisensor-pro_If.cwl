cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor-pro
label: msisensor-pro_If
doc: "Microsatellite Instability (MSI) detection using high-throughput sequencing
  data. (Support tumor-normal paired samples and tumor-only samples)\n\nTool homepage:
  https://github.com/xjtu-omics/msisensor-pro"
inputs:
  - id: command
    type: string
    doc: Command to execute (scan, msi, baseline, pro)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the selected command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
stdout: msisensor-pro_If.out
