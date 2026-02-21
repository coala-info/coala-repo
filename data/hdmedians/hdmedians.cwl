cwlVersion: v1.2
class: CommandLineTool
baseCommand: hdmedians
label: hdmedians
doc: "High-dimensional medians (Note: The provided text is a container execution error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/daleroberts/hdmedians"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hdmedians:v0.13git20171027.8e0e9e3-1-deb-py3_cv1
stdout: hdmedians.out
