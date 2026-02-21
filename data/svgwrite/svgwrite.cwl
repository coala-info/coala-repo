cwlVersion: v1.2
class: CommandLineTool
baseCommand: svgwrite
label: svgwrite
doc: "A Python library/tool to create SVG drawings. (Note: The provided text contains
  error logs from a container build process rather than CLI help text; no arguments
  could be extracted.)\n\nTool homepage: https://github.com/mozman/svgwrite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svgwrite:1.1.6--py35_0
stdout: svgwrite.out
