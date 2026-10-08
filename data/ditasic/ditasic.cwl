cwlVersion: v1.2
class: CommandLineTool
baseCommand: ditasic
label: ditasic
doc: "Differential Taxon Abundance Subtraction and Intersection Counting for accurate
  profiling of metagenomes. Estimates taxon abundances (and differential abundance
  between two samples) from the similarity matrix of ditasic_matrix.py and the
  count vectors of ditasic_mapping.py.\n\nTool homepage: https://rki_bioinformatics.gitlab.io/ditasic/"
inputs:
  - id: refs
    type: File
    doc: Taxa names file containing the absolute path to all considered taxa
      references in this analysis (already required in previous
      'ditasic_mapping' and 'ditasic_matrix')
    inputBinding:
      position: 101
      prefix: --refs
  - id: similarity_matrix
    type: File
    doc: Path to the similarity_matrix.npy file (output of 'ditasic_matrix').
    inputBinding:
      position: 101
      prefix: --Mat
  - id: counts_s1
    type: File
    doc: 'Mapped count vector of sample 1: sample.npy file (default output of
      ditasic_mapping).'
    inputBinding:
      position: 101
      prefix: --counts_s1
  - id: total_s1
    type: File
    doc: 'Total vector of sample 1, containing the total number of input reads:
      total.npy file (default output of ditasic_mapping).'
    inputBinding:
      position: 101
      prefix: --N_s1
  - id: counts_s2
    type:
      - 'null'
      - File
    doc: 'Mapped count vector of sample 2: sample.npy file (default output of
      ditasic_mapping).'
    inputBinding:
      position: 101
      prefix: --counts_s2
  - id: total_s2
    type:
      - 'null'
      - File
    doc: 'Total vector of sample 2, containing the total number of input reads:
      total.npy file (default output of ditasic_mapping).'
    inputBinding:
      position: 101
      prefix: --N_s2
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Apply a filtering to detect and remove false-positive taxa in the data
      (default = F)
    inputBinding:
      position: 101
      prefix: --filter
      valueFrom: '$(self ? "TRUE" : "FALSE")'
  - id: output_name
    type: string
    default: DiffAbund_Result.txt
    doc: Name of the output file
    inputBinding:
      position: 101
      prefix: --output
  - id: pval_thres
    type:
      - 'null'
      - float
    doc: P-value threshold to remove false-positive taxa in case of filtering
      applied (default = 0.05)
    inputBinding:
      position: 101
      prefix: --pval_thres
  - id: min_thres
    type:
      - 'null'
      - int
    doc: Minimum number of reads to assign significant taxa existence (default =
      0)
    inputBinding:
      position: 101
      prefix: --min_thres
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for sampling processes used in creating the empirical
      distributions (default = 1448)
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: output
    type: File
    doc: Abundance (or differential abundance) result table
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ditasic:0.2--py37h470a237_0
