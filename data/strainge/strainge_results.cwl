cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge
label: strainge_results
doc: "A toolkit for analyzing genomic sequences using k-mer based methods.\n\nTool
  homepage: The package home page"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: kmerize, kmersim, cluster,
      createdb, search, call, view, compare, tree, stats, plot'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      type: array
      items: string
    doc: Arguments for the chosen subcommand
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
stdout: strainge_results.out
