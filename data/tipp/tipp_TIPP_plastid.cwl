cwlVersion: v1.2
class: CommandLineTool
baseCommand: tipp
label: tipp_TIPP_plastid
doc: "Taxon Identification and Phylogenetic Profiling. (Note: The provided text contains
  system error messages regarding a container build failure and does not include usage
  instructions or argument definitions.)\n\nTool homepage: https://github.com/Wenfei-Xian/TIPP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tipp:1.3.0--py38pl5321h077b44d_0
stdout: tipp_TIPP_plastid.out
