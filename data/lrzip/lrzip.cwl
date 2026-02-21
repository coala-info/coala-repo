cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrzip
label: lrzip
doc: "Long Range ZIP (lrzip) is a compression utility optimized for large files. Note:
  The provided help text contains a fatal error message indicating a failure to run
  the tool due to insufficient disk space, and does not contain argument definitions.\n
  \nTool homepage: https://github.com/ckolivas/lrzip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrzip:0.651--h32784b6_1
stdout: lrzip.out
