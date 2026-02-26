cwlVersion: v1.2
class: CommandLineTool
baseCommand: rate4site
label: rate4site
doc: "Rate4Site calculates the relative evolutionary rate of each site in a multiple
  sequence alignment (MSA) using a maximum likelihood or an empirical Bayesian approach.\n\
  \nTool homepage: https://github.com/pupkoLab/Rate4Site"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: The alpha parameter of the Gamma distribution. If not provided, it is 
      optimized.
    inputBinding:
      position: 101
      prefix: -a
  - id: inference_method
    type:
      - 'null'
      - string
    doc: "The rate inference method: 'ML' (Maximum Likelihood) or 'EB' (Empirical
      Bayes)."
    default: EB
    inputBinding:
      position: 101
      prefix: -i
  - id: model
    type:
      - 'null'
      - string
    doc: The evolutionary model to use (e.g., JC, HKY, REV for nucleotides; JTT,
      LG, WAG for proteins).
    default: JC
    inputBinding:
      position: 101
      prefix: -m
  - id: msa_file
    type: File
    doc: The input multiple sequence alignment (MSA) file.
    inputBinding:
      position: 101
      prefix: -s
  - id: num_categories
    type:
      - 'null'
      - int
    doc: The number of categories for the discrete Gamma distribution.
    default: 16
    inputBinding:
      position: 101
      prefix: -k
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode (suppress output to screen).
    inputBinding:
      position: 101
      prefix: -q
  - id: reference_sequence
    type:
      - 'null'
      - string
    doc: The name of the reference sequence in the MSA to which the rates will 
      be mapped.
    inputBinding:
      position: 101
      prefix: -r
  - id: tree_file
    type:
      - 'null'
      - File
    doc: The input phylogenetic tree file. If not provided, a neighbor-joining 
      tree is calculated.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file containing the calculated rates.
    outputBinding:
      glob: $(inputs.output_file)
  - id: log_file
    type:
      - 'null'
      - File
    doc: The log file name.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rate4site:v3.0.0-6-deb_cv1
