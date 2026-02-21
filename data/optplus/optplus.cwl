cwlVersion: v1.2
class: CommandLineTool
baseCommand: optplus
label: optplus
doc: "The provided text does not contain help information for the tool 'optplus'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container due to insufficient disk space.\n\nTool homepage:
  http://noble.gs.washington.edu/~mmh1/software/optplus/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optplus:0.2--pyh864c0ab_1
stdout: optplus.out
