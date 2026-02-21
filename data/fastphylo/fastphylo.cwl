cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastphylo
label: fastphylo
doc: "FastPhylo is a software package for phylogenetic analysis. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/arvestad/FastPhylo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastphylo:1.0.3--h7fcbb26_4
stdout: fastphylo.out
