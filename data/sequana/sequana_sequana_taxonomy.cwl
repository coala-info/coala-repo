cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequana_taxonomy
label: sequana_sequana_taxonomy
doc: "A tool for taxonomic classification (Note: The provided help text contains only
  system error logs regarding a failed container build and does not list command-line
  arguments).\n\nTool homepage: https://sequana.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0
stdout: sequana_sequana_taxonomy.out
