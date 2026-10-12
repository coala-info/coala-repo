cwlVersion: v1.2
class: CommandLineTool
baseCommand: qvality
label: percolator_qvality
doc: "Calculate score, PEP and q-value directly from target and null (decoy) scores,\
  \ or from a file of p-values.\n\nTool homepage: https://github.com/percolator/percolator"
inputs:
  - id: target_file
    type: File
    doc: File with scores from the mixed (target) model, separated by whitespace
      or line feed. Alternatively, a single file of accurate p-values.
    inputBinding:
      position: 200
  - id: null_file
    type:
      - 'null'
      - File
    doc: File with scores from the null (decoy) model; leave out when target_file
      holds p-values
    inputBinding:
      position: 201
  - id: epsilon_cross_validation
    type:
      - 'null'
      - float
    doc: The relative crossvalidation step size used as threshold before ending
      the iterations
    inputBinding:
      position: 101
      prefix: --epsilon-cross-validation
  - id: epsilon_step
    type:
      - 'null'
      - float
    doc: The relative step size used as threshold before cross validation error
      is calculated
    inputBinding:
      position: 101
      prefix: --epsilon-step
  - id: include_negative
    type:
      - 'null'
      - boolean
    doc: Include negative hits (decoy) probabilities in the results
    inputBinding:
      position: 101
      prefix: --include-negative
  - id: number_of_bins
    type:
      - 'null'
      - int
    doc: The number of spline knots used when interpolating spline function
      (default 500)
    inputBinding:
      position: 101
      prefix: --number-of-bins
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Indicating that the scoring mechanism is reversed, i.e., that low scores
      are better than higher scores
    inputBinding:
      position: 101
      prefix: --reverse
  - id: tdc_input
    type:
      - 'null'
      - boolean
    doc: Turns off the pi0 correction for search results from a concatenated
      database
    inputBinding:
      position: 101
      prefix: --tdc-input
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbosity of output: 0=no processing info, 5=all, default is 2'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output results to file instead of stdout
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Table of score, PEP and q-value
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/percolator:3.7.1--h3b5f4bd_2
stdout: percolator_qvality.out
