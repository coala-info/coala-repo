cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gait-gm
  - add_kegg_pathway_info
label: gait-gm_add_kegg_pathway_info
doc: "Add KEGG pathway information to data. (Note: The provided help text contains
  only system error messages and no usage information; arguments could not be extracted.)\n
  \nTool homepage: https://github.com/secimTools/gait-gm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
stdout: gait-gm_add_kegg_pathway_info.out
