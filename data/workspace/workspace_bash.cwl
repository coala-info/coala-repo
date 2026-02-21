cwlVersion: v1.2
class: CommandLineTool
baseCommand: workspace_bash
label: workspace_bash
doc: "A tool for workspace management (Note: The provided text appears to be a log
  of a failed build process rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/AppFlowy-IO/AppFlowy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/workspace:0.3.1--py36_2
stdout: workspace_bash.out
