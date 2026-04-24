cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylotoast_LDA.py
label: phylotoast_LDA.py
doc: "Performs Latent Dirichlet Allocation (LDA) analysis on phylogenetic data.\n\n\
  Tool homepage: https://github.com/smdabdoub/phylotoast"
inputs:
  - id: input_tree
    type: File
    doc: Input phylogenetic tree file (e.g., Newick format).
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix for output files.
    inputBinding:
      position: 2
  - id: alpha
    type:
      - 'null'
      - float
    doc: Dirichlet prior parameter for topic distribution over documents.
    inputBinding:
      position: 103
      prefix: --alpha
  - id: beta
    type:
      - 'null'
      - float
    doc: Dirichlet prior parameter for word distribution over topics.
    inputBinding:
      position: 103
      prefix: --beta
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Number of Gibbs sampling iterations.
    inputBinding:
      position: 103
      prefix: --num_iterations
  - id: num_topics
    type:
      - 'null'
      - int
    doc: Number of topics (clusters) to identify.
    inputBinding:
      position: 103
      prefix: --num_topics
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator.
    inputBinding:
      position: 103
      prefix: --random_seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
stdout: phylotoast_LDA.py.out
