cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - demultiplex
  - match
label: nf-demultiplex_demultiplex_match
doc: "Demultiplex one file given a list of barcode tuples.\n\nTool homepage: https://github.com/jfjlaros/demultiplex"
inputs:
  - id: barcodes
    type: File
    doc: barcodes file
    inputBinding:
      position: 1
  - id: input
    type:
      type: array
      items: File
    doc: input files
    inputBinding:
      position: 2
  - id: write_multiple_matches
    type:
      - 'null'
      - boolean
    doc: write multiple matches to separate files
    inputBinding:
      position: 103
      prefix: -f
  - id: levenshtein
    type:
      - 'null'
      - boolean
    doc: use Levenshtein distance
    inputBinding:
      position: 103
      prefix: -d
  - id: mismatch
    type:
      - 'null'
      - int
    doc: number of mismatches (default 1)
    inputBinding:
      position: 103
      prefix: -m
  - id: output_path_path
    type: string
    doc: output directory
    inputBinding:
      position: 104
      prefix: -p
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Path to save demultiplexed files
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
