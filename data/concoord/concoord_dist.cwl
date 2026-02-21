cwlVersion: v1.2
class: CommandLineTool
baseCommand: dist
label: concoord_dist
doc: "dist defines a set of geometric constraints from which structures can be generated
  by the program disco.\n\nTool homepage: https://www3.mpibpc.mpg.de/groups/de_groot/concoord"
inputs:
  - id: cutoff_radius
    type:
      - 'null'
      - float
    doc: cut-off radius (Angstroms) for non-bonded interacting pairs (the cut-off
      distances are additional to the sum of VDW radii)
    default: 4.0
    inputBinding:
      position: 101
      prefix: -c
  - id: damp_factor
    type:
      - 'null'
      - float
    doc: multiply each distance margin by value
    default: 1.0
    inputBinding:
      position: 101
      prefix: -damp
  - id: dssp_executable
    type:
      - 'null'
      - File
    doc: DSSP can be used for determining secondary structure-related pairs; <file>
      is the name of the dssp executable
    inputBinding:
      position: 101
      prefix: -dssp
  - id: fixed_zero_occupancy
    type:
      - 'null'
      - boolean
    doc: interpret zero occupancy as atom to keep fixed
    inputBinding:
      position: 101
      prefix: -q
  - id: gromos_input
    type:
      - 'null'
      - File
    doc: name of input GROMOS87 coordinate file (either -g or -p is mandatory)
    inputBinding:
      position: 101
      prefix: -g
  - id: min_distances
    type:
      - 'null'
      - int
    doc: minimum nr of distances to be defined for each atom (default 50, or 1 with
      -noe)
    default: 50
    inputBinding:
      position: 101
      prefix: -m
  - id: noe_restrictions
    type:
      - 'null'
      - File
    doc: input NOE restrictions
    inputBinding:
      position: 101
      prefix: -noe
  - id: non_bonded_alternatives
    type:
      - 'null'
      - boolean
    doc: 'try to find alternatives for non-bonded interactions (by default the native
      contacts will be preserved). Warning: EXPERIMENTAL!'
    inputBinding:
      position: 101
      prefix: -nb
  - id: pdb_input
    type:
      - 'null'
      - File
    doc: name of input PDB coordinate file (either -g or -p is mandatory)
    inputBinding:
      position: 101
      prefix: -p
  - id: retain_hydrogens
    type:
      - 'null'
      - boolean
    doc: retain hydrogen atoms (by default they will be removed)
    inputBinding:
      position: 101
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_pdb
    type:
      - 'null'
      - File
    doc: output structure in PDB file format
    outputBinding:
      glob: $(inputs.output_pdb)
  - id: output_gromos
    type:
      - 'null'
      - File
    doc: output GROMOS87 coordinate file
    outputBinding:
      glob: $(inputs.output_gromos)
  - id: output_distances
    type:
      - 'null'
      - File
    doc: output file containing distances
    outputBinding:
      glob: $(inputs.output_distances)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/concoord:2.1.2--h9ee0642_4
