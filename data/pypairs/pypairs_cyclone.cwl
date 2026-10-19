cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyclone
label: pypairs_cyclone
doc: "Cyclone is a tool for inferring cell cycle phase from single-cell RNA sequencing
  data.\n\nTool homepage: https://github.com/rfechtner/pypairs"
inputs:
  - id: data
    type: File
    doc: Path to the data matrix where rows correspond to cells and columns to 
      genes.
    inputBinding:
      position: 1
      prefix: --data
  - id: sep
    type: ['null', string]
    doc: 'Seperator used for data (default: ",")'
    inputBinding:
      position: 2
      prefix: --sep
  - id: transpose
    type: ['null', boolean]
    doc: Set flag to transpose matrix
    inputBinding:
      position: 3
      prefix: --transpose
  - id: out
    type: ['null', string]
    doc: Store score to csv
    inputBinding:
      position: 4
      prefix: --out
  - id: marker_pairs
    type: ['null', File]
    doc: Path to marker pairs .json. If not provided default marker pairs are 
      used
    inputBinding:
      position: 5
      prefix: --marker_pairs
  - id: iterations
    type: ['null', int]
    doc: 'An integer specifying the number of iterations for random sampling to 
      obtain a cycle score (default: 1000).'
    inputBinding:
      position: 6
      prefix: --iterations
  - id: min_iter
    type: ['null', int]
    doc: 'An integer specifying the minimum number of iterations for score 
      estimation (default: 100).'
    inputBinding:
      position: 7
      prefix: --min_iter
  - id: min_pairs
    type: ['null', int]
    doc: 'An integer specifying the minimum number of pairs for cycle estimation
      (default: 50).'
    inputBinding:
      position: 8
      prefix: --min_pairs
  - id: quantile_transform
    type: ['null', boolean]
    doc: Set flag to apply quantile transformation to data
    inputBinding:
      position: 9
      prefix: --quantile_transform
  - id: verbosity
    type: ['null', int]
    doc: 'Set level of verbosity from 1 to 4. Where 1 is minimal and 4 most 
      (default: 3).'
    inputBinding:
      position: 10
      prefix: --verbosity
outputs:
  - id: scores_csv
    type: ['null', File]
    doc: Cell cycle scores written to the --out file
    outputBinding:
      glob: $(inputs.out)
  - id: stdout_scores
    type: stdout
    doc: Scores printed to standard output when --out is not given
stdout: cyclone_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypairs:3.2.3--py_0
