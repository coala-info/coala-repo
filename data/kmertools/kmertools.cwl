cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmertools
label: kmertools
doc: "A tool for k-mer analysis (Note: The provided help text contains only system
  error messages regarding container execution and does not list specific tool functionality
  or arguments).\n\nTool homepage: https://github.com/anuradhawick/kmertools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
stdout: kmertools.out
