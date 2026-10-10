cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdb_to_xyzr
label: msms_pdb_to_xyzr
doc: "Extract x, y, z from a PDB file and generate the radius of each atom (input for msms).\n\nTool homepage: https://ccsb.scripps.edu/msms/"
inputs:
  - id: explicit_hydrogens
    type:
      - 'null'
      - boolean
    doc: use explicit hydrogen radii instead of the default united atom radii
    inputBinding:
      position: 1
      prefix: -h
  - id: pdb_file
    type: File
    doc: input PDB file
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: stdout
    doc: x y z radius for each atom of the PDB file
stdout: $(inputs.pdb_file.nameroot).xyzr
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msms:2.6.1--h9ee0642_3
