cwlVersion: v1.2
class: CommandLineTool
baseCommand: cagee_build
label: cagee_build
doc: "A tool for converting OCI blobs to SIF format and building container images.\n
  \nTool homepage: https://github.com/hahnlab/CAGEE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cagee:1.2--he96a11b_1
stdout: cagee_build.out
