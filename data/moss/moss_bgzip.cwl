cwlVersion: v1.2
class: CommandLineTool
baseCommand: moss_bgzip
label: moss_bgzip
doc: "A block compression/decompression utility (part of the MOSS suite). Note: The
  provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://github.com/elkebir-group/Moss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moss:0.1.1--h84372a0_6
stdout: moss_bgzip.out
