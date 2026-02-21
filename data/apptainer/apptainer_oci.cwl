cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - oci
label: apptainer_oci
doc: "Manage OCI containers. Allow you to manage containers from OCI bundle directories.
  NOTE: all oci commands requires to run as root.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: subcommand
    type: string
    doc: The OCI command to execute (attach, create, delete, exec, kill, mount, pause,
      resume, run, start, state, umount, or update)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_oci.out
