cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabix
label: tabix
doc: "Generic indexer for TAB-delimited genome position files. (Note: The provided
  text was an error log; arguments are based on standard tabix usage).\n\nTool homepage:
  https://sourceforge.net/projects/samtools"
inputs:
  - id: input_file
    type: File
    doc: The TAB-delimited file to be indexed (must be bgzip compressed).
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional region(s) to query (e.g., chr1:10-20).
    inputBinding:
      position: 2
  - id: begin_col
    type:
      - 'null'
      - int
    doc: Column number for start positions
    inputBinding:
      position: 103
      prefix: -b
  - id: comment_char
    type:
      - 'null'
      - string
    doc: Skip lines starting with CHAR
    inputBinding:
      position: 103
      prefix: -c
  - id: end_col
    type:
      - 'null'
      - int
    doc: Column number for end positions
    inputBinding:
      position: 103
      prefix: -e
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing index file
    inputBinding:
      position: 103
      prefix: -f
  - id: list_chroms
    type:
      - 'null'
      - boolean
    doc: List chromosome names
    inputBinding:
      position: 103
      prefix: -l
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Input format: gff, bed, sam, vcf'
    inputBinding:
      position: 103
      prefix: -p
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print also the header lines
    inputBinding:
      position: 103
      prefix: -h
  - id: sequence_col
    type:
      - 'null'
      - int
    doc: Column number for sequence names (e.g., chromosome)
    inputBinding:
      position: 103
      prefix: -s
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: Skip first INT lines
    inputBinding:
      position: 103
      prefix: -S
outputs:
  - id: index
    type: File
    secondaryFiles: .tbi
    doc: Compressed input file with tabix index (.tbi) attached as a secondary file.
    outputBinding:
      glob: $(inputs.input_file.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabix:1.11--hdfd78af_0