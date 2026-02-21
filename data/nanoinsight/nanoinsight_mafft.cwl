cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoinsight_mafft
label: nanoinsight_mafft
doc: "A tool for multiple sequence alignment (part of the NanoInsight suite). Note:
  The provided text contains container runtime error messages rather than command-line
  help documentation.\n\nTool homepage: https://github.com/AsmaaSamyMohamedMahmoud/nanoinsight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoinsight:0.0.3--pyhdfd78af_0
stdout: nanoinsight_mafft.out
