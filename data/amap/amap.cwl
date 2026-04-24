cwlVersion: v1.2
class: CommandLineTool
baseCommand: amap
label: amap
doc: "Align multiple protein sequences and print to standard output using sequence
  annealing alignment\n\nTool homepage: https://web.archive.org/web/20060902044446/http://bio.math.berkeley.edu/amap/"
inputs:
  - id: mfa_files
    type:
      - 'null'
      - type: array
        items: File
    doc: MFAFILE(s) containing sequences to align
    inputBinding:
      position: 1
  - id: alignment_order
    type:
      - 'null'
      - boolean
    doc: 'print sequences in alignment order rather than input order (default: off)'
    inputBinding:
      position: 102
      prefix: --alignment-order
  - id: clustalw
    type:
      - 'null'
      - boolean
    doc: use CLUSTALW output format instead of MFA
    inputBinding:
      position: 102
      prefix: -clustalw
  - id: consistency
    type:
      - 'null'
      - int
    doc: 'use 0 <= REPS <= 5 (default: 0) passes of consistency transformation'
    inputBinding:
      position: 102
      prefix: --consistency
  - id: edge_weight_threshold
    type:
      - 'null'
      - float
    doc: 'stop the sequence annealing process when best edge has lower weight than
      W, set to 0 for best sensitivity, higher values for better specificity (default:
      0)'
    inputBinding:
      position: 102
      prefix: --edge-weight-threshold
  - id: emissions
    type:
      - 'null'
      - boolean
    doc: 'also reestimate emission probabilities (default: off)'
    inputBinding:
      position: 102
      prefix: --emissions
  - id: gap_factor
    type:
      - 'null'
      - float
    doc: 'use GF as the gap-factor parameter, set to 0 for best sensitivity, higher
      values for better specificity (default: 1)'
    inputBinding:
      position: 102
      prefix: --gap-factor
  - id: gui
    type:
      - 'null'
      - type: array
        items: float
    doc: print output for the AMAP Display Java based GUI; takes optional START weight
      and STEP size
    inputBinding:
      position: 102
      prefix: -gui
  - id: iterative_refinement
    type:
      - 'null'
      - int
    doc: 'use 0 <= REPS <= 1000 (default: 0) passes of iterative-refinement'
    inputBinding:
      position: 102
      prefix: --iterative-refinement
  - id: no_edge_reordering
    type:
      - 'null'
      - boolean
    doc: 'disable reordring of edges during sequence annealing alignment (default:
      off)'
    inputBinding:
      position: 102
      prefix: --no-edge-reordering
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: generate all-pairs pairwise alignments
    inputBinding:
      position: 102
      prefix: -pairs
  - id: paramfile
    type:
      - 'null'
      - File
    doc: read parameters from FILENAME
    inputBinding:
      position: 102
      prefix: --paramfile
  - id: pre_training
    type:
      - 'null'
      - int
    doc: 'use 0 <= REPS <= 20 (default: 0) rounds of pretraining'
    inputBinding:
      position: 102
      prefix: --pre-training
  - id: print_posteriors
    type:
      - 'null'
      - boolean
    doc: 'only print the posterior probability matrices (default: off)'
    inputBinding:
      position: 102
      prefix: --print-posteriors
  - id: progressive
    type:
      - 'null'
      - boolean
    doc: 'use progresive alignment instead of sequence annealing alignment (default:
      off)'
    inputBinding:
      position: 102
      prefix: --progressive
  - id: use_max_stepsize
    type:
      - 'null'
      - boolean
    doc: 'use maximum improvement step size instead of tGf edge ranking (default:
      off)'
    inputBinding:
      position: 102
      prefix: --use-max-stepsize
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'report progress while aligning (default: off)'
    inputBinding:
      position: 102
      prefix: --verbose
  - id: viterbi
    type:
      - 'null'
      - boolean
    doc: use Viterbi algorithm to generate all pairs (automatically enables -pairs)
    inputBinding:
      position: 102
      prefix: -viterbi
outputs:
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: write annotation for multiple alignment to FILENAME
    outputBinding:
      glob: $(inputs.annotation_file)
  - id: train
    type:
      - 'null'
      - File
    doc: 'compute EM transition probabilities, store in FILENAME (default: no training)'
    outputBinding:
      glob: $(inputs.train)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amap:2.2--h6bb024c_0
