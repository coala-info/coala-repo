cwlVersion: v1.2
class: CommandLineTool
baseCommand: faFilter
label: ucsc-fafilter
doc: "Filter fa records, selecting ones that match the specified conditions. All specified
  conditions must pass to pass a sequence. If no conditions are specified, all records
  will be passed.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_fa
    type: File
    doc: Input fasta file
    inputBinding:
      position: 10
  - id: out_fa
    type: string
    doc: Output fasta file name
    inputBinding:
      position: 11
  - id: name
    type:
      - 'null'
      - string
    doc: Only pass records where name matches wildcard. * matches any string or no
      character, ? matches any single character, anything else must match the character
      exactly.
    inputBinding:
      position: 1
      prefix: -name=
      separate: false
  - id: name_pat_list
    type:
      - 'null'
      - File
    doc: A list of regular expressions, one per line, that will be applied to the
      fasta name the same as -name.
    inputBinding:
      position: 2
      prefix: -namePatList=
      separate: false
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Invert match, select non-matching records.
    inputBinding:
      position: 3
      prefix: -v
  - id: min_size
    type:
      - 'null'
      - int
    doc: Only pass sequences at least this big.
    inputBinding:
      position: 4
      prefix: -minSize=
      separate: false
  - id: max_size
    type:
      - 'null'
      - int
    doc: Only pass sequences this size or smaller.
    inputBinding:
      position: 5
      prefix: -maxSize=
      separate: false
  - id: max_n
    type:
      - 'null'
      - int
    doc: Only pass sequences with fewer than this number of N's.
    inputBinding:
      position: 6
      prefix: -maxN=
      separate: false
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: Removes duplicate sequence ids, keeping the first.
    inputBinding:
      position: 7
      prefix: -uniq
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Make -uniq ignore case so sequence IDs ABC and abc count as dupes.
    inputBinding:
      position: 8
      prefix: -i
outputs:
  - id: output_fa
    type: File
    doc: Output filtered fasta file
    outputBinding:
      glob: $(inputs.out_fa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fafilter:482--h0b57e2e_0
