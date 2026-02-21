cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - niemagraphgen
  - ngg_complete
label: niemagraphgen_ngg_complete
doc: "NIEMA Graph Generator - Complete workflow command. Note: The provided text contains
  execution logs/errors rather than help documentation, so no specific arguments could
  be extracted.\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen_ngg_complete.out
