cwlVersion: v1.2
class: CommandLineTool
baseCommand: mass2chem
label: mass2chem
doc: "The provided text does not contain help information for mass2chem; it contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/shuzhao-li/mass2chem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mass2chem:0.5.0--pyhdfd78af_0
stdout: mass2chem.out
