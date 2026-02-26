cwlVersion: v1.2
class: CommandLineTool
baseCommand: gencube
label: gencube
doc: "All gencube subcommands use NCBI's Entrez Utilities (E-Utilities), requiring
  an email.\n\nTool homepage: https://github.com/snu-cdrc/gencube"
inputs:
  - id: email
    type: string
    doc: Email address for NCBI E-Utilities
    inputBinding:
      position: 101
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: NCBI API key for increased request limits
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
stdout: gencube.out
