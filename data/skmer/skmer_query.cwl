cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - skmer
  - query
label: skmer_query
doc: "Compare an input genome-skim or assembly against a reference library\n\nTool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: input
    type: File
    doc: Input (query) genome-skim or assembly (a .fastq/.fq/.fa/.fna/.fasta file)
    inputBinding:
      position: 100
  - id: library
    type: Directory
    doc: Directory of (reference) library
    inputBinding:
      position: 101
  - id: add_to_library
    type: ['null', boolean]
    doc: Add the processed input (query) to the (reference) library
    inputBinding:
      position: 1
      prefix: -a
  - id: output_prefix
    type: string
    default: dist
    doc: Output (distances) prefix
    inputBinding:
      position: 1
      prefix: -o
  - id: base_error_rate
    type: ['null', float]
    doc: Base error rate. By default, the error rate is automatically estimated
    inputBinding:
      position: 1
      prefix: -e
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
  - id: distances
    type: ['null', File]
    doc: Distances between the query and the reference library
    outputBinding:
      glob: $(inputs.output_prefix)*.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
