cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop_searchSVbyGene
label: neoloop_searchSVbyGene
doc: "Search for structural variants (SVs) by gene using NeoLoop. (Note: The provided
  input text contains container runtime error messages and does not include usage
  instructions or argument definitions.)\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_searchSVbyGene.out
