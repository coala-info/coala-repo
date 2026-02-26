cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAsubopt
label: pourrna_RNAsubopt
doc: "calculate suboptimal secondary structures of RNAs\n\nTool homepage: https://github.com/ViennaRNA/pourRNA/"
inputs:
  - id: auto_id
    type:
      - 'null'
      - boolean
    doc: Automatically generate an ID for each sequence.
    default: false
    inputBinding:
      position: 101
      prefix: --auto-id
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Use constraints for multiple sequences.
    default: false
    inputBinding:
      position: 101
      prefix: --batch
  - id: canonical_bp_only
    type:
      - 'null'
      - boolean
    doc: Remove non-canonical base pairs from the structure constraint
    default: false
    inputBinding:
      position: 101
      prefix: --canonicalBPonly
  - id: circ
    type:
      - 'null'
      - boolean
    doc: Assume a circular (instead of linear) RNA molecule.
    default: false
    inputBinding:
      position: 101
      prefix: --circ
  - id: constraint
    type:
      - 'null'
      - File
    doc: Calculate structures subject to constraints.
    default: ''
    inputBinding:
      position: 101
      prefix: --constraint
  - id: dangles
    type:
      - 'null'
      - int
    doc: How to treat "dangling end" energies for bases adjacent to helices in 
      free ends and multi-loops
    default: 2
    inputBinding:
      position: 101
      prefix: --dangles
  - id: delta_energy
    type:
      - 'null'
      - string
    doc: Compute suboptimal structures with energy in a certain range of the 
      optimum (kcal/mol). Default is calculation of mfe structure only.
    inputBinding:
      position: 101
      prefix: --deltaEnergy
  - id: delta_energy_post
    type:
      - 'null'
      - string
    doc: Only print structures with energy within range of the mfe after post 
      reevaluation of energies.
    inputBinding:
      position: 101
      prefix: --deltaEnergyPost
  - id: dos
    type:
      - 'null'
      - boolean
    doc: Compute density of states instead of secondary structures
    default: false
    inputBinding:
      position: 101
      prefix: --dos
  - id: enforce_constraint
    type:
      - 'null'
      - boolean
    doc: Enforce base pairs given by round brackets ( ) in structure constraint
    default: false
    inputBinding:
      position: 101
      prefix: --enforceConstraint
  - id: gquad
    type:
      - 'null'
      - boolean
    doc: Incoorporate G-Quadruplex formation into the structure prediction 
      algorithm (no support of G-quadruplex prediction for stochastic 
      backtracking and Zuker-style suboptimals yet)
    default: false
    inputBinding:
      position: 101
      prefix: --gquad
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: Prefix for automatically generated IDs (as used in output file names)
    default: sequence
    inputBinding:
      position: 101
      prefix: --id-prefix
  - id: infile
    type:
      - 'null'
      - File
    doc: Read a file instead of reading from stdin
    inputBinding:
      position: 101
      prefix: --infile
  - id: log_ml
    type:
      - 'null'
      - boolean
    doc: Recalculate energies of structures using a logarithmic energy function 
      for multi-loops before output.
    default: false
    inputBinding:
      position: 101
      prefix: --logML
  - id: max_bp_span
    type:
      - 'null'
      - int
    doc: Set the maximum base pair span
    default: -1
    inputBinding:
      position: 101
      prefix: --maxBPspan
  - id: no_closing_gu
    type:
      - 'null'
      - boolean
    doc: Do not allow GU pairs at the end of helices
    default: false
    inputBinding:
      position: 101
      prefix: --noClosingGU
  - id: no_conv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitude nucleotide "T" with "U"
    default: false
    inputBinding:
      position: 101
      prefix: --noconv
  - id: no_gu
    type:
      - 'null'
      - boolean
    doc: Do not allow GU pairs
    default: false
    inputBinding:
      position: 101
      prefix: --noGU
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: Produce structures without lonely pairs (helices of length 1).
    default: false
    inputBinding:
      position: 101
      prefix: --noLP
  - id: no_tetra
    type:
      - 'null'
      - boolean
    doc: Do not include special tabulated stabilizing energies for tri-, tetra- 
      and hexaloop hairpins.
    default: false
    inputBinding:
      position: 101
      prefix: --noTetra
  - id: non_redundant
    type:
      - 'null'
      - boolean
    doc: Enable non-redundant sampling strategy.
    default: false
    inputBinding:
      position: 101
      prefix: --nonRedundant
  - id: param_file
    type:
      - 'null'
      - File
    doc: Read energy parameters from paramfile, instead of using the default 
      parameter set.
    inputBinding:
      position: 101
      prefix: --paramFile
  - id: shape
    type:
      - 'null'
      - File
    doc: Use SHAPE reactivity data in the folding recursions (does not work for 
      Zuker suboptimals and stochastic backtracking yet)
    inputBinding:
      position: 101
      prefix: --shape
  - id: shape_conversion
    type:
      - 'null'
      - string
    doc: Specify the method used to convert SHAPE reactivities to pairing 
      probabilities when using the SHAPE approach of Zarringhalam et al.
    default: O
    inputBinding:
      position: 101
      prefix: --shapeConversion
  - id: shape_method
    type:
      - 'null'
      - string
    doc: Specify the method how to convert SHAPE reactivity data to pseudo 
      energy contributions
    default: D
    inputBinding:
      position: 101
      prefix: --shapeMethod
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Sort the suboptimal structures by energy.
    default: false
    inputBinding:
      position: 101
      prefix: --sorted
  - id: stoch_bt
    type:
      - 'null'
      - string
    doc: Instead of producing all suboptimals in an energy range, produce a 
      random sample of suboptimal structures, drawn with probabilities equal to 
      their Boltzmann weights via stochastic backtracking in the partition 
      function. The -e and -p options are mutually exclusive.
    inputBinding:
      position: 101
      prefix: --stochBT
  - id: stoch_bt_en
    type:
      - 'null'
      - string
    doc: Same as "--stochBT" but also print out the energies and probabilities 
      of the backtraced structures.
    inputBinding:
      position: 101
      prefix: --stochBT_en
  - id: temp
    type:
      - 'null'
      - float
    doc: Rescale energy parameters to a temperature of temp C. Default is 37C.
    inputBinding:
      position: 101
      prefix: --temp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: zuker
    type:
      - 'null'
      - boolean
    doc: Compute Zuker suboptimals instead of all suboptimal structures within 
      an engery band around the MFE.
    default: false
    inputBinding:
      position: 101
      prefix: --zuker
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Print output to file instead of stdout
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pourrna:1.2.0--h6bb024c_0
