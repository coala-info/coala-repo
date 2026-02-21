cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomebaser
label: genomebaser
doc: "A tool for genome base analysis (Note: The provided text contains container
  runtime error messages rather than tool help documentation, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/mscook/GenomeBaser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomebaser:0.1.2--py27_1
stdout: genomebaser.out
