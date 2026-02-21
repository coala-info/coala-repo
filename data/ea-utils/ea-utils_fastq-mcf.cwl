cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-mcf
label: ea-utils_fastq-mcf
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
stdout: ea-utils_fastq-mcf.out
