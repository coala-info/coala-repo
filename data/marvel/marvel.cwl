cwlVersion: v1.2
class: CommandLineTool
baseCommand: marvel
label: marvel
doc: "A tool for phylogenetic analysis (Note: The provided help text contains only
  container execution errors and no usage information).\n\nTool homepage: http://github.com/quadram-institute-bioscience/marvel/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marvel:0.2--py39hdfd78af_4
stdout: marvel.out
