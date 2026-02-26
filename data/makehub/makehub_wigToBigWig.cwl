cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigToBigWig
label: makehub_wigToBigWig
doc: "Convert ascii format wig file (in fixedStep, variableStep or bedGraph format)
  to binary big wig format (bbi version: 4).\n\nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs:
  - id: input_wig
    type: File
    doc: Input wig file in one of the ascii wiggle formats, but not including 
      track lines
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'A two-column file/URL: <chromosome name> <size in bases>'
    inputBinding:
      position: 2
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of items to bundle in r-tree.
    default: 256
    inputBinding:
      position: 103
      prefix: -blockSize=N
  - id: clip
    type:
      - 'null'
      - boolean
    doc: If set just issue warning messages rather than dying if wig file 
      contains items off end of chromosome or chromosomes that are not in the 
      chrom.sizes file.
    inputBinding:
      position: 103
      prefix: -clip
  - id: fixed_summaries
    type:
      - 'null'
      - boolean
    doc: If set, use a predefined sequence of summary levels.
    inputBinding:
      position: 103
      prefix: -fixedSummaries
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: Number of data points bundled at lowest level.
    default: 1024
    inputBinding:
      position: 103
      prefix: -itemsPerSlot=N
  - id: keep_all_chromosomes
    type:
      - 'null'
      - boolean
    doc: If set, store all chromosomes in b-tree.
    inputBinding:
      position: 103
      prefix: -keepAllChromosomes
  - id: unc
    type:
      - 'null'
      - boolean
    doc: If set, do not use compression.
    inputBinding:
      position: 103
      prefix: -unc
outputs:
  - id: output_bw
    type: File
    doc: Output indexed big wig file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
