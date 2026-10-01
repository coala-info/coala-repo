cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tgtools
  - import
label: tgtools_import
doc: "Import data for various phylogenetic analyses.\n\nTool homepage: https://github.com/jodyphelan/tgtools"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available options: snp-distance, transphylo, hmmIBD.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgtools:0.0.4--pyhdfd78af_0
stdout: tgtools_import.out
