cwlVersion: v1.2
class: CommandLineTool
baseCommand: libdeflate-gzip
label: libdeflate_libdeflate-gzip
doc: "The provided text does not contain help information or usage instructions. It
  is an error log indicating a failure to build or run a container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/ebiggers/libdeflate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libdeflate:1.2--h14c3975_0
stdout: libdeflate_libdeflate-gzip.out
