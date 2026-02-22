cwlVersion: v1.2
class: CommandLineTool
baseCommand: cressent_build
label: cressent_build
doc: "Builds a SIF (Singularity Image Format) image from OCI blobs or a Docker URI.\n\
  \nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: image_uri
    type: string
    doc: The OCI or Docker URI to fetch and convert (e.g., docker://...)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
stdout: cressent_build.out
