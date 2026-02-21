cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigtools
  - bedgraphtobigwig
label: bigtools_bedgraphtobigwig
doc: "The provided help text contains a fatal error log indicating a failure to build
  or run the container (no space left on device) and does not contain usage information
  or argument descriptions.\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
stdout: bigtools_bedgraphtobigwig.out
