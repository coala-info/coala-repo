cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwtk
  - merge
label: bwtk_merge
doc: "Average multiple bigWig files together. Order of operations: avg|sum|max|min -> a -> m -> l -> t -> s\n\nTool homepage: https://github.com/bjmt/bwtk"
inputs:
  - id: input_bigwigs
    type:
      type: array
      items: File
    doc: Input bigWig files to merge (two or more)
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: Output bigWig (a gzipped bedGraph with -B)
    inputBinding:
      position: 1
      prefix: -o
  - id: output_bedgraph
    type:
      - 'null'
      - boolean
    doc: Output as bedGraph.gz
    inputBinding:
      position: 1
      prefix: -B
  - id: sum_values
    type:
      - 'null'
      - boolean
    doc: Sum values instead of averaging
    inputBinding:
      position: 1
      prefix: -S
  - id: max_value
    type:
      - 'null'
      - boolean
    doc: Take the max value instead of averaging
    inputBinding:
      position: 1
      prefix: -M
  - id: min_value
    type:
      - 'null'
      - boolean
    doc: Take the min value instead of averaging
    inputBinding:
      position: 1
      prefix: -n
  - id: add_value
    type:
      - 'null'
      - float
    doc: Add this value to scores [0]
    inputBinding:
      position: 1
      prefix: -a
  - id: multiply_value
    type:
      - 'null'
      - float
    doc: Multiply scores by this value [1]
    inputBinding:
      position: 1
      prefix: -m
  - id: log10_transform
    type:
      - 'null'
      - boolean
    doc: log10-transform scores
    inputBinding:
      position: 1
      prefix: -l
  - id: trim_max
    type:
      - 'null'
      - float
    doc: Trim values above this max [Inf]
    inputBinding:
      position: 1
      prefix: -t
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for binning [0]
    inputBinding:
      position: 1
      prefix: -s
outputs:
  - id: output
    type: File
    doc: Merged bigWig (or bedGraph.gz with -B)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
