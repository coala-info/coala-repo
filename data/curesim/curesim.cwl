cwlVersion: v1.2
class: CommandLineTool
baseCommand: curesim
label: curesim
doc: "A tool for simulating genomic reads (Note: The provided help text contains system
  error logs and does not list specific command-line arguments).\n\nTool homepage:
  https://github.com/BenKearns/CureSim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curesim:1.3--0
stdout: curesim.out
