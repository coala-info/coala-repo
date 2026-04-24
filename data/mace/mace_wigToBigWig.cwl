cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigToBigWig
label: mace_wigToBigWig
doc: "Convert ascii format wig file (in fixedStep, variableStep or bedGraph format)
  to binary big wig format.\n\nTool homepage: http://chipexo.sourceforge.net"
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
    inputBinding:
      position: 103
      prefix: -blockSize
  - id: clip
    type:
      - 'null'
      - boolean
    doc: If set just issue warning messages rather than dying if wig file 
      contains items off end of chromosome.
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
    inputBinding:
      position: 103
      prefix: -itemsPerSlot
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
    dockerPull: quay.io/biocontainers/mace:1.2--py27h99da42f_0
