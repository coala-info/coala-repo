cwlVersion: v1.2
class: CommandLineTool
baseCommand: smetana
label: smetana
doc: "Calculate SMETANA scores for one or multiple microbial communities.\n\nTool
  homepage: https://github.com/cdanielmachado/smetana"
inputs:
  - id: models
    type:
      type: array
      items: File
    doc: "Multiple single-species models (one or more files).\n                  \
      \      \nYou can use wild-cards, for example: models/*.xml, and optionally protect
      with quotes to avoid automatic bash\n                        expansion (this
      will be faster for long lists): \"models/*.xml\"."
    inputBinding:
      position: 1
  - id: abiotic
    type:
      - 'null'
      - string
    doc: Test abiotic perturbations with given list of compounds.
    inputBinding:
      position: 102
      prefix: --abiotic
  - id: abiotic_rm
    type:
      - 'null'
      - string
    doc: Test abiotic perturbations (removing compounds from media).
    inputBinding:
      position: 102
      prefix: --abiotic-rm
  - id: aerobic
    type:
      - 'null'
      - boolean
    doc: Simulate an aerobic environment.
    inputBinding:
      position: 102
      prefix: --aerobic
  - id: anaerobic
    type:
      - 'null'
      - boolean
    doc: Simulate an anaerobic environment.
    inputBinding:
      position: 102
      prefix: --anaerobic
  - id: biotic
    type:
      - 'null'
      - string
    doc: Test biotic perturbations with given list of species.
    inputBinding:
      position: 102
      prefix: --biotic
  - id: communities_tsv
    type:
      - 'null'
      - File
    doc: "Run SMETANA for multiple (sub)communities.\nThe communities must be specified
      in a two-column tab-separated file with community and organism identifiers.\n\
      The organism identifiers should match the file names in the SBML files (without
      extension).\n\nExample:\n    community1\torganism1\n    community1\torganism2\n\
      \    community2\torganism1\n    community2\torganism3"
    inputBinding:
      position: 102
      prefix: --communities
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: Run detailed SMETANA analysis (slower).
    inputBinding:
      position: 102
      prefix: --detailed
  - id: exclude
    type:
      - 'null'
      - string
    doc: 'List of compounds to exclude from calculations (e.g.: inorganic compounds).'
    inputBinding:
      position: 102
      prefix: --exclude
  - id: flavor
    type:
      - 'null'
      - string
    doc: Expected SBML flavor of the input files (cobra or fbc2).
    inputBinding:
      position: 102
      prefix: --flavor
  - id: global
    type:
      - 'null'
      - boolean
    doc: Run global analysis with MIP/MRO (faster).
    inputBinding:
      position: 102
      prefix: --global
  - id: media
    type:
      - 'null'
      - string
    doc: Run SMETANA for given media (comma-separated).
    inputBinding:
      position: 102
      prefix: --media
  - id: mediadb
    type:
      - 'null'
      - File
    doc: Media database file
    inputBinding:
      position: 102
      prefix: --mediadb
  - id: molweight
    type:
      - 'null'
      - boolean
    doc: Use molecular weight minimization (recomended).
    inputBinding:
      position: 102
      prefix: --molweight
  - id: no_coupling
    type:
      - 'null'
      - boolean
    doc: Don't compute species coupling scores.
    inputBinding:
      position: 102
      prefix: --no-coupling
  - id: num_perturbation_experiments
    type:
      - 'null'
      - int
    doc: "Number of random perturbation experiments per community (default: 1).\n\
      \                        Selecting n = 0 will test all single species/compound
      perturbations exactly once."
    default: 1
    inputBinding:
      position: 102
      prefix: -n
  - id: perturbation_count
    type:
      - 'null'
      - int
    doc: 'Number of components to perturb simultaneously (default: 1).'
    default: 1
    inputBinding:
      position: 102
      prefix: -p
  - id: solver
    type:
      - 'null'
      - string
    doc: "Change default solver (current options: 'gurobi', 'cplex')."
    inputBinding:
      position: 102
      prefix: --solver
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Switch to verbose mode
    inputBinding:
      position: 102
      prefix: --verbose
  - id: zeros
    type:
      - 'null'
      - boolean
    doc: Include entries with zero score.
    inputBinding:
      position: 102
      prefix: --zeros
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Prefix for output file(s).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smetana:1.2.1--pyhdfd78af_0
