cwlVersion: v1.2
class: CommandLineTool
baseCommand: acms_build
label: acms_build
doc: "A tool for building or converting OCI/Docker images into SIF (Singularity Image
  Format) format, typically used for environment setup in bioinformatics workflows.\n
  \nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/acms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/acms:1.3.0--pl5321h9948957_2
stdout: acms_build.out
