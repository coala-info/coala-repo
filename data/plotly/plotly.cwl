cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotly
label: plotly
doc: "The provided text is a system log showing a failed container build for Plotly
  and does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://github.com/plotly/plotly.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plotly:3.1.1
stdout: plotly.out
