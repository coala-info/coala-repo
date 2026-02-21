cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphlan2-data
label: metaphlan2-data
doc: "MetaPhlAn2 data tool (Note: The provided text contains system error messages
  regarding container execution and does not include usage instructions or argument
  definitions).\n\nTool homepage: https://bitbucket.org/biobakery/metaphlan2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metaphlan2-data:v2.6.0ds-4-deb_cv1
stdout: metaphlan2-data.out
