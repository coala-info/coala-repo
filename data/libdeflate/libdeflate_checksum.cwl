cwlVersion: v1.2
class: CommandLineTool
baseCommand: libdeflate_checksum
label: libdeflate_checksum
doc: "A utility for computing checksums using libdeflate. (Note: The provided text
  is a system error log indicating a failure to build the container environment and
  does not contain the tool's help documentation.)\n\nTool homepage: https://github.com/ebiggers/libdeflate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libdeflate:1.2--h14c3975_0
stdout: libdeflate_checksum.out
