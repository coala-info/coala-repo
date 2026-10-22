cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - clean
label: smof_clean
doc: "Remove all space within the sequences and write them in even columns (default width of 80 characters).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: type
    type:
      - 'null'
      - string
    doc: "Sequence type: n (nucleotide) or p (protein)"
    inputBinding:
      position: 100
      prefix: --type
  - id: toupper
    type:
      - 'null'
      - boolean
    doc: "Convert to uppercase"
    inputBinding:
      position: 101
      prefix: --toupper
  - id: tolower
    type:
      - 'null'
      - boolean
    doc: "Convert to lowercase"
    inputBinding:
      position: 102
      prefix: --tolower
  - id: toseq
    type:
      - 'null'
      - boolean
    doc: "Removes all non-letter characters (gaps, stops, etc.)"
    inputBinding:
      position: 103
      prefix: --toseq
  - id: reduce_header
    type:
      - 'null'
      - boolean
    doc: "Remove all text from header that follows the first word (delimited by --delimiter, '[ |]' by default)"
    inputBinding:
      position: 104
      prefix: --reduce-header
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "The regex delimiter used by --reduce-header"
    inputBinding:
      position: 105
      prefix: --delimiter
  - id: mask_irregular
    type:
      - 'null'
      - boolean
    doc: "Converts irregular letters to unknown"
    inputBinding:
      position: 106
      prefix: --mask-irregular
  - id: mask_lowercase
    type:
      - 'null'
      - boolean
    doc: "Convert lower-case to unknown"
    inputBinding:
      position: 107
      prefix: --mask-lowercase
  - id: col_width
    type:
      - 'null'
      - int
    doc: "Width of the sequence output (0 indicates no wrapping)"
    inputBinding:
      position: 108
      prefix: --col_width
  - id: standardize
    type:
      - 'null'
      - boolean
    doc: "Convert 'X' in DNA to 'N' and '[._]' to '-' (for gaps)"
    inputBinding:
      position: 109
      prefix: --standardize
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_clean.out
