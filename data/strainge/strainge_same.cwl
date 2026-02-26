cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge
label: strainge_same
doc: "A tool for analyzing and comparing k-mer profiles of genomic sequences.\n\n\
  Tool homepage: The package home page"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to run. Available choices: kmerize, kmersim, cluster, createdb,
      search, call, view, compare, tree, stats, plot'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
stdout: strainge_same.out
