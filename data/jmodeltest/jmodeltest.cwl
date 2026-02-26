cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmodeltest
label: jmodeltest
doc: "jModelTest is a tool to carry out statistical selection of best-fit models of
  nucleotide substitution. It implements five different model selection strategies:
  hierarchical likelihood ratio tests (hLRTs), Akaike information criterion (AIC),
  Bayesian information criterion (BIC), decision theory method (DT), and performance-based
  approach (PBA).\n\nTool homepage: https://github.com/ddarriba/jmodeltest2"
inputs:
  - id: akaike_information_criterion
    type:
      - 'null'
      - boolean
    doc: Calculate the Akaike Information Criterion
    inputBinding:
      position: 101
      prefix: -AIC
  - id: base_frequencies
    type:
      - 'null'
      - boolean
    doc: Include models with unequal base frequencies
    inputBinding:
      position: 101
      prefix: -f
  - id: base_tree
    type:
      - 'null'
      - string
    doc: Base tree for likelihood calculations (fixed or BIONJ)
    inputBinding:
      position: 101
      prefix: -t
  - id: bayesian_information_criterion
    type:
      - 'null'
      - boolean
    doc: Calculate the Bayesian Information Criterion
    inputBinding:
      position: 101
      prefix: -BIC
  - id: corrected_akaike_information_criterion
    type:
      - 'null'
      - boolean
    doc: Calculate the corrected Akaike Information Criterion
    inputBinding:
      position: 101
      prefix: -AICc
  - id: decision_theory
    type:
      - 'null'
      - boolean
    doc: Calculate the Decision Theory criterion
    inputBinding:
      position: 101
      prefix: -DT
  - id: gamma_rate
    type:
      - 'null'
      - boolean
    doc: Include models with rate variation among sites (Gamma distribution)
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: File
    doc: Input data file (Phylip format)
    inputBinding:
      position: 101
      prefix: -d
  - id: invariable_sites
    type:
      - 'null'
      - boolean
    doc: Include models with a proportion of invariable sites
    inputBinding:
      position: 101
      prefix: -i
  - id: num_categories
    type:
      - 'null'
      - int
    doc: Number of categories for the discrete Gamma distribution
    inputBinding:
      position: 101
      prefix: -ncat
  - id: schemes
    type:
      - 'null'
      - int
    doc: Number of substitution schemes (3, 5, 7, 11, 203, or 1624)
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -tr
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jmodeltest:v2.1.10dfsg-7-deb_cv1
