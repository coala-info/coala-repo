cwlVersion: v1.2
class: CommandLineTool
baseCommand: clame
label: clame
doc: "Clasificador Metagenomico\n\nTool homepage: https://github.com/andvides/CLAME"
inputs:
  - id: cut_points
    type:
      - 'null'
      - string
    doc: array of cut points (comma separator) for edges constrains
    default: 0,10000
    inputBinding:
      position: 101
      prefix: -e
  - id: enable_print
    type:
      - 'null'
      - boolean
    doc: enable print output to file
    default: false
    inputBinding:
      position: 101
      prefix: -print
  - id: fm9_file
    type:
      - 'null'
      - boolean
    doc: Load fm9 file
    inputBinding:
      position: 101
      prefix: -fm9
  - id: input_fastq
    type:
      - 'null'
      - boolean
    doc: input file is in a fastq format
    inputBinding:
      position: 101
      prefix: -fastq
  - id: min_bases
    type:
      - 'null'
      - int
    doc: minimum number of bases to take an alignment
    default: 70
    inputBinding:
      position: 101
      prefix: -b
  - id: min_reads_per_bin
    type:
      - 'null'
      - int
    doc: minimum number of reads to report a bin
    default: 1000
    inputBinding:
      position: 101
      prefix: -sizeBin
  - id: multi_fasta_file
    type:
      - 'null'
      - File
    doc: FILE with all the reads
    inputBinding:
      position: 101
      prefix: -multiFasta
  - id: output_file_name
    type:
      - 'null'
      - string
    doc: name for the output-file if print option was selected
    default: output
    inputBinding:
      position: 101
      prefix: -output
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: -nt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clame:1.0--h503566f_3
stdout: clame.out
