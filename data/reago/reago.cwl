cwlVersion: v1.2
class: CommandLineTool
baseCommand: reago
label: reago
doc: "Reconstruction of 16S ribosomal RNA genes from metagenomic data (Note: The provided
  help text contains only environment logs and a fatal error, no usage information
  was available).\n\nTool homepage: https://github.com/chengyuan/reago-1.1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reago:1.1--py35_0
stdout: reago.out
