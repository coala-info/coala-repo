cwlVersion: v1.2
class: CommandLineTool
baseCommand: metachip
label: metachip
doc: "MetaCHIP: community-level horizontal gene transfer identification pipeline (Note:
  The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://github.com/songweizhi/MetaCHIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
stdout: metachip.out
