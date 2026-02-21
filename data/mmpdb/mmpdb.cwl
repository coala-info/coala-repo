cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmpdb
label: mmpdb
doc: "Matched Molecular Pair Database (mmpdb). Note: The provided text contains system
  error messages regarding container execution and disk space, rather than functional
  help text or argument definitions.\n\nTool homepage: https://github.com/rdkit/mmpdb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmpdb:3.1.4--pyhdfd78af_0
stdout: mmpdb.out
