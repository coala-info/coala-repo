cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clm
  - modularity
label: mcl_clm modularity
doc: "The clm modularity command is used to compute the modularity of a clustering.
  (Note: The provided help text contains a system error message and does not list
  specific arguments.)\n\nTool homepage: https://micans.org/mcl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcl:22.282--pl5321h7b50bb2_4
stdout: mcl_clm modularity.out
