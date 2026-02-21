cwlVersion: v1.2
class: CommandLineTool
baseCommand: recon
label: recon
doc: "RECON is a tool for automated identification of repeat families from genomic
  sequences.\n\nTool homepage: https://github.com/six2dez/reconftw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recon:1.08--h7b50bb2_9
stdout: recon.out
