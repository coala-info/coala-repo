cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbbarcode
label: pbbarcode
doc: "The provided text is a Python ImportError traceback and does not contain help
  text or usage information for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/mlbendall/pbbarcode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbbarcode:v0.8.0-5-deb_cv1
stdout: pbbarcode.out
