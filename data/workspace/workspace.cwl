cwlVersion: v1.2
class: CommandLineTool
baseCommand: workspace
label: workspace
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it appears to be an error log from a container build process.\n
  \nTool homepage: https://github.com/AppFlowy-IO/AppFlowy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/workspace:0.3.1--py36_2
stdout: workspace.out
