cwlVersion: v1.2
class: CommandLineTool
baseCommand: gem-indexer
label: gem3-mapper_gem-indexer
doc: "Indexer for the GEM3 mapper. (Note: The provided text contains only system error
  messages and no help documentation; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/smarco/gem3-mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gem3-mapper:3.6.1--hb1d24b7_13
stdout: gem3-mapper_gem-indexer.out
