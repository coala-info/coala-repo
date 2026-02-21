cwlVersion: v1.2
class: CommandLineTool
baseCommand: afpdb
label: afpdb
doc: "A tool for processing AlphaFold PDB files. (Note: The provided text appears
  to be a container execution error log rather than help text; no arguments could
  be extracted from the input.)\n\nTool homepage: https://github.com/data2code/afpdb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afpdb:0.3.1--pyhcf36b3e_0
stdout: afpdb.out
