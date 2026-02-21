cwlVersion: v1.2
class: CommandLineTool
baseCommand: krepp
label: krepp
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/bo1929/krepp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.6.0--h370f27c_0
stdout: krepp.out
