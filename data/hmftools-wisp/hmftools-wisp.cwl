cwlVersion: v1.2
class: CommandLineTool
baseCommand: wisp
label: hmftools-wisp
doc: "The provided text is an error log indicating a failure to pull or build the
  container image and does not contain help text or usage information for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/wisp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-wisp:1.2--hdfd78af_0
stdout: hmftools-wisp.out
