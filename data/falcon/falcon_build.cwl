cwlVersion: v1.2
class: CommandLineTool
baseCommand: falcon_build
label: falcon_build
doc: "Converts OCI (Docker) blobs/images to SIF (Singularity Image Format).\n\nTool
  homepage: https://github.com/falconry/falcon"
inputs:
  - id: source_uri
    type: string
    doc: The URI of the OCI/Docker image to fetch (e.g., 
      docker://biocontainers/falcon:v1.8.6-1.1-deb_cv1)
    inputBinding:
      position: 1
outputs:
  - id: output_sif
    type: File
    doc: The path to the resulting SIF format file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/falcon:v1.8.6-1.1-deb_cv1
