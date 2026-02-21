cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuma-gencode-gtf-to-bed
label: fuma_fuma-gencode-gtf-to-bed
doc: "A tool to convert Gencode GTF files to BED format.\n\nTool homepage: https://github.com/yhoogstrate/fuma/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuma:4.0.0--pyhb7b1952_0
stdout: fuma_fuma-gencode-gtf-to-bed.out
