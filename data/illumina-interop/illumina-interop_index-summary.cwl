cwlVersion: v1.2
class: CommandLineTool
baseCommand: index-summary
label: illumina-interop_index-summary
doc: "A tool from the Illumina InterOp library to summarize index metrics. (Note:
  The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: http://illumina.github.io/interop/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: illumina-interop_index-summary.out
