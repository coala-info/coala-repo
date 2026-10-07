cwlVersion: v1.2
class: CommandLineTool
baseCommand: dist
label: concoord_dist
doc: "dist defines a set of geometric constraints from which structures can be generated
  by the program disco.\n\nTool homepage: https://www3.mpibpc.mpg.de/groups/de_groot/concoord"
inputs:
  - id: prompt_answers
    type: File
    doc: 'Text file piped to the interactive prompts of dist: line 1 is the Van
      der Waals parameter set (1 OPLS-UA united atoms, 2 OPLS-AA all atoms, 3 PROLSQ
      repel, 4 Yamber2, 5 Li et al., 6 OPLS-X recommended for NMR structure determination);
      line 2 is the bond/angle parameter set (1 Concoord default parameters, 2 Engh-Huber
      parameters). The default answers are 1 and 1.'
    default:
      class: File
      basename: dist_prompt_answers.txt
      contents: "1\n1\n"
  - id: cutoff_radius
    type:
      - 'null'
      - float
    doc: cut-off radius (Angstroms) for non-bonded interacting pairs (the 
      cut-off distances are additional to the sum of VDW radii)
    inputBinding:
      position: 101
      prefix: -c
  - id: damp_factor
    type:
      - 'null'
      - float
    doc: multiply each distance margin by value
    inputBinding:
      position: 101
      prefix: -damp
  - id: dssp_executable
    type:
      - 'null'
      - File
    doc: DSSP can be used for determining secondary structure-related pairs; 
      <file> is the name of the dssp executable
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
    doc: minimum nr of distances to be defined for each atom (default 50, or 1 
      with -noe)
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
  - id: output_distances_path
    type:
      - 'null'
      - string
    doc: '- output file containing distances (default dist.dat)'
    inputBinding:
      position: 102
      prefix: -od
  - id: output_gromos_path
    type:
      - 'null'
      - string
    doc: '- output GROMOS87 coordinate file (default dist.gro)'
    inputBinding:
      position: 103
      prefix: -og
  - id: output_pdb_path
    type:
      - 'null'
      - string
    doc: '- output structure in PDB file format (default dist.pdb)'
    inputBinding:
      position: 104
      prefix: -op
outputs:
  - id: output_pdb
    type:
      - 'null'
      - File
    doc: output structure in PDB file format
    outputBinding:
      glob: $(inputs.output_pdb_path)
  - id: output_gromos
    type:
      - 'null'
      - File
    doc: output GROMOS87 coordinate file
    outputBinding:
      glob: $(inputs.output_gromos_path)
  - id: output_distances
    type:
      - 'null'
      - File
    doc: output file containing distances
    outputBinding:
      glob: $(inputs.output_distances_path)
  - id: parameter_files
    type:
      type: array
      items: File
    doc: ATOMS.DAT, MARGINS.DAT and BONDS.DAT parameter files copied for the 
      selected parameter sets (needed by disco)
    outputBinding:
      glob:
        - ATOMS.DAT
        - MARGINS.DAT
        - BONDS.DAT
requirements:
  - class: InlineJavascriptRequirement
stdin: $(inputs.prompt_answers.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/concoord:2.1.2--h9ee0642_4
