cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdb_to_xyzr
label: scripps-msms_pdb_to_xyzr
doc: "Extract x, y, z from a PDB file and give the radius of each atom (united-atom radii unless -h is given); the output is the sphere input file for msms.\n\nTool homepage: https://ccsb.scripps.edu/msms/"
inputs:
  - id: explicit_hydrogens
    type: ['null', boolean]
    doc: use explicit hydrogen radii instead of default united atom radii
    inputBinding:
      position: 1
      prefix: -h
  - id: pdb_file
    type: File
    doc: input PDB file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: sphere file with one atom per line (x y z radius)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scripps-msms:2.6.1--h9ee0642_0
stdout: scripps-msms_pdb_to_xyzr.out
