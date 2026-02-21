cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - querynator
  - query-api-cgi
label: querynator_query-api-cgi
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/qbic-pipelines/querynator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
stdout: querynator_query-api-cgi.out
