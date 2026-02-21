cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualifilter
label: qualifilter
doc: "A tool for filtering sequencing reads based on quality scores (Note: The provided
  text is an error log and does not contain usage information).\n\nTool homepage:
  https://github.com/buhlentozini/QualiFilter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualifilter:1.0.0--pyh7e72e81_0
stdout: qualifilter.out
