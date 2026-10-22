cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svm-ensemble
label: seidr_svm-ensemble
doc: 'SVM ensemble network inference for Seidr


  Tool homepage: https://github.com/bschiffthaler/seidr'
inputs:
  - id: infile
    type: File
    doc: The expression table (without headers)
    inputBinding:
      position: 1
      prefix: --infile
  - id: genes
    type: File
    doc: File containing gene names
    inputBinding:
      position: 1
      prefix: --genes
  - id: scale
    type:
      - 'null'
      - boolean
    doc: (deprecated) Transform data to z-scores
    inputBinding:
      position: 1
      prefix: --scale
  - id: no_scale
    type:
      - 'null'
      - boolean
    doc: Do not transform data to z-scores
    inputBinding:
      position: 1
      prefix: --no-scale
  - id: type
    type:
      - 'null'
      - string
    doc: 'SVM type [NU_SVR, EPSILON_SVR] (default: EPSILON_SVR)'
    inputBinding:
      position: 1
      prefix: --type
  - id: kernel
    type:
      - 'null'
      - string
    doc: 'SVM kernel [LINEAR, POLY, RBF, SIGMOID] (default: LINEAR)'
    inputBinding:
      position: 1
      prefix: --kernel
  - id: degree
    type:
      - 'null'
      - int
    doc: 'Polynomial degree (for POLY kernel) (default: 3)'
    inputBinding:
      position: 1
      prefix: --degree
  - id: gamma
    type:
      - 'null'
      - float
    doc: 'Kernel coefficient for POLY/RBF/SIGMOID kernels (default: 0.01)'
    inputBinding:
      position: 1
      prefix: --gamma
  - id: coef
    type:
      - 'null'
      - float
    doc: 'Independent term in kernel function (for POLY/SIGMOID kernels) (default:
      0.01)'
    inputBinding:
      position: 1
      prefix: --coef
  - id: nu
    type:
      - 'null'
      - float
    doc: 'nu value (for NU_SVR) (default: 0.5)'
    inputBinding:
      position: 1
      prefix: --nu
  - id: penalty
    type:
      - 'null'
      - float
    doc: 'Penalty C value (default: 1)'
    inputBinding:
      position: 1
      prefix: --penalty
  - id: tol
    type:
      - 'null'
      - float
    doc: 'Epsilon/tolerance (stopping criterion) (default: 0.001)'
    inputBinding:
      position: 1
      prefix: --tol
  - id: eps
    type:
      - 'null'
      - float
    doc: 'Epsilon (for EPSILON_SVR) (default: 0.1)'
    inputBinding:
      position: 1
      prefix: --eps
  - id: shrinking
    type:
      - 'null'
      - int
    doc: 'Whether to use the shrinking heuristic [0: off, 1: on] (default: 1)'
    inputBinding:
      position: 1
      prefix: --shrinking
  - id: ensemble
    type:
      - 'null'
      - int
    doc: 'The ensemble size (default: 1000)'
    inputBinding:
      position: 1
      prefix: --ensemble
  - id: min_predictor_size
    type:
      - 'null'
      - int
    doc: ' The minimum absolute number of predictors (genes) to be sampled. (default:
      20% of predictors)'
    inputBinding:
      position: 1
      prefix: --min-predictor-size
  - id: max_predictor_size
    type:
      - 'null'
      - int
    doc: ' The maximum absolute number of predictors (genes) to be sampled (default:
      80% of predictors)'
    inputBinding:
      position: 1
      prefix: --max-predictor-size
  - id: min_experiment_size
    type:
      - 'null'
      - int
    doc: ' The minimum absolute number of experiments (samples) to be sampled (default:
      20% of experiments)'
    inputBinding:
      position: 1
      prefix: --min-experiment-size
  - id: max_experiment_size
    type:
      - 'null'
      - int
    doc: ' The maximum absolute number of experiments (samples) to be sampled (default:
      80% of experiments)'
    inputBinding:
      position: 1
      prefix: --max-experiment-size
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'Number of genes in MPI batch (default: 0)'
    inputBinding:
      position: 1
      prefix: --batch-size
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Temporary directory path
    inputBinding:
      position: 1
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of OpenMP threads per MPI task (default: 20)'
    inputBinding:
      position: 1
      prefix: --threads
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite if output already exists
    inputBinding:
      position: 1
      prefix: --force
  - id: targets
    type:
      - 'null'
      - File
    doc: File containing gene names of genes of interest. The network will only be
      calculated using these as the sources of potential connections.
    inputBinding:
      position: 1
      prefix: --targets
  - id: outfile
    type: string
    default: svm_scores.tsv
    doc: Output file path
    inputBinding:
      position: 1
      prefix: --outfile
  - id: save_resume
    type:
      - 'null'
      - string
    doc: Path to a file that stores job resume info.
    inputBinding:
      position: 1
      prefix: --save-resume
  - id: resume_from
    type:
      - 'null'
      - File
    doc: Try to resume job from this file.
    inputBinding:
      position: 1
      prefix: --resume-from
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level (lower is less verbose) (default: 3)'
    inputBinding:
      position: 1
      prefix: --verbosity
outputs:
  - id: scores
    type: File
    doc: Network scores
    outputBinding:
      glob: $(inputs.outfile)
  - id: resume_file
    type:
      - 'null'
      - File
    doc: Resume information file
    outputBinding:
      glob: $(inputs.save_resume)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
