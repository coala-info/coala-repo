cwlVersion: v1.2
class: CommandLineTool
baseCommand: kofamscan
label: kofamscan_exec_annotation
doc: "KofamScan is a tool for gene function annotation by Kofam (KEGG Ortholog assignments).
  Note: The provided text contains error logs rather than help documentation, so no
  arguments could be extracted.\n\nTool homepage: https://www.genome.jp/tools/kofamkoala/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kofamscan:1.3.0--1
stdout: kofamscan_exec_annotation.out
