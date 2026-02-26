cwlVersion: v1.2
class: CommandLineTool
baseCommand: skmer_query
label: skmer_query
doc: "Compare an input genome-skim or assembly against a reference library\n\nTool
  homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: input
    type: File
    doc: Input (query) genome-skim or assembly (.fastq/.fq/.fa/.fna/.fasta file)
    inputBinding:
      position: 1
  - id: library
    type: Directory
    doc: Directory of (reference) library
    inputBinding:
      position: 2
  - id: add_to_library
    type:
      - 'null'
      - boolean
    doc: Add the processed input (query) to the (reference) library
    inputBinding:
      position: 103
      prefix: -a
  - id: apply_jukes_cantor
    type:
      - 'null'
      - boolean
    doc: Apply Jukes-Cantor transformation to distances. Output 5.0 if not 
      applicable
    inputBinding:
      position: 103
      prefix: -t
  - id: base_error_rate
    type:
      - 'null'
      - float
    doc: Base error rate. By default, the error rate is automatically estimated.
    inputBinding:
      position: 103
      prefix: -e
  - id: max_processors
    type:
      - 'null'
      - int
    doc: Max number of processors to use [1-20]
    default: 20
    inputBinding:
      position: 103
      prefix: -p
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output (distances) prefix
    default: dist
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
stdout: skmer_query.out
