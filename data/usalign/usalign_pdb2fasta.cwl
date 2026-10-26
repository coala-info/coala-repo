cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdb2fasta
label: usalign_pdb2fasta
doc: 'Converting PDB file(s) into FASTA format sequence.


  Tool homepage: https://zhanggroup.org/US-align'
inputs:
  - id: pdb
    type:
      - 'null'
      - File
    doc: Structure file (PDB or PDBx/mmCIF)
    inputBinding:
      position: 1
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
  - id: infmt
    type:
      - 'null'
      - int
    doc: 'Input format for chain: -1: automatically detect PDB or PDBx/mmCIF format; 0: PDB format; 2: xyz format; 3: PDBx/mmCIF format'
    inputBinding:
      position: 101
      prefix: -infmt
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
stdout: usalign_pdb2fasta.out
