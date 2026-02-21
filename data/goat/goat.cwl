cwlVersion: v1.2
class: CommandLineTool
baseCommand: goat
label: goat
doc: "The provided text does not contain help or usage information for the tool 'goat'.
  It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to lack of disk space.\n\nTool homepage:
  https://github.com/genomehubs/goat-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goat:0.2.5--he3973ca_3
stdout: goat.out
