cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal matrix
label: kpal_matrix
doc: "Make a distance matrix between any number of k-mer profiles.\n\nTool homepage:
  https://github.com/LUMC/kPAL"
inputs:
  - id: input
    type: File
    doc: input k-mer profile file
    inputBinding:
      position: 1
  - id: balance
    type:
      - 'null'
      - boolean
    doc: balance the profiles
    inputBinding:
      position: 102
      prefix: --balance
  - id: custom_summary
    type:
      - 'null'
      - string
    doc: custom Python summary function, specified either by an expression over 
      the NumPy ndarray "values" (e.g., "np.max(values)"), or an importable name
      (e.g., "package.module.summary") that can be called with an ndarray as 
      argument
    inputBinding:
      position: 102
      prefix: --custom-summary
  - id: distance_function
    type:
      - 'null'
      - string
    doc: choose distance function
    default: default
    inputBinding:
      position: 102
      prefix: -D
  - id: pairwise_distance_function
    type:
      - 'null'
      - string
    doc: paiwise distance function for the multiset distance
    default: prod
    inputBinding:
      position: 102
      prefix: -P
  - id: pairwise_function
    type:
      - 'null'
      - string
    doc: custom Python pairwise function, specified either by an expression over
      the two NumPy ndarrays "left" and "right" (e.g., "abs(left - right) / 
      (left + right + 1)"), or an importable name (e.g., 
      "package.module.pairwise") that can be called with two ndarrays as 
      arguments
    inputBinding:
      position: 102
      prefix: --pairwise-function
  - id: positive
    type:
      - 'null'
      - boolean
    doc: use only positive values
    inputBinding:
      position: 102
      prefix: --positive
  - id: precision
    type:
      - 'null'
      - int
    doc: precision in number of decimals
    default: 10
    inputBinding:
      position: 102
      prefix: -n
  - id: profiles
    type:
      - 'null'
      - type: array
        items: string
    doc: 'names of the k-mer profiles to consider (default: all profiles in INPUT,
      in alphabetical order)'
    inputBinding:
      position: 102
      prefix: --profiles
  - id: scale
    type:
      - 'null'
      - boolean
    doc: scale the profiles
    inputBinding:
      position: 102
      prefix: --scale
  - id: scale_down
    type:
      - 'null'
      - boolean
    doc: scale down
    inputBinding:
      position: 102
      prefix: -d
  - id: smooth
    type:
      - 'null'
      - boolean
    doc: smooth the profiles
    inputBinding:
      position: 102
      prefix: --smooth
  - id: summary_function
    type:
      - 'null'
      - string
    doc: summary function for dynamic smoothing
    default: min
    inputBinding:
      position: 102
      prefix: -s
  - id: threshold
    type:
      - 'null'
      - int
    doc: threshold for the summary function
    default: 0
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
