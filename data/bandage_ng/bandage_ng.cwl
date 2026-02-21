cwlVersion: v1.2
class: CommandLineTool
baseCommand: bandage_ng
label: bandage_ng
doc: "Bandage (Bioinformatics Application for Navigating De novo Assembly Graphs Easily)
  - Next Generation. Note: The provided text contains container runtime error logs
  rather than tool help text, so no arguments could be extracted.\n\nTool homepage:
  https://github.com/asl/BandageNG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage_ng:2026.2.1--h3751afb_0
stdout: bandage_ng.out
