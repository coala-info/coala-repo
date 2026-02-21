cwlVersion: v1.2
class: CommandLineTool
baseCommand: curves
label: curves
doc: "The provided text does not contain help information for the tool 'curves'. It
  contains system error logs related to a failed container build (no space left on
  device).\n\nTool homepage: https://bisi.ibcp.fr/tools/curves_plus/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curves:3.0.3--h70c14e6_1
stdout: curves.out
