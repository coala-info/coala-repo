cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - instance
label: apptainer_instance
doc: "Manage containers running as services. Instances allow you to run containers
  as background processes. This can be useful for running services such as web servers
  or databases.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (list, run, start, stats, stop)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_instance.out
