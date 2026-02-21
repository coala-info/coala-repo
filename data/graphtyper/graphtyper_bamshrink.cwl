cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - bamshrink
label: graphtyper_bamshrink
doc: "A tool for shrinking BAM files, typically used within the Graphtyper suite.
  (Note: The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_bamshrink.out
