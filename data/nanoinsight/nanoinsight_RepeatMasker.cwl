cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanoinsight
  - RepeatMasker
label: nanoinsight_RepeatMasker
doc: "A tool for identifying and masking repeat elements in genomic sequences, part
  of the nanoinsight suite.\n\nTool homepage: https://github.com/AsmaaSamyMohamedMahmoud/nanoinsight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoinsight:0.0.3--pyhdfd78af_0
stdout: nanoinsight_RepeatMasker.out
