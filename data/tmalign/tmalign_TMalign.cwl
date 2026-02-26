cwlVersion: v1.2
class: CommandLineTool
baseCommand: TMalign
label: tmalign_TMalign
doc: "protein structure alignment\n\nTool homepage: https://zhanglab.ccmb.med.umich.edu/TM-align/"
inputs:
  - id: pdb1
    type: File
    doc: First PDB file
    inputBinding:
      position: 1
  - id: pdb2
    type: File
    doc: Second PDB file
    inputBinding:
      position: 2
  - id: chain_list_for_all_vs_all
    type:
      - 'null'
      - File
    doc: List of PDB chains for all-against-all alignment
    inputBinding:
      position: 3
  - id: chain1_list
    type:
      - 'null'
      - File
    doc: List of PDB chains for chain1
    inputBinding:
      position: 4
  - id: chain2_for_dir1
    type:
      - 'null'
      - File
    doc: Chain2 to search against chain1 list
    inputBinding:
      position: 5
  - id: chain2_list
    type:
      - 'null'
      - File
    doc: List of PDB chains for chain2
    inputBinding:
      position: 6
  - id: chain1_for_dir2
    type:
      - 'null'
      - File
    doc: Chain1 to search against chain2 list
    inputBinding:
      position: 7
  - id: align_by_residue_index
    type:
      - 'null'
      - int
    doc: Whether to assume residue index correspondence between the two 
      structures.
    default: 0
    inputBinding:
      position: 108
      prefix: -byresi
  - id: align_hetatm
    type:
      - 'null'
      - int
    doc: Whether to align residues marked as 'HETATM' in addition to 'ATOM  '
    default: 0
    inputBinding:
      position: 108
      prefix: -het
  - id: align_mirror_image
    type:
      - 'null'
      - int
    doc: Whether to align the mirror image of input structure
    default: 0
    inputBinding:
      position: 108
      prefix: -mirror
  - id: all_vs_all_dir
    type:
      - 'null'
      - Directory
    doc: Perform all-against-all alignment among the list of PDB chains listed 
      by 'chain_list' under 'chain_folder'.
    inputBinding:
      position: 108
      prefix: -dir
  - id: atom_name
    type:
      - 'null'
      - string
    doc: 4-character atom name used to represent a residue.
    default: ' CA '
    inputBinding:
      position: 108
      prefix: -atom
  - id: avg_length_norm
    type:
      - 'null'
      - boolean
    doc: TM-score normalized by the average length of two structures
    default: false
    inputBinding:
      position: 108
      prefix: -a
  - id: chain1_folder
    type:
      - 'null'
      - Directory
    doc: Folder for chain1 list
    inputBinding:
      position: 108
      prefix: -dir1
  - id: chain2_folder
    type:
      - 'null'
      - Directory
    doc: Folder for chain2 list
    inputBinding:
      position: 108
      prefix: -dir2
  - id: circular_permutation
    type:
      - 'null'
      - boolean
    doc: Alignment with circular permutation
    inputBinding:
      position: 108
      prefix: -cp
  - id: d0_value
    type:
      - 'null'
      - float
    doc: TM-score scaled by an assigned d0, e.g. 5 Angstroms
    inputBinding:
      position: 108
      prefix: -d
  - id: fast_alignment
    type:
      - 'null'
      - boolean
    doc: Fast but slightly inaccurate alignment by fTM-align algorithm
    inputBinding:
      position: 108
      prefix: -fast
  - id: file_suffix
    type:
      - 'null'
      - string
    doc: Add file name suffix to files listed by chain1_list or chain2_list
    inputBinding:
      position: 108
      prefix: -suffix
  - id: initial_alignment_file
    type:
      - 'null'
      - File
    doc: Start with an alignment specified in fasta file 'align.txt'
    inputBinding:
      position: 108
      prefix: -i
  - id: input_format1
    type:
      - 'null'
      - int
    doc: Input format for chain1
    default: -1
    inputBinding:
      position: 108
      prefix: -infmt1
  - id: input_format2
    type:
      - 'null'
      - int
    doc: Input format for chain2
    default: -1
    inputBinding:
      position: 108
      prefix: -infmt2
  - id: output_format
    type:
      - 'null'
      - int
    doc: Output format
    default: 0
    inputBinding:
      position: 108
      prefix: -outfmt
  - id: output_rotation_matrix
    type:
      - 'null'
      - File
    doc: Output TM-align rotation matrix
    inputBinding:
      position: 108
      prefix: -m
  - id: split_pdb
    type:
      - 'null'
      - int
    doc: Whether to split PDB file into multiple chains
    default: 0
    inputBinding:
      position: 108
      prefix: -split
  - id: stick_to_alignment_file
    type:
      - 'null'
      - File
    doc: Stick to the alignment specified in 'align.txt'
    inputBinding:
      position: 108
      prefix: -I
  - id: ter_marker
    type:
      - 'null'
      - int
    doc: Strings to mark the end of a chain
    default: 3
    inputBinding:
      position: 108
      prefix: -ter
  - id: tmcut_normalization
    type:
      - 'null'
      - int
    doc: 'TMcut is normalized is set by -a option: -2: normalized by longer structure
      length, -1: normalized by shorter structure length, 0: (default, same as F)
      normalized by second structure, 1: same as T, normalized by average structure
      length'
    default: 0
    inputBinding:
      position: 108
      prefix: -TMcut
  - id: tmcut_value
    type:
      - 'null'
      - float
    doc: '-1: (default) do not consider TMcut. Values in [0.5,1): Do not proceed with
      TM-align for this structure pair if TM-score is unlikely to reach TMcut.'
    default: -1
    inputBinding:
      position: 108
      prefix: -TMcut
  - id: user_length_norm
    type:
      - 'null'
      - boolean
    doc: TM-score normalized by user assigned length (the same as -L)
    inputBinding:
      position: 108
      prefix: -u
outputs:
  - id: output_superposition_prefix
    type:
      - 'null'
      - File
    doc: Output the superposition to 'TM_sup*'
    outputBinding:
      glob: $(inputs.output_superposition_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmalign:20220227--h9948957_0
