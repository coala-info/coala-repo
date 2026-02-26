cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlRho
label: mlrho_mlRho
doc: "Maximum likelihood estimation of population mutation, recombination, and disequilibrium
  measures\n\nTool homepage: http://guanine.evolbio.mpg.de/mlRho/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s)
    inputBinding:
      position: 1
  - id: corrected_diversity
    type:
      - 'null'
      - boolean
    doc: 'corrected diversity measure according to Lynch (2008), p. 2412; default:
      uncorrected'
    inputBinding:
      position: 102
      prefix: -c
  - id: database_name
    type:
      - 'null'
      - File
    doc: name of database created using formatPro
    default: profileDb
    inputBinding:
      position: 102
      prefix: -n
  - id: first_step_size
    type:
      - 'null'
      - float
    doc: size of first step in ML estimation
    default: '1.000e-04'
    inputBinding:
      position: 102
      prefix: -s
  - id: high_memory_mode
    type:
      - 'null'
      - boolean
    doc: high memory mode; may be faster for disequilibrium analysis
    inputBinding:
      position: 102
      prefix: -o
  - id: initial_delta
    type:
      - 'null'
      - float
    doc: initial delta value
    default: '1.000e-03'
    inputBinding:
      position: 102
      prefix: -D
  - id: initial_epsilon
    type:
      - 'null'
      - float
    doc: initial epsilon value
    default: '1.000e-03'
    inputBinding:
      position: 102
      prefix: -E
  - id: initial_theta
    type:
      - 'null'
      - float
    doc: initial theta value
    default: '1.000e-03'
    inputBinding:
      position: 102
      prefix: -P
  - id: likelihood_weight_fraction
    type:
      - 'null'
      - float
    doc: fraction of likelihood weight included in LD analysis
    default: 0.0
    inputBinding:
      position: 102
      prefix: -f
  - id: lump_distance_classes
    type:
      - 'null'
      - boolean
    doc: 'lump -S distance classes; default: no lumping'
    inputBinding:
      position: 102
      prefix: -L
  - id: max_distance
    type:
      - 'null'
      - float
    doc: maximum distance analyzed in rho computation
    default: all
    inputBinding:
      position: 102
      prefix: -M
  - id: min_distance
    type:
      - 'null'
      - float
    doc: minimum distance analyzed in rho computation
    default: 1
    inputBinding:
      position: 102
      prefix: -m
  - id: simplex_threshold
    type:
      - 'null'
      - float
    doc: simplex size threshold
    default: '1.000e-08'
    inputBinding:
      position: 102
      prefix: -t
  - id: step_size
    type:
      - 'null'
      - float
    doc: step size in rho computation
    default: 1
    inputBinding:
      position: 102
      prefix: -S
  - id: write_likelihoods
    type:
      - 'null'
      - boolean
    doc: 'write likelihoods to file; default: likelihoods not written to file'
    inputBinding:
      position: 102
      prefix: -I
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlrho:2.9--ha9c9cc8_3
stdout: mlrho_mlRho.out
