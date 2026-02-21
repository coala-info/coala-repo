cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpa-server
label: mpa-server
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/compomics/meta-proteome-analyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpa-server:3.4--hdfd78af_3
stdout: mpa-server.out
