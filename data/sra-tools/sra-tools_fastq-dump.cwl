cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-dump
label: sra-tools_fastq-dump
doc: "The provided text does not contain help information for fastq-dump; it is an
  error log from a container runtime (Apptainer/Singularity) failing to fetch the
  OCI image.\n\nTool homepage: https://github.com/ncbi/sra-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools_fastq-dump.out
