cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_pdb_tools
label: biobb_pdb_tools
doc: "A collection of tools for manipulating PDB files from the BioBB (BioExcel Building
  Blocks) suite.\n\nTool homepage: https://github.com/bioexcel/biobb_pdb_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_pdb_tools:5.2.0--pyhdfd78af_0
stdout: biobb_pdb_tools.out
