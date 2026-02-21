cwlVersion: v1.2
class: CommandLineTool
baseCommand: maskrc-svg.py
label: maskrc-svg_maskrc-svg.py
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding disk space.\n\nTool homepage: https://github.com/kwongj/maskrc-svg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maskrc-svg:0.5--0
stdout: maskrc-svg_maskrc-svg.py.out
