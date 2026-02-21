cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastalite
label: fastalite
doc: "A lightweight FASTA/FASTQ parsing tool. (Note: The provided text contains container
  runtime error messages rather than the tool's help documentation.)\n\nTool homepage:
  https://github.com/nhoffman/fastalite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastalite:0.4.1--pyh7cba7a3_0
stdout: fastalite.out
