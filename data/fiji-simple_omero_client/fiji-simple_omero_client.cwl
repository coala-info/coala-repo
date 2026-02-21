cwlVersion: v1.2
class: CommandLineTool
baseCommand: fiji-simple_omero_client
label: fiji-simple_omero_client
doc: "A tool for interacting with OMERO using Fiji. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/GReD-Clermont/simple-omero-client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiji:20250206--h9ee0642_1
stdout: fiji-simple_omero_client.out
