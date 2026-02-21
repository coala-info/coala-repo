cwlVersion: v1.2
class: CommandLineTool
baseCommand: sparse-neighbors-search
label: sparse-neighbors-search
doc: "A tool for sparse neighbors search. (Note: The provided text contains container
  build logs rather than command-line help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/joachimwolff/sparse-neighbors-search"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparse-neighbors-search:0.7--py38h8ded8fe_2
stdout: sparse-neighbors-search.out
