cwlVersion: v1.2
class: CommandLineTool
baseCommand: metachip
label: metachip_MetaCHIP
doc: "MetaCHIP v1.10.13\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
inputs:
  - id: module
    type: string
    doc: Core or Supplementary module to run (PI, BP, filter_HGT, update_hmms, 
      get_SCG_tree, rename_seqs)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
stdout: metachip_MetaCHIP.out
