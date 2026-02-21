cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaplex
label: metaplex
doc: "Metaplex tool (Help text unavailable due to system error)\n\nTool homepage:
  https://github.com/NGabry/MetaPlex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
stdout: metaplex.out
