cwlVersion: v1.2
class: CommandLineTool
baseCommand: imodview
label: imods_imodview
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  due to insufficient disk space.\n\nTool homepage: https://chaconlab.org/multiscale-simulations/imod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imods:1.0.4--h9ee0642_3
stdout: imods_imodview.out
