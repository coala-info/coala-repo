cwlVersion: v1.2
class: CommandLineTool
baseCommand: canopy_build
label: canopy_build
doc: "Converts OCI blobs to SIF format and builds a container image.\n\nTool homepage:
  https://github.com/hildebra/canopy2/"
inputs:
  - id: source_uri
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
    dockerPull: quay.io/biocontainers/canopy:0.25--h077b44d_1
stdout: canopy_build.out
