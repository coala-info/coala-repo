cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - cache
label: apptainer_cache
doc: "Manage your local Apptainer cache. You can list/clean using the specific types.\n
  \nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: command
    type: string
    doc: The cache management command to run (clean or list)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_cache.out
