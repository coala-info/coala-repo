cwlVersion: v1.2
class: CommandLineTool
baseCommand: simpleitk
label: simpleitk
doc: "SimpleITK is a simplified programming interface to the algorithms and data structures
  of the Insight Segmentation and Registration Toolkit (ITK). Note: The provided text
  contains system error messages regarding disk space and container image retrieval
  rather than tool usage instructions.\n\nTool homepage: https://github.com/SimpleITK/SimpleITK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/simpleitk:v1.0.1-3-deb-py3_cv1
stdout: simpleitk.out
