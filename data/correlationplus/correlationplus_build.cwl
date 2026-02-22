cwlVersion: v1.2
class: CommandLineTool
baseCommand: correlationplus_build
label: correlationplus_build
doc: "A tool for building or fetching the correlationplus container image from an
  OCI/Docker registry.\n\nTool homepage: https://github.com/tekpinar/correlationplus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
stdout: correlationplus_build.out
