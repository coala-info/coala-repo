cwlVersion: v1.2
class: CommandLineTool
baseCommand: elastic-blast
label: elastic-blast
doc: "This application facilitates running BLAST on large amounts of query sequence
  data on the cloud\n\nTool homepage: https://pypi.org/project/elastic-blast/"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to run: submit, status, delete, run-summary'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
stdout: elastic-blast.out
