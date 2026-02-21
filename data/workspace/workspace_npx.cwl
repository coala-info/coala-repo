cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - workspace
  - npx
label: workspace_npx
doc: "A tool for workspace management (Note: The provided text appears to be a build
  log rather than help text, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/AppFlowy-IO/AppFlowy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/workspace:0.3.1--py36_2
stdout: workspace_npx.out
