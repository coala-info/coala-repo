cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangolin
label: pangolin
doc: "Phylogenetic Assignment of Named Global Outbreak LINeages (Note: The provided
  text contains only system error messages and no help documentation; therefore, no
  arguments could be extracted).\n\nTool homepage: https://github.com/hCoV-2019/pangolin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangolin:4.3.4--pyhdfd78af_1
stdout: pangolin.out
