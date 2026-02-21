cwlVersion: v1.2
class: CommandLineTool
baseCommand: workspace_flutter
label: workspace_flutter
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/AppFlowy-IO/AppFlowy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/workspace:0.3.1--py36_2
stdout: workspace_flutter.out
