cwlVersion: v1.2
class: CommandLineTool
baseCommand: badread
label: badread
doc: "A tool for simulating long reads (Note: The provided help text contains only
  container execution errors and no usage information).\n\nTool homepage: https://github.com/rrwick/Badread"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/badread:0.4.1--pyhdfd78af_0
stdout: badread.out
