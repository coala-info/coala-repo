cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal_distance
label: kpal_distance
doc: "Calculate the distance between two k-mer profiles. If the files contain more
  than one profile, they are linked by name and processed pairwise.\n\nTool homepage:
  https://github.com/LUMC/kPAL"
inputs:
  - id: input_left
    type: File
    doc: input k-mer profile file (left)
    inputBinding:
      position: 1
  - id: input_right
    type: File
    doc: input k-mer profile file (right)
    inputBinding:
      position: 2
  - id: balance
    type:
      - 'null'
      - boolean
    doc: balance the profiles
    inputBinding:
      position: 103
      prefix: --balance
  - id: custom_pairwise_function
    type:
      - 'null'
      - string
    doc: custom Python pairwise function, specified either by an expression over
      the two NumPy ndarrays "left" and "right" (e.g., "abs(left - right) / 
      (left + right + 1)"), or an importable name (e.g., 
      "package.module.pairwise") that can be called with two ndarrays as 
      arguments
    inputBinding:
      position: 103
      prefix: --pairwise-function
  - id: custom_summary
    type:
      - 'null'
      - string
    doc: custom Python summary function, specified either by an expression over 
      the NumPy ndarray "values" (e.g., "np.max(values)"), or an importable name
      (e.g., "package.module.summary") that can be called with an ndarray as 
      argument
    inputBinding:
      position: 103
      prefix: --custom-summary
  - id: distance_function
    type:
      - 'null'
      - string
    doc: choose distance function
    default: default
    inputBinding:
      position: 103
      prefix: --distance
  - id: pairwise_distance_function
    type:
      - 'null'
      - string
    doc: paiwise distance function for the multiset distance
    default: prod
    inputBinding:
      position: 103
      prefix: --pairwise-distance
  - id: positive
    type:
      - 'null'
      - boolean
    doc: use only positive values
    inputBinding:
      position: 103
      prefix: --positive
  - id: precision
    type:
      - 'null'
      - int
    doc: precision in number of decimals
    default: 10
    inputBinding:
      position: 103
      prefix: -n
  - id: profiles_left
    type:
      - 'null'
      - type: array
        items: string
    doc: 'names of the k-mer profiles to consider (left) (default: all profiles in
      INPUT_LEFT, in alphabetical order'
    inputBinding:
      position: 103
      prefix: --profiles-left
  - id: profiles_right
    type:
      - 'null'
      - type: array
        items: string
    doc: 'names of the k-mer profiles to consider (right) (default: all profiles in
      INPUT_RIGHT, in alphabetical order)'
    inputBinding:
      position: 103
      prefix: --profiles-right
  - id: scale
    type:
      - 'null'
      - boolean
    doc: scale the profiles
    inputBinding:
      position: 103
      prefix: --scale
  - id: scale_down
    type:
      - 'null'
      - boolean
    doc: scale down
    inputBinding:
      position: 103
      prefix: -d
  - id: smooth
    type:
      - 'null'
      - boolean
    doc: smooth the profiles
    inputBinding:
      position: 103
      prefix: --smooth
  - id: summary_function
    type:
      - 'null'
      - string
    doc: summary function for dynamic smoothing
    default: min
    inputBinding:
      position: 103
      prefix: -s
  - id: threshold
    type:
      - 'null'
      - int
    doc: threshold for the summary function
    default: 0
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
stdout: kpal_distance.out
