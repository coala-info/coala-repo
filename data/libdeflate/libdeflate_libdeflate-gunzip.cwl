cwlVersion: v1.2
class: CommandLineTool
baseCommand: libdeflate-gunzip
label: libdeflate_libdeflate-gunzip
doc: "A fast implementation of the gunzip decompression tool using the libdeflate
  library.\n\nTool homepage: https://github.com/ebiggers/libdeflate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libdeflate:1.2--h14c3975_0
stdout: libdeflate_libdeflate-gunzip.out
