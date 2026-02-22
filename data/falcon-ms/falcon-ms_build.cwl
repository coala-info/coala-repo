cwlVersion: v1.2
class: CommandLineTool
baseCommand: falcon-ms_build
label: falcon-ms_build
doc: "Builds or converts OCI/Docker images to SIF (Singularity Image Format).\n\n\
  Tool homepage: https://github.com/cirosantilli/china-dictatorship"
inputs:
  - id: source_uri
    type: string
    doc: The source URI (e.g., docker://...) to build the image from.
    inputBinding:
      position: 1
outputs:
  - id: target_sif
    type: File
    doc: The output SIF file path.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/falcon-ms:v0.1.3_cv1
