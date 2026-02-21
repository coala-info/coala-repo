cwlVersion: v1.2
class: CommandLineTool
baseCommand: fununifrac
label: fununifrac
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/KoslickiLab/FunUniFrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
stdout: fununifrac.out
