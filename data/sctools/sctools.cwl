cwlVersion: v1.2
class: CommandLineTool
baseCommand: sctools
label: sctools
doc: "The provided text does not contain help information or usage instructions for
  sctools. It appears to be a system error log related to a Singularity/Apptainer
  container image pull failure due to insufficient disk space.\n\nTool homepage: https://github.com/bioinformatics-polito/SCTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sctools:1.0.0--h077b44d_5
stdout: sctools.out
