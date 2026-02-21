cwlVersion: v1.2
class: CommandLineTool
baseCommand: dragonflye
label: dragonflye
doc: "The provided text does not contain help information for dragonflye; it is an
  error log from a container runtime (Singularity/Apptainer) indicating a failure
  to build the container image due to lack of disk space.\n\nTool homepage: https://github.com/rpetit3/dragonflye"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dragonflye:1.2.1--hdfd78af_0
stdout: dragonflye.out
