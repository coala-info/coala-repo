cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngg_path
label: niemagraphgen_ngg_path
doc: "NIEMA Graph Generator path command (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen_ngg_path.out
