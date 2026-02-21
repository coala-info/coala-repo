cwlVersion: v1.2
class: CommandLineTool
baseCommand: filechunkio
label: filechunkio
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the container image due to lack of disk space.\n
  \nTool homepage: https://github.com/fabiant7t/filechunkio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/filechunkio:1.6--py36_0
stdout: filechunkio.out
