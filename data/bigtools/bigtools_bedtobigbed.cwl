cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedtobigbed
label: bigtools_bedtobigbed
doc: "The provided text is an error log indicating a failure to build or extract the
  container image (no space left on device) and does not contain help text or usage
  information for the tool. As a result, no arguments could be extracted.\n\nTool
  homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
stdout: bigtools_bedtobigbed.out
