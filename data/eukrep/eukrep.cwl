cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukrep
label: eukrep
doc: "The provided text does not contain help information for eukrep; it contains
  system error messages regarding a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/patrickwest/EukRep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukrep:0.6.7--pyh7e72e81_3
stdout: eukrep.out
