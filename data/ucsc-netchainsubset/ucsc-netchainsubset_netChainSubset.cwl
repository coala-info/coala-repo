cwlVersion: v1.2
class: CommandLineTool
baseCommand: netChainSubset
label: ucsc-netchainsubset_netChainSubset
doc: "Subset a net file to include only chains that are in a chain file. (Note: The
  provided help text contains container runtime errors and no usage information.)\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netchainsubset:482--h0b57e2e_0
stdout: ucsc-netchainsubset_netChainSubset.out
