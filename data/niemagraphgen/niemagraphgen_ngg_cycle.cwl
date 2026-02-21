cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngg_cycle
label: niemagraphgen_ngg_cycle
doc: "NIEMA graph generation tool (Note: The provided help text contains only system
  error logs and no usage information. No arguments could be extracted.)\n\nTool homepage:
  https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen_ngg_cycle.out
