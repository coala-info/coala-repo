cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler csort
label: cooler_csort
doc: "Sort and index a contact list.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: pairs_path
    type: File
    doc: Contacts (i.e. read pairs) text file, optionally compressed.
    inputBinding:
      position: 1
  - id: chromosomes_path
    type: File
    doc: File listing desired chromosomes in the desired order. May be 
      tab-delimited, e.g. a UCSC-style chromsizes file. Contacts mapping to 
      other chromosomes will be discarded.
    inputBinding:
      position: 2
  - id: chrom1_field
    type: int
    doc: chrom1 field number in the input file (starting from 1)
    inputBinding:
      position: 103
      prefix: --chrom1
  - id: chrom2_field
    type: int
    doc: chrom2 field number
    inputBinding:
      position: 103
      prefix: --chrom2
  - id: comment_char
    type:
      - 'null'
      - string
    doc: Comment character to skip header
    default: '#'
    inputBinding:
      position: 103
      prefix: --comment-char
  - id: flip_only
    type:
      - 'null'
      - boolean
    doc: Only flip mates; no sorting or indexing. Write to stdout.
    inputBinding:
      position: 103
      prefix: --flip-only
  - id: index_type
    type:
      - 'null'
      - string
    doc: Select the preset sort and indexing options
    default: pairix
    inputBinding:
      position: 103
      prefix: --index
  - id: num_processors
    type:
      - 'null'
      - int
    doc: Number of processors
    default: 8
    inputBinding:
      position: 103
      prefix: --nproc
  - id: pos1_field
    type: int
    doc: pos1 field number
    inputBinding:
      position: 103
      prefix: --pos1
  - id: pos2_field
    type: int
    doc: pos2 field number
    inputBinding:
      position: 103
      prefix: --pos2
  - id: separator
    type:
      - 'null'
      - string
    doc: Data delimiter in the input file
    default: \t
    inputBinding:
      position: 103
      prefix: --sep
  - id: sort_options
    type:
      - 'null'
      - string
    doc: Quoted list of additional options to `sort` command
    inputBinding:
      position: 103
      prefix: --sort-options
  - id: strand1_field
    type:
      - 'null'
      - int
    doc: strand1 field number (deprecated)
    inputBinding:
      position: 103
      prefix: --strand1
  - id: strand2_field
    type:
      - 'null'
      - int
    doc: strand2 field number (deprecated)
    inputBinding:
      position: 103
      prefix: --strand2
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: Read positions are zero-based
    inputBinding:
      position: 103
      prefix: --zero-based
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output gzip file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
