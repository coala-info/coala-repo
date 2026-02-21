cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-dl
label: fastq-dl
doc: "A tool to download FASTQ files from SRA or ENA (Note: The provided text contains
  container runtime error messages rather than the tool's help documentation).\n\n
  Tool homepage: https://github.com/rpetit3/fastq-dl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-dl:3.0.1--pyhdfd78af_0
stdout: fastq-dl.out
