cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_consentropy
label: phast_consentropy
doc: "Calculate conservation scores for each column in a multiple sequence alignment.\n\
  \nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: input_file
    type: File
    doc: Input multiple sequence alignment file (e.g., MAF, FASTA)
    inputBinding:
      position: 1
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Small value to add to frequencies to avoid division by zero
    inputBinding:
      position: 102
      prefix: --epsilon
  - id: msa_format
    type:
      - 'null'
      - string
    doc: Format of the input MSA (maf, fasta, phylip)
    inputBinding:
      position: 102
      prefix: --msa-format
  - id: rate_categories
    type:
      - 'null'
      - int
    doc: Number of rate categories for the gamma distribution
    inputBinding:
      position: 102
      prefix: --rate-categories
  - id: scoring_matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix to use (e.g., HKY, JC69)
    inputBinding:
      position: 102
      prefix: --scoring-matrix
  - id: tree
    type:
      - 'null'
      - File
    doc: Phylogenetic tree file (e.g., Newick format)
    inputBinding:
      position: 102
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for conservation scores
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
