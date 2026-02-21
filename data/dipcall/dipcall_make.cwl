cwlVersion: v1.2
class: CommandLineTool
baseCommand: dipcall_make
label: dipcall_make
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log (Apptainer/Singularity) indicating a failure
  to build the SIF format due to insufficient disk space.\n\nTool homepage: https://github.com/lh3/dipcall"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dipcall:0.3--hdfd78af_0
stdout: dipcall_make.out
