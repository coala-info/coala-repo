cwlVersion: v1.2
class: CommandLineTool
baseCommand: Fold
label: rnastructure_Fold
doc: "Predicts the secondary structure of a nucleic acid sequence using the RNAstructure
  library.\n\nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs:
  - id: sequence_file
    type: File
    doc: The name of a file containing an input sequence. Acceptable formats 
      include SEQ, FASTA and raw-sequence plain-text files. If the name is a 
      hyphen (-), the file will be read from standard input (STDIN).
    inputBinding:
      position: 1
  - id: allow_isolated_base_pairs
    type:
      - 'null'
      - boolean
    doc: Allow isolated base pairs. The default is to use a heuristic to forbid 
      isolated base pairs.
    inputBinding:
      position: 102
      prefix: --isolated
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Specify the name of a folding alphabet and associated nearest neighbor 
      parameters. The alphabet is the prefix for the thermodynamic parameter 
      files, e.g. "rna" for RNA parameters or "dna" for DNA parameters or a 
      custom extended/modified alphabet. The thermodynamic parameters need to 
      reside in the at the location indicated by environment variable DATAPATH. 
      The default is "rna" (i.e. use RNA parameters). This option overrides the 
      --DNA flag.
    inputBinding:
      position: 102
      prefix: --alphabet
  - id: bootstrap_iterations
    type:
      - 'null'
      - int
    doc: Specify the number of bootstrap iterations to be done to retrieve base 
      pair confidence. Defaults to no bootstrapping.
    inputBinding:
      position: 102
      prefix: --bootstrap
  - id: bracket
    type:
      - 'null'
      - boolean
    doc: Write the predicted structure in dot-bracket notation (DBN) instead of 
      CT format.
    inputBinding:
      position: 102
      prefix: --bracket
  - id: cmct_constraints_file
    type:
      - 'null'
      - File
    doc: Specify a CMCT constraints file to be applied. These constraints are 
      pseudoenergy constraints. Default is to have no constraints applied.
    inputBinding:
      position: 102
      prefix: --CMCT
  - id: constraints_file
    type:
      - 'null'
      - File
    doc: Specify a constraints file to be applied. Default is to have no 
      constraints applied.
    inputBinding:
      position: 102
      prefix: --constraint
  - id: disable_coax
    type:
      - 'null'
      - boolean
    doc: Specify that coaxial stacking recusions should not be used. This option
      uses a less realistic energy function in exchange for a faster 
      calculation.
    inputBinding:
      position: 102
      prefix: --disablecoax
  - id: dms_restraints_file
    type:
      - 'null'
      - File
    doc: Specify a DMS restraints file to be applied. These restraints are 
      pseudoenergy constraints. Default is to have no restraints applied.
    inputBinding:
      position: 102
      prefix: --DMS
  - id: dmsnt_restraint_file
    type:
      - 'null'
      - File
    doc: Specify a DMS NT restraint file to be applied. These restraints are 
      pseudoenergy constraints applied with NT-specific potentials. Default is 
      to have no restraints applied.
    inputBinding:
      position: 102
      prefix: --DMSNT
  - id: dna
    type:
      - 'null'
      - boolean
    doc: Specify that the sequence is DNA, and DNA parameters are to be used. 
      Default is to use RNA parameters.
    inputBinding:
      position: 102
      prefix: --DNA
  - id: double_offset_file
    type:
      - 'null'
      - File
    doc: Specify a double-stranded offset file, which adds energy bonuses to 
      particular double-stranded nucleotides. Default is to have no 
      double-stranded offset specified.
    inputBinding:
      position: 102
      prefix: --doubleOffset
  - id: dshape_restraints_file
    type:
      - 'null'
      - File
    doc: Specify a differential SHAPE restraints file to be applied. These 
      constraints are pseudoenergy restraints. Default is to have no restraints 
      applied.
    inputBinding:
      position: 102
      prefix: --DSHAPE
  - id: dshape_slope
    type:
      - 'null'
      - float
    doc: Specify a slope used with differential SHAPE restraints. Default is 
      2.11 kcal/mol.
    inputBinding:
      position: 102
      prefix: --DSHAPEslope
  - id: experimental_pair_bonus_file
    type:
      - 'null'
      - File
    doc: Input text file with bonuses (in kcal) as a matrix. As with SHAPE, 
      bonuses will be applied twice to internal base pairs, once to edge base 
      pairs, and not at all to single stranded regions. Default is no 
      experimental pair bonus file specified.
    inputBinding:
      position: 102
      prefix: --experimentalPairBonus
  - id: experimental_pair_bonus_intercept
    type:
      - 'null'
      - float
    doc: Specify an intercept (overall offset) to use with the 2D experimental 
      pair bonus file. Default is 0.0 (no change to input bonuses).
    inputBinding:
      position: 102
      prefix: -xo
  - id: experimental_pair_bonus_multiplier
    type:
      - 'null'
      - float
    doc: Specify a number to multiply the experimental pair bonus matrix by. 
      Default is 1.0 (no change to input bonuses).
    inputBinding:
      position: 102
      prefix: -xs
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Specify a maximum pairing distance between nucleotides. Default is no 
      restriction on distance between pairs.
    inputBinding:
      position: 102
      prefix: --maxdistance
  - id: max_loop_size
    type:
      - 'null'
      - int
    doc: Specify a maximum internal/bulge loop size. Default is 30 unpaired 
      nucleotides.
    inputBinding:
      position: 102
      prefix: --loop
  - id: max_percent_energy_difference
    type:
      - 'null'
      - float
    doc: Specify a maximum percent energy difference. Default is 10 percent 
      (specified as 10, not 0.1).
    inputBinding:
      position: 102
      prefix: --percent
  - id: max_structures
    type:
      - 'null'
      - int
    doc: Specify a maximum number of structures. Default is 20 structures.
    inputBinding:
      position: 102
      prefix: --maximum
  - id: mfe
    type:
      - 'null'
      - boolean
    doc: Specify that only the minimum free energy structure is needed. No 
      savefiles can be generated. This saves nearly half the calculation time, 
      but provides less information.
    inputBinding:
      position: 102
      prefix: --MFE
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress unnecessary output. This option is implied when the output 
      file is '-' (STDOUT).
    inputBinding:
      position: 102
      prefix: --quiet
  - id: save_file
    type:
      - 'null'
      - File
    doc: Specify the name of a save file, needed for dotplots and refolding. 
      Default is not to generate a save file.
    inputBinding:
      position: 102
      prefix: --save
  - id: sequence_name
    type:
      - 'null'
      - string
    doc: Specify a name for the sequence. This will override the name in the 
      sequence file.
    inputBinding:
      position: 102
      prefix: --name
  - id: shape_intercept
    type:
      - 'null'
      - float
    doc: Specify an intercept used with SHAPE restraints. Default is -0.6 
      kcal/mol.
    inputBinding:
      position: 102
      prefix: --SHAPEintercept
  - id: shape_restraints_file
    type:
      - 'null'
      - File
    doc: Specify a SHAPE restraints file to be applied. These constraints are 
      pseudoenergy restraints. Default is to have no restraints applied.
    inputBinding:
      position: 102
      prefix: --SHAPE
  - id: shape_slope
    type:
      - 'null'
      - float
    doc: Specify a slope used with SHAPE renstraints. Default is 1.8 kcal/mol.
    inputBinding:
      position: 102
      prefix: --SHAPEslope
  - id: simple_iloops
    type:
      - 'null'
      - boolean
    doc: Specify that the O(N^3) internal loop search should be used. This 
      speeds up the calculation if large internal loops are allowed using the -l
      option.
    inputBinding:
      position: 102
      prefix: --simple_iloops
  - id: single_offset_file
    type:
      - 'null'
      - File
    doc: Specify a single-stranded offset file, which adds energy bonuses to 
      particular single-stranded nucleotides. Default is to have no 
      single-stranded offset specified.
    inputBinding:
      position: 102
      prefix: --singleOffset
  - id: temperature
    type:
      - 'null'
      - float
    doc: Specify the temperature at which calculation takes place in Kelvin. 
      Default is 310.15 K, which is 37 degrees C.
    inputBinding:
      position: 102
      prefix: --temperature
  - id: unpaired_shape_intercept
    type:
      - 'null'
      - float
    doc: Specify an intercept used with unpaired SHAPE constraints. Default is 0
      kcal/mol.
    inputBinding:
      position: 102
      prefix: --unpairedSHAPEintercept
  - id: unpaired_shape_slope
    type:
      - 'null'
      - float
    doc: Specify a slope used with unpaired SHAPE constraints. Default is 0 
      kcal/mol.
    inputBinding:
      position: 102
      prefix: --unpairedSHAPEslope
  - id: warnings
    type:
      - 'null'
      - string
    doc: 'Set the behavior for non-critical warnings (e.g. related to invalid nucleotide
      positions or duplicate data points in SHAPE data). Valid values are: * on --
      Warnings are written to standard output. (default) * err -- Warnings are sent
      to STDERR. This can be used in automated scripts etc to detect problems. * off
      -- Do not display warnings at all (not recommended).'
    inputBinding:
      position: 102
      prefix: --warnings
  - id: window_size
    type:
      - 'null'
      - int
    doc: Specify a window size. Default is determined by the length of the 
      sequence.
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: ct_file
    type: File
    doc: The name of a CT file to which output will be written. If the --bracket
      flag is present, output will be written as a dot-bracket file. If the file
      name is a hyphen (-), the structure will be written to standard output 
      (STDOUT) instead of a file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
