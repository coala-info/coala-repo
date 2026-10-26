cwlVersion: v1.2
class: CommandLineTool
baseCommand: textHistogram
label: ucsc-texthistogram
doc: "Make a histogram in ascii. The input file contains one number per line.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input file containing one number per line.
    inputBinding:
      position: 2
  - id: bin_size
    type:
      - 'null'
      - float
    doc: Size of bins, default 1.
    inputBinding:
      position: 1
      prefix: -binSize=
      separate: false
  - id: max_bin_count
    type:
      - 'null'
      - int
    doc: Maximum number of bins, default 25.
    inputBinding:
      position: 1
      prefix: -maxBinCount=
      separate: false
  - id: min_val
    type:
      - 'null'
      - float
    doc: Minimum value to put in histogram, default 0.
    inputBinding:
      position: 1
      prefix: -minVal=
      separate: false
  - id: log
    type:
      - 'null'
      - boolean
    doc: Do log transformation before plotting.
    inputBinding:
      position: 1
      prefix: -log
  - id: no_star
    type:
      - 'null'
      - boolean
    doc: Do not draw asterisks.
    inputBinding:
      position: 1
      prefix: -noStar
  - id: column
    type:
      - 'null'
      - int
    doc: Which column to use. Default 1.
    inputBinding:
      position: 1
      prefix: -col=
      separate: false
  - id: ave_col
    type:
      - 'null'
      - int
    doc: A second column to average over. The averages are output in place of counts of the primary column.
    inputBinding:
      position: 1
      prefix: -aveCol=
      separate: false
  - id: real
    type:
      - 'null'
      - boolean
    doc: Data input are real values (default is integer).
    inputBinding:
      position: 1
      prefix: -real
  - id: auto_scale
    type:
      - 'null'
      - int
    doc: Autoscale to N number of bins.
    inputBinding:
      position: 1
      prefix: -autoScale=
      separate: false
  - id: prob_values
    type:
      - 'null'
      - boolean
    doc: Show prob-values (density and cumulative distribution); sets -noStar too.
    inputBinding:
      position: 1
      prefix: -probValues
  - id: freq
    type:
      - 'null'
      - boolean
    doc: Show frequencies instead of counts.
    inputBinding:
      position: 1
      prefix: -freq
  - id: skip
    type:
      - 'null'
      - int
    doc: Skip N lines before starting, default 0.
    inputBinding:
      position: 1
      prefix: -skip=
      separate: false
outputs:
  - id: histogram
    type: stdout
    doc: Text histogram
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-texthistogram:482--h0b57e2e_0
stdout: ucsc-texthistogram.out
