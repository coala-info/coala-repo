cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphembed
  - embed
label: graphembed_embed
doc: "A tool for graph embedding (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/jean-pierreBoth/graphembed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
stdout: graphembed_embed.out
