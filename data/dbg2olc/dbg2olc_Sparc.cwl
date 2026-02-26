cwlVersion: v1.2
class: CommandLineTool
baseCommand: Sparc
label: dbg2olc_Sparc
doc: "dbg2olc_Sparc tool for generating consensus sequences.\n\nTool homepage: https://github.com/yechengxi/DBG2OLC"
inputs:
  - id: backbone_file
    type: File
    doc: backbone file.
    inputBinding:
      position: 1
  - id: mapped_files
    type:
      type: array
      items: File
    doc: the reads mapping files produced by blasr, using option -m 5.
    inputBinding:
      position: 2
  - id: hq_prefix
    type: string
    doc: Shared prefix of the high quality read names.
    inputBinding:
      position: 3
  - id: boost
    type: int
    doc: 'boosting weight for the high quality reads. (range: [1,5])'
    inputBinding:
      position: 104
  - id: coverage_threshold
    type: int
    doc: 'coverage threshold. (range: [1,5])'
    inputBinding:
      position: 104
      prefix: c
  - id: kmer_size
    type: int
    doc: 'k-mer size. (range: [1,5])'
    inputBinding:
      position: 104
      prefix: k
  - id: skip_size
    type: int
    doc: 'skip size, the larger the value, the more memory efficient the algorithm
      is. (range: [1,5])'
    inputBinding:
      position: 104
      prefix: g
outputs:
  - id: consensus_output
    type: File
    doc: Consensus output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
