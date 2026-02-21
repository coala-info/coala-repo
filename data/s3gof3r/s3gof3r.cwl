cwlVersion: v1.2
class: CommandLineTool
baseCommand: s3gof3r
label: s3gof3r
doc: "s3gof3r is a fast, concurrent S3 client that optimizes throughput via multipart
  parallel transfers and pipelining.\n\nTool homepage: https://github.com/rlmcpherson/s3gof3r"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/s3gof3r:0.5.0--1
stdout: s3gof3r.out
