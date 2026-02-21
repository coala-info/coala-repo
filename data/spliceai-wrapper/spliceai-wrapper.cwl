cwlVersion: v1.2
class: CommandLineTool
baseCommand: spliceai-wrapper
label: spliceai-wrapper
doc: "A wrapper tool for SpliceAI (Note: The provided help text contains only system
  logs and error messages, no usage information was found).\n\nTool homepage: https://github.com/bihealth/spliceai-wrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spliceai-wrapper:0.1.0--0
stdout: spliceai-wrapper.out
