cwlVersion: v1.2
class: CommandLineTool
baseCommand: ploteig
label: eigensoft_ploteig
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message regarding a container runtime (Apptainer/Singularity) failing
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/DReichLab/EIG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigensoft:8.0.0--h75d7a4a_6
stdout: eigensoft_ploteig.out
