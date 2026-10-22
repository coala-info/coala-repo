cwlVersion: v1.2
class: CommandLineTool
baseCommand: smina
label: smina
doc: "smina is a fork of AutoDock Vina that is customized to better support scoring
  function development and high-performance docking.\n\nTool homepage: https://sourceforge.net/projects/smina/"
inputs:
  - id: receptor
    type: File
    doc: "Rigid part of the receptor (PDBQT, or any Open Babel format)"
    inputBinding:
      position: 101
      prefix: --receptor
  - id: flex
    type:
      - 'null'
      - File
    doc: "Flexible side chains, if any (PDBQT)"
    inputBinding:
      position: 102
      prefix: --flex
  - id: ligand
    type: File
    doc: "Ligand(s) to dock"
    inputBinding:
      position: 103
      prefix: --ligand
  - id: flexres
    type:
      - 'null'
      - string
    doc: "Flexible side chains specified by comma separated list of chain:resid"
    inputBinding:
      position: 104
      prefix: --flexres
  - id: flexdist_ligand
    type:
      - 'null'
      - File
    doc: "Ligand to use for flexdist"
    inputBinding:
      position: 105
      prefix: --flexdist_ligand
  - id: flexdist
    type:
      - 'null'
      - float
    doc: "Set all side chains within specified distance to flexdist_ligand to flexible"
    inputBinding:
      position: 106
      prefix: --flexdist
  - id: center_x
    type:
      - 'null'
      - float
    doc: "X coordinate of the center of the search box"
    inputBinding:
      position: 107
      prefix: --center_x
  - id: center_y
    type:
      - 'null'
      - float
    doc: "Y coordinate of the center of the search box"
    inputBinding:
      position: 108
      prefix: --center_y
  - id: center_z
    type:
      - 'null'
      - float
    doc: "Z coordinate of the center of the search box"
    inputBinding:
      position: 109
      prefix: --center_z
  - id: size_x
    type:
      - 'null'
      - float
    doc: "Size of the search box in the X dimension (Angstroms)"
    inputBinding:
      position: 110
      prefix: --size_x
  - id: size_y
    type:
      - 'null'
      - float
    doc: "Size of the search box in the Y dimension (Angstroms)"
    inputBinding:
      position: 111
      prefix: --size_y
  - id: size_z
    type:
      - 'null'
      - float
    doc: "Size of the search box in the Z dimension (Angstroms)"
    inputBinding:
      position: 112
      prefix: --size_z
  - id: autobox_ligand
    type:
      - 'null'
      - File
    doc: "Automatically set the search box around the provided ligand file"
    inputBinding:
      position: 113
      prefix: --autobox_ligand
  - id: autobox_add
    type:
      - 'null'
      - float
    doc: "Amount of buffer space to add to the auto-generated box (default +4 on all six sides)"
    inputBinding:
      position: 114
      prefix: --autobox_add
  - id: no_lig
    type:
      - 'null'
      - boolean
    doc: "No ligand; for sampling/minimizing flexible residues"
    inputBinding:
      position: 115
      prefix: --no_lig
  - id: scoring
    type:
      - 'null'
      - string
    doc: "Specify an alternative builtin scoring function (e.g., vina, vinardo, dkoes_fast)"
    inputBinding:
      position: 116
      prefix: --scoring
  - id: custom_scoring
    type:
      - 'null'
      - File
    doc: "Custom scoring function file"
    inputBinding:
      position: 117
      prefix: --custom_scoring
  - id: custom_atoms
    type:
      - 'null'
      - File
    doc: "Custom atom type parameters file"
    inputBinding:
      position: 118
      prefix: --custom_atoms
  - id: score_only
    type:
      - 'null'
      - boolean
    doc: "Score the provided ligand pose"
    inputBinding:
      position: 119
      prefix: --score_only
  - id: local_only
    type:
      - 'null'
      - boolean
    doc: "Local search only using autobox (you probably want to use --minimize)"
    inputBinding:
      position: 120
      prefix: --local_only
  - id: minimize
    type:
      - 'null'
      - boolean
    doc: "Energy minimization"
    inputBinding:
      position: 121
      prefix: --minimize
  - id: randomize_only
    type:
      - 'null'
      - boolean
    doc: "Generate random poses, attempting to avoid clashes"
    inputBinding:
      position: 122
      prefix: --randomize_only
  - id: minimize_iters
    type:
      - 'null'
      - int
    doc: "Number of iterations of steepest descent; default scales with rotors and usually is not sufficient for convergence"
    inputBinding:
      position: 123
      prefix: --minimize_iters
  - id: accurate_line
    type:
      - 'null'
      - boolean
    doc: "Use accurate line search"
    inputBinding:
      position: 124
      prefix: --accurate_line
  - id: minimize_early_term
    type:
      - 'null'
      - boolean
    doc: "Stop minimization before convergence conditions are fully met"
    inputBinding:
      position: 125
      prefix: --minimize_early_term
  - id: approximation
    type:
      - 'null'
      - string
    doc: "Approximation (linear, spline, or exact) to use"
    inputBinding:
      position: 126
      prefix: --approximation
  - id: factor
    type:
      - 'null'
      - float
    doc: "Approximation factor: higher results in a finer-grained approximation"
    inputBinding:
      position: 127
      prefix: --factor
  - id: force_cap
    type:
      - 'null'
      - float
    doc: "Max allowed force; lower values more gently minimize clashing structures"
    inputBinding:
      position: 128
      prefix: --force_cap
  - id: user_grid
    type:
      - 'null'
      - File
    doc: "Autodock map file for user grid data based calculations"
    inputBinding:
      position: 129
      prefix: --user_grid
  - id: user_grid_lambda
    type:
      - 'null'
      - float
    doc: "Scales user_grid and functional scoring (default -1)"
    inputBinding:
      position: 130
      prefix: --user_grid_lambda
  - id: print_terms
    type:
      - 'null'
      - boolean
    doc: "Print all available terms with default parameterizations"
    inputBinding:
      position: 131
      prefix: --print_terms
  - id: print_atom_types
    type:
      - 'null'
      - boolean
    doc: "Print all available atom types"
    inputBinding:
      position: 132
      prefix: --print_atom_types
  - id: out_flex_path
    type:
      - 'null'
      - string
    doc: "Output file for flexible receptor residues"
    inputBinding:
      position: 133
      prefix: --out_flex
  - id: atom_terms_path
    type:
      - 'null'
      - string
    doc: "Optionally write per-atom interaction term values"
    inputBinding:
      position: 134
      prefix: --atom_terms
  - id: atom_term_data
    type:
      - 'null'
      - boolean
    doc: "Embed per-atom interaction terms in output sd data"
    inputBinding:
      position: 135
      prefix: --atom_term_data
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of CPUs to use (the default is to try to detect the number of CPUs or, failing that, use 1)"
    inputBinding:
      position: 136
      prefix: --cpu
  - id: seed
    type:
      - 'null'
      - int
    doc: "Explicit random seed"
    inputBinding:
      position: 137
      prefix: --seed
  - id: exhaustiveness
    type:
      - 'null'
      - int
    doc: "Exhaustiveness of the global search (roughly proportional to time; default 8)"
    inputBinding:
      position: 138
      prefix: --exhaustiveness
  - id: num_modes
    type:
      - 'null'
      - int
    doc: "Maximum number of binding modes to generate (default 9)"
    inputBinding:
      position: 139
      prefix: --num_modes
  - id: energy_range
    type:
      - 'null'
      - float
    doc: "Maximum energy difference between the best binding mode and the worst one displayed (kcal/mol; default 3)"
    inputBinding:
      position: 140
      prefix: --energy_range
  - id: min_rmsd_filter
    type:
      - 'null'
      - float
    doc: "RMSD value used to filter final poses to remove redundancy (default 1)"
    inputBinding:
      position: 141
      prefix: --min_rmsd_filter
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress output messages"
    inputBinding:
      position: 142
      prefix: --quiet
  - id: addH
    type:
      - 'null'
      - string
    doc: "Automatically add hydrogens in ligands (on by default; give off to disable)"
    inputBinding:
      position: 143
      prefix: --addH
  - id: config
    type:
      - 'null'
      - File
    doc: "Configuration file; the options above can be put there"
    inputBinding:
      position: 144
      prefix: --config
  - id: log_path
    type:
      - 'null'
      - string
    doc: "Optionally, write log file"
    inputBinding:
      position: 145
      prefix: --log
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output file name; the format is taken from the file extension"
    inputBinding:
      position: 146
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (docking scores table)
  - id: output
    type:
      - 'null'
      - File
    doc: Docked poses written to the --out file
    outputBinding:
      glob: $(inputs.output_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Optionally, write log file
    outputBinding:
      glob: $(inputs.log_path)
  - id: out_flex
    type:
      - 'null'
      - File
    doc: Output file for flexible receptor residues
    outputBinding:
      glob: $(inputs.out_flex_path)
  - id: atom_terms
    type:
      - 'null'
      - File
    doc: Per-atom interaction term values
    outputBinding:
      glob: $(inputs.atom_terms_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smina:2017.11.9--0
stdout: smina.out
