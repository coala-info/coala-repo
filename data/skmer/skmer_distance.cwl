cwlVersion: v1.2
class: CommandLineTool
baseCommand: skmer_distance
label: skmer_distance
doc: "Compute the distance matrix for a processed library\n\nTool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: library
    type: Directory
    doc: Directory of the input (processed) library
    inputBinding:
      position: 1
  - id: apply_jukes_cantor
    type:
      - 'null'
      - boolean
    doc: Apply Jukes-Cantor transformation to distances. Output 5.0 if not 
      applicable
    inputBinding:
      position: 102
      prefix: -t
  - id: max_processors
    type:
      - 'null'
      - int
    doc: 'Max number of processors to use [1-20]. Default for this machine: 20'
    default: 20
    inputBinding:
      position: 102
      prefix: -p
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output (distances) prefix.
    default: ref-dist-mat
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
stdout: skmer_distance.out
