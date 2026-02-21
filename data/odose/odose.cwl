cwlVersion: v1.2
class: CommandLineTool
baseCommand: odose
label: odose
doc: "The provided text does not contain help information for the tool 'odose'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull or build the image due to insufficient disk space.\n\nTool homepage: https://github.com/ODoSE/odose.nl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odose:1.0--py27_0
stdout: odose.out
