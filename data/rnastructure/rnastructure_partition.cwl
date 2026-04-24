cwlVersion: v1.2
class: CommandLineTool
baseCommand: partition
label: rnastructure_partition
doc: "Partition function calculation for RNA/DNA sequences.\n\nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs:
  - id: sequence_file
    type: File
    doc: "The name of a file containing an input sequence. Acceptable formats include
      SEQ, FASTA and raw-sequence plain-text files.\n    If the name is a hyphen (-),
      the file will be read from standard input\n    (STDIN)."
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: "Specify the name of a folding alphabet and associated nearest neighbor\n\
      \    parameters. The alphabet is the prefix for the thermodynamic parameter\n\
      \    files, e.g. \"rna\" for RNA parameters or \"dna\" for DNA parameters or
      a\n    custom extended/modified alphabet. The thermodynamic parameters need
      to\n    reside in the at the location indicated by environment variable DATAPATH.\n\
      \    The default is \"rna\" (i.e. use RNA parameters). This option overrides
      the\n    --DNA flag."
    inputBinding:
      position: 102
      prefix: --alphabet
  - id: constraint_file
    type:
      - 'null'
      - File
    doc: "Specify a constraints file to be applied.\n    Default is to have no constraints
      applied."
    inputBinding:
      position: 102
      prefix: --constraint
  - id: disable_coax
    type:
      - 'null'
      - boolean
    doc: "Specify that coaxial stacking recusions should not be used. This option\n\
      \    uses a less realistic energy function in exchange for a faster\n    calculation."
    inputBinding:
      position: 102
      prefix: --disablecoax
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "Specify that the sequence is DNA, and DNA parameters are to be used.\n \
      \   Default is to use RNA parameters."
    inputBinding:
      position: 102
      prefix: --DNA
  - id: double_offset_file
    type:
      - 'null'
      - File
    doc: "Specify a double-stranded offset file, which adds energy bonuses to\n  \
      \  particular double-stranded nucleotides.\n    Default is to have no double-stranded
      offset specified."
    inputBinding:
      position: 102
      prefix: --doubleOffset
  - id: experimental_pair_bonus_file
    type:
      - 'null'
      - File
    doc: "Input text file with bonuses (in kcal) as a matrix. As with SHAPE, bonuses\n\
      \    will be applied twice to internal base pairs, once to edge base pairs,
      and\n    not at all to single stranded regions.\n    Default is no experimental
      pair bonus file specified."
    inputBinding:
      position: 102
      prefix: --experimentalPairBonus
  - id: experimental_pair_bonus_intercept
    type:
      - 'null'
      - float
    doc: "Specify an intercept (overall offset) to use with the 2D experimental pair\n\
      \    bonus file.\n    Default is 0.0 (no change to input bonuses)."
    inputBinding:
      position: 102
      prefix: -xo
  - id: experimental_pair_bonus_scale
    type:
      - 'null'
      - float
    doc: "Specify a number to multiply the experimental pair bonus matrix by.\n  \
      \  Default is 1.0 (no change to input bonuses)."
    inputBinding:
      position: 102
      prefix: -xs
  - id: isolated
    type:
      - 'null'
      - boolean
    doc: "Specify that isolated pairs are allowed.\n    The default is to use a heuristic
      to attempt to forbid isolated pairs\n    during structure prediction."
    inputBinding:
      position: 102
      prefix: --isolated
  - id: max_distance
    type:
      - 'null'
      - int
    doc: "Specify a maximum pairing distance between nucleotides.\n    Default is
      no restriction on distance between pairs."
    inputBinding:
      position: 102
      prefix: --maxdistance
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress display and other unnecessary output.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: shape_constraints_file
    type:
      - 'null'
      - File
    doc: "Specify a SHAPE constraints file to be applied. These constraints are\n\
      \    pseudoenergy constraints.\n    Default is to have no constraints applied."
    inputBinding:
      position: 102
      prefix: --SHAPE
  - id: shape_intercept
    type:
      - 'null'
      - float
    doc: "Specify an intercept used with SHAPE constraints.\n    Default is -0.6 kcal/mol."
    inputBinding:
      position: 102
      prefix: --SHAPEintercept
  - id: shape_slope
    type:
      - 'null'
      - float
    doc: "Specify a slope used with SHAPE constraints.\n    Default is 1.8 kcal/mol."
    inputBinding:
      position: 102
      prefix: --SHAPEslope
  - id: temperature
    type:
      - 'null'
      - float
    doc: "Specify the temperature at which calculation takes place in Kelvin.\n  \
      \  Default is 310.15 K, which is 37 degrees C."
    inputBinding:
      position: 102
      prefix: --temperature
outputs:
  - id: pfs_file
    type: File
    doc: "The name of a partition function save file (PFS) to which output will be\n\
      \    written."
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
