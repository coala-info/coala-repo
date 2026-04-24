cwlVersion: v1.2
class: CommandLineTool
baseCommand: textHistogram
label: ucsc-texthistogram
doc: "Produce a histogram in text format from a file of numbers.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input file containing numbers to histogram.
    inputBinding:
      position: 1
  - id: bin_count
    type:
      - 'null'
      - int
    doc: Number of bins.
    inputBinding:
      position: 102
      prefix: -binCount
  - id: bin_size
    type:
      - 'null'
      - float
    doc: Size of bin.
    inputBinding:
      position: 102
      prefix: -binSize
  - id: column
    type:
      - 'null'
      - int
    doc: Which column to use (1-based).
    inputBinding:
      position: 102
      prefix: -col
  - id: log
    type:
      - 'null'
      - boolean
    doc: Use log scale.
    inputBinding:
      position: 102
      prefix: -log
  - id: max_val
    type:
      - 'null'
      - float
    doc: Maximum value to include.
    inputBinding:
      position: 102
      prefix: -maxVal
  - id: min_val
    type:
      - 'null'
      - float
    doc: Minimum value to include.
    inputBinding:
      position: 102
      prefix: -minVal
  - id: no_gap
    type:
      - 'null'
      - boolean
    doc: Don't include gaps in histogram.
    inputBinding:
      position: 102
      prefix: -noGap
  - id: real
    type:
      - 'null'
      - boolean
    doc: Values are real numbers (default is integer).
    inputBinding:
      position: 102
      prefix: -real
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-texthistogram:482--h0b57e2e_0
stdout: ucsc-texthistogram.out
