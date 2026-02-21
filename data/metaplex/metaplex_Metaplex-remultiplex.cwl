cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metaplex-remultiplex
label: metaplex_Metaplex-remultiplex
doc: "Metaplex remultiplex tool (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/NGabry/MetaPlex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
stdout: metaplex_Metaplex-remultiplex.out
