cwlVersion: v1.2
class: CommandLineTool
baseCommand: syny_minimap2
label: syny_minimap2
doc: "The provided text contains system logs and a fatal error message regarding a
  container build process rather than the tool's help documentation. As a result,
  no functional description or arguments could be extracted.\n\nTool homepage: https://github.com/PombertLab/SYNY"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syny:1.3.1--py312pl5321h7e72e81_0
stdout: syny_minimap2.out
