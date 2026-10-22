cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - TMalign
label: tmalign_TMalign
doc: "TM-align: protein structure alignment of two PDB (or mmCIF) files\n\nTool homepage: https://zhanglab.ccmb.med.umich.edu/TM-align/"
inputs:
  - id: pdb1
    type: File
    doc: "First structure (chain1) in PDB format"
    inputBinding:
      position: 1
  - id: pdb2
    type: File
    doc: "Second structure (chain2) in PDB format"
    inputBinding:
      position: 2
  - id: u_length
    type:
      - 'null'
      - float
    doc: "TM-score normalized by user assigned length (the same as -L); it should be >= the minimum length of the two structures"
    inputBinding:
      position: 100
      prefix: -u
  - id: l_length
    type:
      - 'null'
      - float
    doc: "TM-score normalized by user assigned length (the same as -u)"
    inputBinding:
      position: 101
      prefix: -L
  - id: avg_length_norm
    type:
      - 'null'
      - string
    doc: "TM-score normalized by the average length of two structures, T or F (default F)"
    inputBinding:
      position: 102
      prefix: -a
  - id: initial_alignment_file
    type:
      - 'null'
      - File
    doc: "Start with an alignment specified in a fasta file"
    inputBinding:
      position: 103
      prefix: -i
  - id: stick_to_alignment_file
    type:
      - 'null'
      - File
    doc: "Stick to the alignment specified in a fasta file"
    inputBinding:
      position: 104
      prefix: -I
  - id: rotation_matrix
    type:
      - 'null'
      - string
    doc: "Output TM-align rotation matrix to this file name"
    inputBinding:
      position: 105
      prefix: -m
  - id: d0_value
    type:
      - 'null'
      - float
    doc: "TM-score scaled by an assigned d0, e.g. 5 Angstroms"
    inputBinding:
      position: 106
      prefix: -d
  - id: superposition_prefix
    type:
      - 'null'
      - string
    doc: "Output the superposition to <prefix>* files"
    inputBinding:
      position: 107
      prefix: -o
  - id: fast_alignment
    type:
      - 'null'
      - boolean
    doc: "Fast but slightly inaccurate alignment by fTM-align algorithm"
    inputBinding:
      position: 108
      prefix: -fast
  - id: circular_permutation
    type:
      - 'null'
      - boolean
    doc: "Alignment with circular permutation"
    inputBinding:
      position: 109
      prefix: -cp
  - id: atom_name
    type:
      - 'null'
      - string
    doc: "4-character atom name used to represent a residue. Default is ' CA ' for proteins (note the spaces before and after CA)"
    inputBinding:
      position: 110
      prefix: -atom
  - id: ter_marker
    type:
      - 'null'
      - int
    doc: "Strings to mark the end of a chain: 3 (default) TER, ENDMDL, END or different chain ID; 2 ENDMDL, END, or different chain ID; 1 ENDMDL or END; 0 end of file"
    inputBinding:
      position: 111
      prefix: -ter
  - id: split_pdb
    type:
      - 'null'
      - int
    doc: "Whether to split PDB file into multiple chains: 0 (default) one single chain; 1 each MODEL a separate chain (-ter should be 0); 2 each chain a separate chain (-ter should be <=1)"
    inputBinding:
      position: 112
      prefix: -split
  - id: output_format
    type:
      - 'null'
      - int
    doc: "Output format: 0 (default) full output, 1 fasta format compact output, 2 tabular format very compact output, -1 full output without version or citation information"
    inputBinding:
      position: 113
      prefix: -outfmt
  - id: align_by_residue_index
    type:
      - 'null'
      - int
    doc: "Assume residue index correspondence between the two structures: 0 (default) sequence independent alignment; 1 sequence-dependent superposition (same as TMscore); 2 by residue index and chain ID (use with -ter <=1); 3 by residue index and order of chain (use with -ter <=1)"
    inputBinding:
      position: 114
      prefix: -byresi
  - id: tmcut
    type:
      - 'null'
      - float
    doc: "-1 (default) do not consider TMcut; values in [0.5,1): do not proceed with TM-align for this structure pair if the TM-score is unlikely to reach TMcut"
    inputBinding:
      position: 115
      prefix: -TMcut
  - id: align_mirror_image
    type:
      - 'null'
      - int
    doc: "Whether to align the mirror image of input structure: 0 (default) no, 1 align mirror of chain1 to chain2"
    inputBinding:
      position: 116
      prefix: -mirror
  - id: align_hetatm
    type:
      - 'null'
      - int
    doc: "Whether to align residues marked as HETATM in addition to ATOM: 0 (default) no, 1 yes"
    inputBinding:
      position: 117
      prefix: -het
  - id: input_format1
    type:
      - 'null'
      - int
    doc: "Input format for chain1: -1 (default) detect PDB or PDBx/mmCIF; 0 PDB; 1 SPICKER; 2 xyz; 3 PDBx/mmCIF"
    inputBinding:
      position: 118
      prefix: -infmt1
  - id: input_format2
    type:
      - 'null'
      - int
    doc: "Input format for chain2: -1 (default) detect PDB or PDBx/mmCIF; 0 PDB; 1 SPICKER; 2 xyz; 3 PDBx/mmCIF"
    inputBinding:
      position: 119
      prefix: -infmt2
outputs:
  - id: superposition_files
    type:
      - 'null'
      - File[]
    doc: "Superposition files written with -o"
    outputBinding:
      glob: "$(inputs.superposition_prefix)*"
  - id: rotation_matrix_file
    type:
      - 'null'
      - File
    doc: "Rotation matrix written with -m"
    outputBinding:
      glob: "$(inputs.rotation_matrix)"
  - id: stdout
    type: stdout
    doc: Alignment report written to standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmalign:20220227--h9948957_0
stdout: tmalign_TMalign.out
