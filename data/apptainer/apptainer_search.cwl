cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - search
label: apptainer_search
doc: "Search a Container Library for container images matching the search query. You
  can specify an alternate architecture, and/or limit the results to only signed images.\n
  \nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: search_query
    type: string
    doc: Container image search query
    inputBinding:
      position: 1
  - id: arch
    type:
      - 'null'
      - string
    doc: architecture to search for
    inputBinding:
      position: 102
      prefix: --arch
  - id: library
    type:
      - 'null'
      - string
    doc: URI for library to search
    inputBinding:
      position: 102
      prefix: --library
  - id: signed
    type:
      - 'null'
      - boolean
    doc: search for only signed images
    inputBinding:
      position: 102
      prefix: --signed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_search.out
