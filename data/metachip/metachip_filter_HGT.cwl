cwlVersion: v1.2
class: CommandLineTool
baseCommand: metachip_filter_HGT
label: metachip_filter_HGT
doc: "Filter horizontal gene transfer (HGT) candidates identified by MetaCHIP.\n\n
  Tool homepage: https://github.com/songweizhi/MetaCHIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
stdout: metachip_filter_HGT.out
