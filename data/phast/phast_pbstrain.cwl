cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_pbstrain
label: phast_pbstrain
doc: "Trains a PAML-style substitution model for a given set of sequences.\n\nTool
  homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: input_sequences
    type: File
    doc: Input alignment file (e.g., FASTA, PHYLIP, MAF)
    inputBinding:
      position: 1
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Convergence threshold for EM algorithm
    inputBinding:
      position: 102
      prefix: --epsilon
  - id: gamma
    type:
      - 'null'
      - boolean
    doc: Use a gamma distribution for ASRV
    inputBinding:
      position: 102
      prefix: --gamma
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of EM algorithm iterations
    inputBinding:
      position: 102
      prefix: --iterations
  - id: model
    type:
      - 'null'
      - string
    doc: Substitution model to use (e.g., JC69, K80, HKY85, GTR)
    inputBinding:
      position: 102
      prefix: --model
  - id: rate_categories
    type:
      - 'null'
      - int
    doc: Number of rate categories for among-site rate variation (ASRV)
    inputBinding:
      position: 102
      prefix: --rate-categories
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
    doc: Print verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: output_model_path
    type: string
    doc: Output or path parameter `output_model_path`
    inputBinding:
      position: 103
      prefix: --output-model
outputs:
  - id: output_model
    type:
      - 'null'
      - File
    doc: File to write the trained substitution model to
    outputBinding:
      glob: $(inputs.output_model_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
