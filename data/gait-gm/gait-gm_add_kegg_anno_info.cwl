cwlVersion: v1.2
class: CommandLineTool
baseCommand: gait-gm_add_kegg_anno_info
label: gait-gm_add_kegg_anno_info
doc: "Add KEGG annotation information. (Note: The provided help text contains only
  system error messages regarding container execution and does not list specific arguments.)\n
  \nTool homepage: https://github.com/secimTools/gait-gm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
stdout: gait-gm_add_kegg_anno_info.out
