cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio
label: dsh-bio
doc: "The provided text does not contain help information; it is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to build a SIF
  image due to lack of disk space.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
stdout: dsh-bio.out
