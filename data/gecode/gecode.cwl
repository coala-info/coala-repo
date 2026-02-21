cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecode
label: gecode
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container image due to insufficient disk space.\n\nTool homepage: http://www.gecode.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecode:6.2.0--h4c32e4d_6
stdout: gecode.out
