cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwtk
  - adjust
label: bwtk_adjust
doc: "Perform an operation on a bigWig. Order of operations: a -> m -> l -> t -> s\n\nTool homepage: https://github.com/bjmt/bwtk"
inputs:
  - id: input_bigwig
    type: File
    doc: Input bigWig file
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type: string
    doc: Output bigWig file (a gzipped bedGraph with -B)
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
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Subset to ranges in a BED file
    inputBinding:
      position: 1
      prefix: -b
  - id: region
    type:
      - 'null'
      - string
    doc: Subset to a single range (chrName:X-Y)
    inputBinding:
      position: 1
      prefix: -r
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
    doc: Adjusted bigWig (or bedGraph.gz with -B)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
