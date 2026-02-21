cwlVersion: v1.2
class: CommandLineTool
baseCommand: sort
label: coreutils_sort
doc: "Write sorted concatenation of all FILE(s) to standard output.\n\nTool homepage:
  https://github.com/uutils/coreutils"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to be sorted and concatenated.
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: merge at most NMERGE inputs at once
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: use SIZE for main memory buffer
    inputBinding:
      position: 102
      prefix: --buffer-size
  - id: check
    type:
      - 'null'
      - string
    doc: check for sorted input; do not sort. Can be 'diagnose-first', 'quiet', or
      'silent'.
    inputBinding:
      position: 102
      prefix: --check
  - id: compress_program
    type:
      - 'null'
      - string
    doc: compress temporaries with PROG; decompress them with PROG -d
    inputBinding:
      position: 102
      prefix: --compress-program
  - id: debug
    type:
      - 'null'
      - boolean
    doc: annotate the part of the line used to sort, and warn about questionable usage
      to stderr
    inputBinding:
      position: 102
      prefix: --debug
  - id: dictionary_order
    type:
      - 'null'
      - boolean
    doc: consider only blanks and alphanumeric characters
    inputBinding:
      position: 102
      prefix: --dictionary-order
  - id: field_separator
    type:
      - 'null'
      - string
    doc: use SEP instead of non-blank to blank transition
    inputBinding:
      position: 102
      prefix: --field-separator
  - id: files0_from
    type:
      - 'null'
      - File
    doc: read input from the files specified by NUL-terminated names in file F
    inputBinding:
      position: 102
      prefix: --files0-from
  - id: general_numeric_sort
    type:
      - 'null'
      - boolean
    doc: compare according to general numerical value
    inputBinding:
      position: 102
      prefix: --general-numeric-sort
  - id: human_numeric_sort
    type:
      - 'null'
      - boolean
    doc: compare human readable numbers (e.g., 2K 1G)
    inputBinding:
      position: 102
      prefix: --human-numeric-sort
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: fold lower case to upper case characters
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: ignore_leading_blanks
    type:
      - 'null'
      - boolean
    doc: ignore leading blanks
    inputBinding:
      position: 102
      prefix: --ignore-leading-blanks
  - id: ignore_nonprinting
    type:
      - 'null'
      - boolean
    doc: consider only printable characters
    inputBinding:
      position: 102
      prefix: --ignore-nonprinting
  - id: key
    type:
      - 'null'
      - string
    doc: sort via a key; KEYDEF gives location and type
    inputBinding:
      position: 102
      prefix: --key
  - id: merge
    type:
      - 'null'
      - boolean
    doc: merge already sorted files; do not sort
    inputBinding:
      position: 102
      prefix: --merge
  - id: month_sort
    type:
      - 'null'
      - boolean
    doc: compare (unknown) < 'JAN' < ... < 'DEC'
    inputBinding:
      position: 102
      prefix: --month-sort
  - id: numeric_sort
    type:
      - 'null'
      - boolean
    doc: compare according to string numerical value
    inputBinding:
      position: 102
      prefix: --numeric-sort
  - id: parallel
    type:
      - 'null'
      - int
    doc: change the number of sorts run concurrently to N
    inputBinding:
      position: 102
      prefix: --parallel
  - id: random_sort
    type:
      - 'null'
      - boolean
    doc: shuffle, but group identical keys
    inputBinding:
      position: 102
      prefix: --random-sort
  - id: random_source
    type:
      - 'null'
      - File
    doc: get random bytes from FILE
    inputBinding:
      position: 102
      prefix: --random-source
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse the result of comparisons
    inputBinding:
      position: 102
      prefix: --reverse
  - id: sort_mode
    type:
      - 'null'
      - string
    doc: 'sort according to WORD: general-numeric -g, human-numeric -h, month -M,
      numeric -n, random -R, version -V'
    inputBinding:
      position: 102
      prefix: --sort
  - id: stable
    type:
      - 'null'
      - boolean
    doc: stabilize sort by disabling last-resort comparison
    inputBinding:
      position: 102
      prefix: --stable
  - id: temporary_directory
    type:
      - 'null'
      - type: array
        items: Directory
    doc: use DIR for temporaries, not $TMPDIR or /tmp; multiple options specify multiple
      directories
    inputBinding:
      position: 102
      prefix: --temporary-directory
  - id: unique
    type:
      - 'null'
      - boolean
    doc: with -c, check for strict ordering; without -c, output only the first of
      an equal run
    inputBinding:
      position: 102
      prefix: --unique
  - id: version_sort
    type:
      - 'null'
      - boolean
    doc: natural sort of (version) numbers within text
    inputBinding:
      position: 102
      prefix: --version-sort
  - id: zero_terminated
    type:
      - 'null'
      - boolean
    doc: line delimiter is NUL, not newline
    inputBinding:
      position: 102
      prefix: --zero-terminated
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: write result to FILE instead of standard output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
