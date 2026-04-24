cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - antarna.py
label: antarna_antarna.py
doc: "Ant Colony Optimized RNA Sequence Design\n\nTool homepage: https://github.com/RobertKleinkauf/antarna"
inputs:
  - id: mode
    type: string
    doc: "'MFE' (minimum free energy) or 'DP' (dotplot) mode selection"
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - float
    doc: Sets alpha, probability weight for terrain pheromone influence. [0,1]
    inputBinding:
      position: 102
      prefix: --alpha
  - id: ants_per_selection
    type:
      - 'null'
      - int
    doc: best out of k ants.
    inputBinding:
      position: 102
      prefix: --ants_per_selection
  - id: ants_ter_conv
    type:
      - 'null'
      - int
    doc: Delimits the amount of internal ants for termination convergence criterion
      for a reset.
    inputBinding:
      position: 102
      prefix: --antsTerConv
  - id: beta
    type:
      - 'null'
      - float
    doc: Sets beta, probability weight for terrain path influence. [0,1]
    inputBinding:
      position: 102
      prefix: --beta
  - id: cgcweight
    type:
      - 'null'
      - float
    doc: GC content constraint quality weighting factor. [0,1]
    inputBinding:
      position: 102
      prefix: --Cgcweight
  - id: convergence_count
    type:
      - 'null'
      - int
    doc: Delimits the convergence count criterion for a reset.
    inputBinding:
      position: 102
      prefix: --ConvergenceCount
  - id: cseq
    type:
      - 'null'
      - string
    doc: Sequence constraint using RNA nucleotide alphabet {A,C,G,U} and wild-card
      "N".
    inputBinding:
      position: 102
      prefix: --Cseq
  - id: cseqweight
    type:
      - 'null'
      - float
    doc: Sequence constraint quality weighting factor. [0,1]
    inputBinding:
      position: 102
      prefix: --Cseqweight
  - id: cstrweight
    type:
      - 'null'
      - float
    doc: Structure constraint quality weighting factor. [0,1]
    inputBinding:
      position: 102
      prefix: --Cstrweight
  - id: er
    type:
      - 'null'
      - float
    doc: Pheromone evaporation rate.
    inputBinding:
      position: 102
      prefix: --ER
  - id: improve_procedure
    type:
      - 'null'
      - string
    doc: Select the improving method. h=hierarchical, s=score_based.
    inputBinding:
      position: 102
      prefix: --improve_procedure
  - id: level
    type:
      - 'null'
      - int
    doc: Sets the level of allowed influence of sequence constraint on the structure
      constraint [0:no influence; 3:extensive influence].
    inputBinding:
      position: 102
      prefix: --level
  - id: name_tag
    type:
      - 'null'
      - string
    doc: Defines a name which is used in the sequence output.
    inputBinding:
      position: 102
      prefix: --name
  - id: no_gu_base_pair
    type:
      - 'null'
      - boolean
    doc: Forbid GU base pairs.
    inputBinding:
      position: 102
      prefix: --noGUBasePair
  - id: no_lbp_management
    type:
      - 'null'
      - boolean
    doc: Disallowing antaRNA lonely base pair-management.
    inputBinding:
      position: 102
      prefix: --noLBPmanagement
  - id: no_of_colonies
    type:
      - 'null'
      - int
    doc: Number of sequences which shall be produced.
    inputBinding:
      position: 102
      prefix: --noOfColonies
  - id: omega
    type:
      - 'null'
      - float
    doc: Sets the value, which is used in the mimiced 1/x evaluation function in order
      to set a crossing point on the y-axis.
    inputBinding:
      position: 102
      prefix: --omega
  - id: output_verbose
    type:
      - 'null'
      - boolean
    doc: Prints additional features and stats to the headers of the produced sequences.
      Also adds the structure of the sequence.
    inputBinding:
      position: 102
      prefix: --output_verbose
  - id: param_file
    type:
      - 'null'
      - File
    doc: Changes the energy parameterfile of RNAfold. If using this explicitly, please
      provide a suitable energy file delivered by RNAfold.
    inputBinding:
      position: 102
      prefix: --paramFile
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Print Terrain Nodes and edges files.
    inputBinding:
      position: 102
      prefix: --plot
  - id: py
    type:
      - 'null'
      - boolean
    doc: Switch on PYTHON compatible behavior.
    inputBinding:
      position: 102
      prefix: --py
  - id: resets
    type:
      - 'null'
      - int
    doc: Amount of maximal terrain resets, until the best solution is retuned as solution.
    inputBinding:
      position: 102
      prefix: --Resets
  - id: seed
    type:
      - 'null'
      - string
    doc: Provides a seed value for the used pseudo random number generator.
    inputBinding:
      position: 102
      prefix: --seed
  - id: temperature
    type:
      - 'null'
      - float
    doc: Provides a temperature for the folding algorithms.
    inputBinding:
      position: 102
      prefix: --temperature
  - id: tgc
    type: float
    doc: Objective target GC content in [0,1].
    inputBinding:
      position: 102
      prefix: --tGC
  - id: tgcmax
    type:
      - 'null'
      - float
    doc: Provides a maximum tGC value [0,1] for the case of uniform distribution sampling.
      The regular tGC value serves as minimum value.
    inputBinding:
      position: 102
      prefix: --tGCmax
  - id: tgcvar
    type:
      - 'null'
      - float
    doc: Provides a tGC variance (sigma square) for the case of normal distribution
      sampling. The regular tGC value serves as expectation value (mu).
    inputBinding:
      position: 102
      prefix: --tGCvar
  - id: time
    type:
      - 'null'
      - int
    doc: Limiting runtime [seconds]
    inputBinding:
      position: 102
      prefix: --time
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Displayes intermediate output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Provide a path and an output file, e.g. "/path/to/the/target_file".
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/antarna:2.0.1.2--py27_0
