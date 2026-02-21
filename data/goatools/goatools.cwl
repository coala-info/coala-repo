cwlVersion: v1.2
class: CommandLineTool
baseCommand: goatools
label: goatools
doc: "The provided text does not contain help information for goatools. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the goatools image due to insufficient disk space.\n\nTool homepage: https://github.com/tanghaibao/goatools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goatools:1.2.3--pyh7cba7a3_2
stdout: goatools.out
