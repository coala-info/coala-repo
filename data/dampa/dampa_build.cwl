cwlVersion: v1.2
class: CommandLineTool
baseCommand: dampa_build
label: dampa_build
doc: "A tool for building or converting OCI images to SIF (Singularity Image Format).\n
  \nTool homepage: https://github.com/MultipathogenGenomics/dampa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dampa:0.2.0--pyhdfd78af_0
stdout: dampa_build.out
