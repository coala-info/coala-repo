cwlVersion: v1.2
class: CommandLineTool
baseCommand: list
label: seqfu_list
doc: "Print sequences that are present in a list file, which can contains leading
  \">\" or \"@\" characters. Duplicated entries in the list will be ignored.\n\nTool
  homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: list_file
    type: File
    doc: List file containing sequences to print
    inputBinding:
      position: 1
  - id: fastqs
    type:
      type: array
      items: File
    doc: FASTQ files to search within
    inputBinding:
      position: 2
  - id: min_len
    type:
      - 'null'
      - int
    doc: Skip entries smaller than INT
    default: 1
    inputBinding:
      position: 103
      prefix: --min-len
  - id: partial_match
    type:
      - 'null'
      - boolean
    doc: Allow partial matches (UNSUPPORTED)
    inputBinding:
      position: 103
      prefix: --partial-match
  - id: report
    type:
      - 'null'
      - boolean
    doc: Print report of found sequences
    inputBinding:
      position: 103
      prefix: --report
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: --verbose
  - id: with_comments
    type:
      - 'null'
      - boolean
    doc: Include comments in the list file
    inputBinding:
      position: 103
      prefix: --with-comments
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_list.out
