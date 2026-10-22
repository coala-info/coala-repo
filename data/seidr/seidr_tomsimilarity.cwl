cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tomsimilarity
label: seidr_tomsimilarity
doc: 'Topological overlap matrix as implemented in WGCNA, for Seidr


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
  - id: method
    type:
      - 'null'
      - string
    doc: 'Correlation method: [bicor, pearson] (default: pearson)'
    inputBinding:
      position: 1
      prefix: --method
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
  - id: sft
    type:
      - 'null'
      - float
    doc: 'Soft threshold to apply (0 for autodetection) (default: 0)'
    inputBinding:
      position: 1
      prefix: --sft
  - id: max_power
    type:
      - 'null'
      - int
    doc: 'Maximum power to check for SFT test in auto detection mode (default: 30)'
    inputBinding:
      position: 1
      prefix: --max-power
  - id: sft_cutoff
    type:
      - 'null'
      - float
    doc: 'Soft threshold R^2 cutoff in autodetection mode (default: 0.8)'
    inputBinding:
      position: 1
      prefix: --sft-cutoff
  - id: tom_type
    type:
      - 'null'
      - string
    doc: 'TOM type: unsigned, signed, signed-hybrid (default: signed)'
    inputBinding:
      position: 1
      prefix: --tom-type
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
    default: tom_scores.tsv
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
