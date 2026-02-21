cwlVersion: v1.2
class: CommandLineTool
baseCommand: workspace_cargo
label: workspace_cargo
doc: "The provided text contains container runtime logs and error messages rather
  than command-line help documentation. No arguments or usage information could be
  extracted.\n\nTool homepage: https://github.com/AppFlowy-IO/AppFlowy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/workspace:0.3.1--py36_2
stdout: workspace_cargo.out
