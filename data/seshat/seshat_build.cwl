cwlVersion: v1.2
class: CommandLineTool
baseCommand: seshat_build
label: seshat_build
doc: "A tool for converting OCI blobs to SIF format and building container images.\n
  \nTool homepage: https://github.com/clintval/tp53"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
stdout: seshat_build.out
