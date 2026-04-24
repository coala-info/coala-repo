cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda2biocontainer
label: bioconda2biocontainer
doc: "Find Biocontainers images from Bioconda packages\n\nTool homepage: https://github.com/BioContainers/bioconda2biocontainer"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Print all images
    inputBinding:
      position: 101
      prefix: --all
  - id: container_type
    type:
      - 'null'
      - string
    doc: 'Container type. Default: Docker. Values: Docker, Conda, Singularity'
    inputBinding:
      position: 101
      prefix: --container_type
  - id: json
    type:
      - 'null'
      - boolean
    doc: Print json format
    inputBinding:
      position: 101
      prefix: --json
  - id: package_name
    type: string
    doc: Bioconda package name
    inputBinding:
      position: 101
      prefix: --package_name
  - id: package_version
    type:
      - 'null'
      - string
    doc: Bioconda package version
    inputBinding:
      position: 101
      prefix: --package_version
  - id: registry_host
    type:
      - 'null'
      - string
    doc: 'Registry host. Default: quay.io.Values:'
    inputBinding:
      position: 101
      prefix: --registry_host
  - id: sort_by_download
    type:
      - 'null'
      - boolean
    doc: Sort by number of downloads instead of by date
    inputBinding:
      position: 101
      prefix: --sort_by_download
  - id: sort_by_size
    type:
      - 'null'
      - boolean
    doc: Sort by size instead of by date
    inputBinding:
      position: 101
      prefix: --sort_by_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda2biocontainer:0.0.7--pyhdfd78af_0
stdout: bioconda2biocontainer.out
