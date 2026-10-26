cwlVersion: v1.2
class: CommandLineTool
baseCommand: qTMclust
label: usalign_qTMclust
doc: 'qTMclust: structure clustering by sequence-independent structure alignment.


  Tool homepage: https://zhanggroup.org/US-align'
inputs:
  - id: pdb
    type:
      - 'null'
      - File
    doc: Multi-chain or multi-model PDB file to cluster (use with -split and -ter)
    inputBinding:
      position: 1
  - id: TMcut
    type:
      - 'null'
      - float
    doc: TM-score cutoff in the range of [0.45,1) for considering two structures being similar. Default is 0.5.
    inputBinding:
      position: 101
      prefix: -TMcut
  - id: s
    type:
      - 'null'
      - int
    doc: 'Which TM-score to use when aligning structures with different lengths: 1: the larger TM-score; 2: the smaller TM-score (default); 3: average; 4: harmonic average; 5: geometric average; 6: root mean square'
    inputBinding:
      position: 101
      prefix: -s
  - id: o
    type:
      - 'null'
      - string
    doc: Output the cluster result to this file. Default is print result to screen.
    inputBinding:
      position: 101
      prefix: -o
  - id: init
    type:
      - 'null'
      - File
    doc: Tentative clustering file
    inputBinding:
      position: 101
      prefix: -init
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Fast but slightly inaccurate final alignment
    inputBinding:
      position: 101
      prefix: -fast
  - id: chain
    type:
      - 'null'
      - string
    doc: Chains to parse. Use _ for a chain without chain ID.
    inputBinding:
      position: 101
      prefix: -chain
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
  - id: cluster_file
    type:
      - 'null'
      - File
    doc: Cluster result written by -o
    outputBinding:
      glob: |
        ${ return inputs.o ? inputs.o : []; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
stdout: usalign_qTMclust.out
