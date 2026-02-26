cwlVersion: v1.2
class: CommandLineTool
baseCommand: orna_ORNA
label: orna_ORNA
doc: "ORNA options\n\nTool homepage: https://github.com/SchulzLab/ORNA"
inputs:
  - id: base
    type:
      - 'null'
      - float
    doc: Base for the logarithmic function
    default: 1.7
    inputBinding:
      position: 101
      prefix: -base
  - id: binsize
    type:
      - 'null'
      - int
    doc: Bin Size
    default: 1000
    inputBinding:
      position: 101
      prefix: -binsize
  - id: collect_stat
    type:
      - 'null'
      - string
    doc: Collect stat
    default: '0'
    inputBinding:
      position: 101
      prefix: -cs
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input File
    default: ORNAERROR
    inputBinding:
      position: 101
      prefix: -input
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer required
    default: 21
    inputBinding:
      position: 101
      prefix: -kmer
  - id: ksorting
    type:
      - 'null'
      - string
    doc: Kmer based Sorting
    default: '0'
    inputBinding:
      position: 101
      prefix: -ksorting
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    default: 0
    inputBinding:
      position: 101
      prefix: -nb-cores
  - id: output
    type:
      - 'null'
      - string
    doc: Prefix of the output File
    default: Normalized
    inputBinding:
      position: 101
      prefix: -output
  - id: output_type
    type:
      - 'null'
      - string
    doc: Type for the output file (fasta/fastq)
    default: fasta
    inputBinding:
      position: 101
      prefix: -type
  - id: pair1
    type:
      - 'null'
      - string
    doc: First read of the pair
    default: ORNAERROR
    inputBinding:
      position: 101
      prefix: -pair1
  - id: pair2
    type:
      - 'null'
      - string
    doc: Second read of the pair
    default: ORNAERROR
    inputBinding:
      position: 101
      prefix: -pair2
  - id: sorting
    type:
      - 'null'
      - string
    doc: Quality Sorting
    default: '0'
    inputBinding:
      position: 101
      prefix: -sorting
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 1
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orna:2.0--he52c88d_0
stdout: orna_ORNA.out
