cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - run-help
label: apptainer_run-help
doc: "Show the user-defined help for an image\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: image_path
    type: File
    doc: Path to the image
    inputBinding:
      position: 1
  - id: app
    type:
      - 'null'
      - string
    doc: show the help for an app
    inputBinding:
      position: 102
      prefix: --app
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_run-help.out
