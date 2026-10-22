cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - list
label: seqfu_list
doc: "Print sequences that are present in a list file, which\ncan contains leading \">\" or \"@\" characters.\n\
  Duplicated entries in the list will be ignored.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: list_file
    type: File
    doc: List of sequence names
    inputBinding:
      position: 1
  - id: fastqs
    type:
      type: array
      items: File
    doc: FASTA/FASTQ files to read
    inputBinding:
      position: 2
  - id: with_comments
    type:
      - 'null'
      - boolean
    doc: Include comments in the list file
    inputBinding:
      position: 102
      prefix: --with-comments
  - id: partial_match
    type:
      - 'null'
      - boolean
    doc: Allow partial matches (UNSUPPORTED)
    inputBinding:
      position: 102
      prefix: --partial-match
  - id: min_len
    type:
      - 'null'
      - int
    doc: 'Skip entries smaller than INT [default: 1]'
    inputBinding:
      position: 102
      prefix: --min-len
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: report
    type:
      - 'null'
      - boolean
    doc: Print report of found sequences
    inputBinding:
      position: 102
      prefix: --report
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_list.out
