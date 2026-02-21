cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - pull
label: apptainer_pull
doc: "The 'pull' command allows you to download or build a container from a given
  URI.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: uri
    type: string
    doc: The URI of the image to pull (e.g., library://, docker://, shub://, oras://,
      http://)
    inputBinding:
      position: 1
  - id: arch
    type:
      - 'null'
      - string
    doc: architecture to pull from library
    default: amd64
    inputBinding:
      position: 102
      prefix: --arch
  - id: arch_variant
    type:
      - 'null'
      - string
    doc: architecture variant to pull from library
    inputBinding:
      position: 102
      prefix: --arch-variant
  - id: dir
    type:
      - 'null'
      - Directory
    doc: download images to the specific directory
    inputBinding:
      position: 102
      prefix: --dir
  - id: disable_cache
    type:
      - 'null'
      - boolean
    doc: do not use or create cached images/blobs
    inputBinding:
      position: 102
      prefix: --disable-cache
  - id: docker_host
    type:
      - 'null'
      - string
    doc: specify a custom Docker daemon host
    inputBinding:
      position: 102
      prefix: --docker-host
  - id: docker_login
    type:
      - 'null'
      - boolean
    doc: login to a Docker Repository interactively
    inputBinding:
      position: 102
      prefix: --docker-login
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite an image file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: library
    type:
      - 'null'
      - string
    doc: download images from the provided library
    inputBinding:
      position: 102
      prefix: --library
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: do NOT clean up bundle after failed build, can be helpful for debugging
    inputBinding:
      position: 102
      prefix: --no-cleanup
  - id: no_https
    type:
      - 'null'
      - boolean
    doc: use http instead of https for docker:// oras:// and library://<hostname>/...
      URIs
    inputBinding:
      position: 102
      prefix: --no-https
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify a name for the downloaded image file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
