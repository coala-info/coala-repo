cwlVersion: v1.2
class: CommandLineTool
baseCommand: gorpipe
label: gorpipe_gorshell
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/gorpipe/gor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gorpipe:4.5.0--hdfd78af_0
stdout: gorpipe_gorshell.out
