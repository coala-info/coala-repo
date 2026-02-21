cwlVersion: v1.2
class: CommandLineTool
baseCommand: massiveqc_fastq_screen
label: massiveqc_fastq_screen
doc: "The provided text does not contain help information for the tool, but rather
  error logs related to a container runtime (Singularity/Apptainer) failure due to
  insufficient disk space.\n\nTool homepage: https://github.com/shimw6828/MassiveQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
stdout: massiveqc_fastq_screen.out
