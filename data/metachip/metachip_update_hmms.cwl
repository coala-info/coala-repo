cwlVersion: v1.2
class: CommandLineTool
baseCommand: metachip_update_hmms
label: metachip_update_hmms
doc: "Update HMM databases for MetaCHIP. (Note: The provided help text contains only
  system error logs and no usage information.)\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
stdout: metachip_update_hmms.out
