cwlVersion: v1.2
class: CommandLineTool
baseCommand: metachip_rename_seqs
label: metachip_rename_seqs
doc: "A tool within the MetaCHIP package for renaming sequences. (Note: The provided
  help text contains only container runtime error messages and does not list specific
  arguments or usage instructions.)\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
stdout: metachip_rename_seqs.out
