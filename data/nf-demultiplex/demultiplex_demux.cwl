cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - demultiplex
  - demux
label: demultiplex_demux
doc: "Demultiplex any number of files given a list of barcodes.\n\nTool homepage:
  https://github.com/jfjlaros/demultiplex"
inputs:
  - id: barcodes
    type: File
    doc: barcodes file
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: input files
    inputBinding:
      position: 2
  - id: end
    type:
      - 'null'
      - string
    doc: end of the selection
    default: None
    inputBinding:
      position: 103
      prefix: -e
  - id: extract_barcodes
    type:
      - 'null'
      - boolean
    doc: extract the barcodes from the read
    default: false
    inputBinding:
      position: 103
      prefix: -r
  - id: format
    type:
      - 'null'
      - string
    doc: provdide the header format
    default: None
    inputBinding:
      position: 103
      prefix: --format
  - id: mismatch
    type:
      - 'null'
      - int
    doc: number of mismatches
    default: 1
    inputBinding:
      position: 103
      prefix: -m
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    default: .
    inputBinding:
      position: 103
      prefix: -p
  - id: start
    type:
      - 'null'
      - string
    doc: start of the selection
    default: None
    inputBinding:
      position: 103
      prefix: -s
  - id: use_levenshtein_distance
    type:
      - 'null'
      - boolean
    doc: use Levenshtein distance
    default: false
    inputBinding:
      position: 103
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
stdout: demultiplex_demux.out
