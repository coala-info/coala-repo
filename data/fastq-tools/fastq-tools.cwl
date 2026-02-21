cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-tools
label: fastq-tools
doc: "The provided text does not contain help information for fastq-tools. It contains
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  http://homes.cs.washington.edu/~dcjones/fastq-tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-tools:0.8.3--h38613fd_1
stdout: fastq-tools.out
