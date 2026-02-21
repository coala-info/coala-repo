cwlVersion: v1.2
class: CommandLineTool
baseCommand: eigensoft
label: eigensoft
doc: "The provided text does not contain help information for the eigensoft tool;
  it contains a fatal error message from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/DReichLab/EIG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigensoft:8.0.0--h75d7a4a_6
stdout: eigensoft.out
