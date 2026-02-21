cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - querynator
  - query-api-civic
label: querynator_query-api-civic
doc: "Query the CIViC API using querynator (Note: The provided text is a container
  execution error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/qbic-pipelines/querynator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
stdout: querynator_query-api-civic.out
