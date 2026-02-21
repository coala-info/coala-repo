cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - overlay
label: apptainer_overlay
doc: "The overlay command allows management of EXT3 writable overlay images.\n\nTool
  homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (e.g., create)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_overlay.out
