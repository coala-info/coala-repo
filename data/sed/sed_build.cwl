cwlVersion: v1.2
class: CommandLineTool
baseCommand: sed_build
label: sed_build
doc: "Build SIF format images from OCI blobs or Docker URIs.\n\nTool homepage: https://www.gnu.org/software/sed/"
inputs:
  - id: source_uri
    type: string
    doc: The source URI (e.g., docker://ubuntu:latest) or path to build from
    inputBinding:
      position: 1
outputs:
  - id: target_sif
    type: File
    doc: The destination SIF file to be built
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
