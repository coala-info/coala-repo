cwlVersion: v1.2
class: CommandLineTool
baseCommand: coils
label: coils
doc: "The provided text contains system error messages related to a container runtime
  failure (no space left on device) and does not contain help documentation for the
  'coils' tool. As a result, no arguments could be parsed.\n\nTool homepage: https://rostlab.org/owiki/index.php/Packages#Package_overview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coils:2.2.1--h7b50bb2_5
stdout: coils.out
