cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - push
label: apptainer_push
doc: "Upload image to the provided URI. The 'push' command allows you to upload a
  SIF container to a given URI (library:// or oras://).\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: image
    type: File
    doc: Path to the SIF container image
    inputBinding:
      position: 1
  - id: uri
    type: string
    doc: Destination URI (e.g., library://... or oras://...)
    inputBinding:
      position: 2
  - id: allow_unsigned
    type:
      - 'null'
      - boolean
    doc: do not require a signed container image
    inputBinding:
      position: 103
      prefix: --allow-unsigned
  - id: description
    type:
      - 'null'
      - string
    doc: description for container image (library:// only)
    inputBinding:
      position: 103
      prefix: --description
  - id: docker_host
    type:
      - 'null'
      - string
    doc: specify a custom Docker daemon host
    inputBinding:
      position: 103
      prefix: --docker-host
  - id: library
    type:
      - 'null'
      - string
    doc: the library to push to
    inputBinding:
      position: 103
      prefix: --library
  - id: no_https
    type:
      - 'null'
      - boolean
    doc: use http instead of https for docker:// oras:// and library://<hostname>/...
      URIs
    inputBinding:
      position: 103
      prefix: --no-https
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_push.out
