cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_clean
label: smof_clean
doc: "Remove all space within the sequences and write them in even columns (default
  width of 80 characters). Case and all characters (except whitespace) are preserved
  by default.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence (default = stdin)
    inputBinding:
      position: 1
  - id: col_width
    type:
      - 'null'
      - int
    doc: width of the sequence output (0 indicates no wrapping)
    inputBinding:
      position: 102
      prefix: --col_width
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The regex delimiter used by --reduce-header
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: mask_irregular
    type:
      - 'null'
      - boolean
    doc: converts irregular letters to unknown
    inputBinding:
      position: 102
      prefix: --mask-irregular
  - id: mask_lowercase
    type:
      - 'null'
      - boolean
    doc: convert lower-case to unknown
    inputBinding:
      position: 102
      prefix: --mask-lowercase
  - id: reduce_header
    type:
      - 'null'
      - boolean
    doc: Remove all text from header that follows the first word (delimited by 
      the value of the --delimiter argument, '[ |]' by default)
    inputBinding:
      position: 102
      prefix: --reduce-header
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: sequence type
    inputBinding:
      position: 102
      prefix: --type
  - id: standardize
    type:
      - 'null'
      - boolean
    doc: Convert 'X' in DNA to 'N' and '[._]' to '-' (for gaps)
    inputBinding:
      position: 102
      prefix: --standardize
  - id: tolower
    type:
      - 'null'
      - boolean
    doc: convert to lowercase
    inputBinding:
      position: 102
      prefix: --tolower
  - id: toseq
    type:
      - 'null'
      - boolean
    doc: removes all non-letter characters (gaps, stops, etc.)
    inputBinding:
      position: 102
      prefix: --toseq
  - id: toupper
    type:
      - 'null'
      - boolean
    doc: convert to uppercase
    inputBinding:
      position: 102
      prefix: --toupper
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_clean.out
