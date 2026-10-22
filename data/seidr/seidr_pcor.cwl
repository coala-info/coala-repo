cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pcor
label: seidr_pcor
doc: 'Partial correlation network inference for Seidr


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
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Report absolute values
    inputBinding:
      position: 1
      prefix: --absolute
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
    default: pcor_scores.tsv
    doc: Output file path
    inputBinding:
      position: 1
      prefix: --outfile
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
