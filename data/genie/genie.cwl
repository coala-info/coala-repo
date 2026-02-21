cwlVersion: v1.2
class: CommandLineTool
baseCommand: genie
label: genie
doc: "The provided text does not contain help information or usage instructions for
  the tool 'genie'. It contains system log messages and a fatal error related to a
  container runtime (Apptainer/Singularity) failing to build the image due to insufficient
  disk space.\n\nTool homepage: https://github.com/sakkayaphab/genie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genie:0.7.0--h375a9b1_0
stdout: genie.out
