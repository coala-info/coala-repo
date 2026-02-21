cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer-counter
label: kmer-counter
doc: "A tool for counting k-mers (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/CobiontID/kmer-counter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-counter:0.1.2--h4349ce8_0
stdout: kmer-counter.out
