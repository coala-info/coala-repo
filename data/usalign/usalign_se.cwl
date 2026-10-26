cwlVersion: v1.2
class: CommandLineTool
baseCommand: se
label: usalign_se
doc: 'se: extract sequence alignment from a pair of superposed structures.


  Tool homepage: https://zhanggroup.org/US-align'
inputs:
  - id: pdb1
    type:
      - 'null'
      - File
    doc: First structure (PDB or PDBx/mmCIF file)
    inputBinding:
      position: 1
  - id: pdb2
    type:
      - 'null'
      - File
    doc: Second structure (PDB or PDBx/mmCIF file)
    inputBinding:
      position: 2
  - id: u
    type:
      - 'null'
      - float
    doc: TM-score normalized by user assigned length (the same as -L)
    inputBinding:
      position: 101
      prefix: -u
  - id: a
    type:
      - 'null'
      - string
    doc: 'TM-score normalized by the average length of two structures: T or F (default F)'
    inputBinding:
      position: 101
      prefix: -a
  - id: i
    type:
      - 'null'
      - File
    doc: Use alignment specified in fasta file 'align.txt' (same as -I)
    inputBinding:
      position: 101
      prefix: -i
  - id: d
    type:
      - 'null'
      - float
    doc: TM-score scaled by an assigned d0, e.g. 5 Angstroms
    inputBinding:
      position: 101
      prefix: -d
  - id: byresi
    type:
      - 'null'
      - int
    doc: Whether to align two structures by residue index
    inputBinding:
      position: 101
      prefix: -byresi
  - id: do
    type:
      - 'null'
      - boolean
    doc: Output distance of aligned residue pairs
    inputBinding:
      position: 101
      prefix: -do
  - id: suffix
    type:
      - 'null'
      - string
    doc: (Only when -dir1 and/or -dir2 are set, default is empty) add file name suffix to files listed by the chain lists
    inputBinding:
      position: 101
      prefix: -suffix
  - id: atom
    type:
      - 'null'
      - string
    doc: 4-character atom name used to represent a residue. Default is " C3'" for RNA/DNA and " CA " for proteins (note the spaces before and after CA).
    inputBinding:
      position: 101
      prefix: -atom
  - id: mol
    type:
      - 'null'
      - string
    doc: 'Molecule type: RNA or protein'
    inputBinding:
      position: 101
      prefix: -mol
  - id: ter
    type:
      - 'null'
      - int
    doc: 'Strings to mark the end of a chain: 3: TER, ENDMDL, END or different chain ID; 2: ENDMDL, END, or different chain ID; 1: ENDMDL or END; 0: end of file'
    inputBinding:
      position: 101
      prefix: -ter
  - id: split
    type:
      - 'null'
      - int
    doc: 'Whether to split PDB file into multiple chains: 0: treat the whole structure as one single chain; 1: treat each MODEL as a separate chain (-ter should be 0); 2: treat each chain as a separate chain (-ter should be <=1)'
    inputBinding:
      position: 101
      prefix: -split
  - id: het
    type:
      - 'null'
      - int
    doc: 'Whether to align residues marked as ''HETATM'' in addition to ''ATOM  '': 0: only ''ATOM  '' residues; 1: both ''ATOM  '' and ''HETATM'' residues'
    inputBinding:
      position: 101
      prefix: -het
  - id: outfmt
    type:
      - 'null'
      - int
    doc: 'Output format: 0: full output; 1: fasta format compact output; 2: tabular format very compact output; -1: full output, but without version or citation information'
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: infmt1
    type:
      - 'null'
      - int
    doc: 'Input format for chain1: -1: automatically detect PDB or PDBx/mmCIF format; 0: PDB format; 3: PDBx/mmCIF format'
    inputBinding:
      position: 101
      prefix: -infmt1
  - id: infmt2
    type:
      - 'null'
      - int
    doc: 'Input format for chain2: -1: automatically detect PDB or PDBx/mmCIF format; 0: PDB format; 3: PDBx/mmCIF format'
    inputBinding:
      position: 101
      prefix: -infmt2
  - id: dir_list
    type:
      - 'null'
      - File
    doc: File listing the chain file names, used with -dir
    inputBinding:
      position: 111
  - id: dir_folder
    type:
      - 'null'
      - Directory
    doc: Perform all-against-all alignment among the list of PDB chains listed by 'chain_list' under 'chain_folder'.
    inputBinding:
      position: 110
      prefix: -dir
  - id: dir1_list
    type:
      - 'null'
      - File
    doc: File listing the chain file names, used with -dir1
    inputBinding:
      position: 113
  - id: dir1_folder
    type:
      - 'null'
      - Directory
    doc: Use chain2 to search a list of PDB chains listed by 'chain1_list' under 'chain1_folder'.
    inputBinding:
      position: 112
      prefix: -dir1
  - id: dir2_list
    type:
      - 'null'
      - File
    doc: File listing the chain file names, used with -dir2
    inputBinding:
      position: 115
  - id: dir2_folder
    type:
      - 'null'
      - Directory
    doc: Use chain1 to search a list of PDB chains listed by 'chain2_list' under 'chain2_folder'.
    inputBinding:
      position: 114
      prefix: -dir2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
stdout: usalign_se.out
