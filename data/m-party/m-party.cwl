cwlVersion: v1.2
class: CommandLineTool
baseCommand: m-party
label: m-party
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to lack of disk space.\n\nTool homepage: https://github.com/ozefreitas/M-PARTY"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/m-party:0.2.2--hdfd78af_0
stdout: m-party.out
