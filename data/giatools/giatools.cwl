cwlVersion: v1.2
class: CommandLineTool
baseCommand: giatools
label: giatools
doc: "A tool for genome integration analysis (Note: The provided text contains system
  error logs rather than help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/BMCV/giatools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/giatools:0.7.3--pyhdfd78af_0
stdout: giatools.out
