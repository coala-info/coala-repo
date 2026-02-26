cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - sort-index
label: lyner_sort-index
doc: "Sorts and indexes a matrix.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: inplace
    type:
      - 'null'
      - boolean
    doc: Modify the matrix in place.
    default: true
    inputBinding:
      position: 101
      prefix: --inplace
  - id: kind
    type:
      - 'null'
      - string
    doc: "Sorting algorithm to use. Options: 'quicksort', 'mergesort', 'heapsort',
      'stable'."
    default: mergesort
    inputBinding:
      position: 101
      prefix: --kind
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_sort-index.out
