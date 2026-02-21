cwlVersion: v1.2
class: CommandLineTool
baseCommand: Metaplex-calculate-IJR
label: metaplex_Metaplex-calculate-IJR
doc: "Calculate IJR using Metaplex\n\nTool homepage: https://github.com/NGabry/MetaPlex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
stdout: metaplex_Metaplex-calculate-IJR.out
