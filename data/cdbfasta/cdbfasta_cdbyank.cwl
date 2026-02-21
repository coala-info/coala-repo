cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdbyank
label: cdbfasta_cdbyank
doc: "A tool for extracting records from a FASTA file indexed by cdbfasta. Note: The
  provided help text contains a fatal error indicating the tool failed to run due
  to insufficient disk space.\n\nTool homepage: https://github.com/gpertea/cdbfasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cdbfasta:v0.99-20100722-5-deb_cv1
stdout: cdbfasta_cdbyank.out
