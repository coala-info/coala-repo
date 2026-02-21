cwlVersion: v1.2
class: CommandLineTool
baseCommand: afplot_build
label: afplot_build
doc: "A tool or script for building a SIF (Singularity Image Format) container for
  afplot from an OCI/Docker image.\n\nTool homepage: https://github.com/sndrtj/afplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
stdout: afplot_build.out
