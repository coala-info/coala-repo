cwlVersion: v1.2
class: CommandLineTool
baseCommand: kinex
label: kinex
doc: "The provided text does not contain help information for the tool 'kinex'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/bedapub/kinex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kinex:1.2.0--pyhdfd78af_0
stdout: kinex.out
