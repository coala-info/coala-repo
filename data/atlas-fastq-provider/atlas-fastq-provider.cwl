cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas-fastq-provider
label: atlas-fastq-provider
doc: "A tool for providing FASTQ files (Note: The provided text contains system error
  messages rather than help documentation).\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-fastq-provider"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas-fastq-provider:0.4.8--hdfd78af_0
stdout: atlas-fastq-provider.out
