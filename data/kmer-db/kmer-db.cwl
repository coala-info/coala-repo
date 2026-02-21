cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer-db
label: kmer-db
doc: "A tool for k-mer based analysis (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
stdout: kmer-db.out
