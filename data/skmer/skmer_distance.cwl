cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - skmer
  - distance
label: skmer_distance
doc: "Compute the distance matrix for a processed library\n\nTool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: library
    type: Directory
    doc: Directory of the input (processed) library
    inputBinding:
      position: 100
  - id: output_prefix
    type: string
    default: ref-dist-mat
    doc: Output (distances) prefix
    inputBinding:
      position: 1
      prefix: -o
  - id: apply_jukes_cantor
    type: ['null', boolean]
    doc: Apply Jukes-Cantor transformation to distances. Output 5.0 if not applicable
    inputBinding:
      position: 1
      prefix: -t
  - id: max_processors
    type: ['null', int]
    doc: Max number of processors to use [1-20]
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: distance_matrix
    type: ['null', File]
    doc: Pairwise distance matrix
    outputBinding:
      glob: $(inputs.output_prefix)*.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
