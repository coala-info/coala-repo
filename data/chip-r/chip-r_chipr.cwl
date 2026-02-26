cwlVersion: v1.2
class: CommandLineTool
baseCommand: chipr
label: chip-r_chipr
doc: "Combine multiple ChIP-seq files and return a union of all peak locations and
  a set confident, reproducible peaks as determined by rank product analysis\n\nTool
  homepage: https://github.com/rhysnewell/ChIP-R"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: ChIP-seq input files. These files must be in either narrowPeak, 
      broadPeak, or regionPeak format. Multiple inputs are separeted by a single
      space
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - float
    doc: Alpha specifies the user cut-off value for set of reproducible peaks 
      The analysis will still produce results including peaks within the 
      threshold calculatedusing the binomial method
    default: 0.05
    inputBinding:
      position: 102
      prefix: --alpha
  - id: dup_handling
    type:
      - 'null'
      - string
    doc: "Specifies how to handle entries that are ranked equally within a replicate
      Can either take the 'average' ranks or a 'random' rearrangement of the ordinal
      ranks Options: 'average', 'random'"
    default: average
    inputBinding:
      position: 102
      prefix: --duphandling
  - id: fragment
    type:
      - 'null'
      - boolean
    doc: Specifies whether the input peaks will be subject to high levels of 
      fragmentation
    inputBinding:
      position: 102
      prefix: --fragment
  - id: min_entries
    type:
      - 'null'
      - int
    doc: The minimum peaks between replicates required to form an intersection 
      of the peaks
    default: 1
    inputBinding:
      position: 102
      prefix: --minentries
  - id: random_seed
    type:
      - 'null'
      - float
    doc: Specify a seed to be used in conjunction with the 'random' option for 
      -duphandling Must be between 0 and 1
    default: 0.5
    inputBinding:
      position: 102
      prefix: --seed
  - id: rank_method
    type:
      - 'null'
      - string
    doc: "The ranking method used to rank peaks within replicates. Options: 'signalvalue',
      'pvalue', 'qvalue'."
    default: pvalue
    inputBinding:
      position: 102
      prefix: --rankmethod
  - id: size
    type:
      - 'null'
      - int
    doc: Sets the default minimum peak size when peaks are reconnected after 
      fragmentation. Usually the minimum peak size is determined by the size of 
      surrounding peaks, but in the case that there are no surrounding peaks 
      this value will be used
    default: 20
    inputBinding:
      position: 102
      prefix: --size
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: ChIP-seq output filename prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chip-r:1.2.0--pyh3252c3a_0
