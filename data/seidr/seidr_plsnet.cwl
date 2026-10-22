cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plsnet
label: seidr_plsnet
doc: 'PLSNET partial least squares network inference for Seidr


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
  - id: components
    type:
      - 'null'
      - int
    doc: 'The number of PLS components to be considered (default: 5)'
    inputBinding:
      position: 1
      prefix: --components
  - id: ensemble
    type:
      - 'null'
      - int
    doc: 'The ensemble size (default: 1000)'
    inputBinding:
      position: 1
      prefix: --ensemble
  - id: predictor_size
    type:
      - 'null'
      - int
    doc: ' The number of predictors (genes) to be sampled. (default: sqrt(m))'
    inputBinding:
      position: 1
      prefix: --predictor-size
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
    default: plsnet_scores.tsv
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
