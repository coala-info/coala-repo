cwlVersion: v1.2
class: CommandLineTool
baseCommand: biocontainers-search
label: bioconda2biocontainer_biocontainers-search
doc: "Find Biocontainers tools\n\nTool homepage: https://github.com/BioContainers/bioconda2biocontainer"
inputs:
  - id: json
    type:
      - 'null'
      - boolean
    doc: Print json format
    inputBinding:
      position: 101
      prefix: --json
  - id: search_term
    type: string
    doc: Search term
    inputBinding:
      position: 101
      prefix: --search_term
  - id: show_images
    type:
      - 'null'
      - boolean
    doc: Show all available images
    inputBinding:
      position: 101
      prefix: --show_images
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda2biocontainer:0.0.7--pyhdfd78af_0
stdout: bioconda2biocontainer_biocontainers-search.out
