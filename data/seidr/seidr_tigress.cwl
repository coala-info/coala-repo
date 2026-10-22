cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigress
label: seidr_tigress
doc: 'TIGRESS network inference for Seidr


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
  - id: nlambda
    type:
      - 'null'
      - int
    doc: 'The maximum number of lambda values (default: 10)'
    inputBinding:
      position: 1
      prefix: --nlambda
  - id: min_lambda
    type:
      - 'null'
      - float
    doc: 'The minimum lambda as a fraction of the maximum. (default: 0.3)'
    inputBinding:
      position: 1
      prefix: --min-lambda
  - id: allow_low_var
    type:
      - 'null'
      - boolean
    doc: Disable low variance filter when subsampling data (at your own risk)
    inputBinding:
      position: 1
      prefix: --allow-low-var
  - id: ensemble
    type:
      - 'null'
      - int
    doc: 'The ensemble size (default: 1000)'
    inputBinding:
      position: 1
      prefix: --ensemble
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
    default: tigress_scores.tsv
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
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite if output already exists
    inputBinding:
      position: 1
      prefix: --force
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
