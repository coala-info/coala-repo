cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastagap.pl
label: fastagap
doc: "Report or replace/remove missing-data characters in fasta. Can identify and
  manipulate leading, trailing, and inner gap regions. Reads fasta-formatted files
  and writes to stdout as fasta or tab-separated output.\n\nTool homepage: https://github.com/nylander/fastagap"
inputs:
  - id: input_fasta
    type: File
    doc: Input fasta-formatted file
    inputBinding:
      position: 1
  - id: count
    type:
      - 'null'
      - boolean
    doc: Count and report. Do not print sequences.
    inputBinding:
      position: 102
      prefix: --count
  - id: decimals
    type:
      - 'null'
      - int
    doc: Use <nr> decimals for ratios in output. Default is 4.
    default: 4
    inputBinding:
      position: 102
      prefix: --decimals
  - id: max_length
    type:
      - 'null'
      - int
    doc: Print sequence if (unfiltered) length is maximun <nr> positions. This 
      option can not be combined with the removal options.
    inputBinding:
      position: 102
  - id: min_length
    type:
      - 'null'
      - int
    doc: Print sequence if (unfiltered) length is minimum <nr> positions. This 
      option can not be combined with the removal options.
    inputBinding:
      position: 102
  - id: missing_symbol
    type:
      - 'null'
      - string
    doc: Character or Perl regex to use as missing symbol. Default is '-'.
    inputBinding:
      position: 102
      prefix: --missing
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress printing of header in table output (use together with '-c').
    inputBinding:
      position: 102
      prefix: --no-header
  - id: remove_all
    type:
      - 'null'
      - boolean
    doc: Remove all missing symbols from sequences. (Default)
    inputBinding:
      position: 102
      prefix: --remove-all
  - id: remove_all_percentage
    type:
      - 'null'
      - float
    doc: Remove sequence if total amount of missing data exceeds <number> (in 
      percentage). That is, allow 1 - <number> percent missing data.
    inputBinding:
      position: 102
      prefix: --remove-allp
  - id: remove_empty
    type:
      - 'null'
      - boolean
    doc: Explicitly remove empty sequences, i.e., fasta entries with header 
      only.
    inputBinding:
      position: 102
      prefix: --remove-empty
  - id: remove_inner
    type:
      - 'null'
      - boolean
    doc: Remove all inner missing symbols from sequences.
    inputBinding:
      position: 102
      prefix: --remove-inner
  - id: remove_inner_percentage
    type:
      - 'null'
      - float
    doc: Remove sequence if total amount of missing inner data exceeds <number> 
      percent.
    inputBinding:
      position: 102
      prefix: --remove-innerp
  - id: remove_leading
    type:
      - 'null'
      - boolean
    doc: Remove all leading missing symbols from sequences.
    inputBinding:
      position: 102
      prefix: --remove-leading
  - id: remove_leading_percentage
    type:
      - 'null'
      - float
    doc: Remove sequence if total amount of leading missing data exceeds 
      <number> percent.
    inputBinding:
      position: 102
      prefix: --remove-leadingp
  - id: remove_leading_trailing_percentage
    type:
      - 'null'
      - float
    doc: Remove sequence if the sum of leading- and trailing missing data 
      exceeds <number> percent.
    inputBinding:
      position: 102
      prefix: --remove-leadingtrailingp
  - id: remove_trailing
    type:
      - 'null'
      - boolean
    doc: Remove all trailing missing symbols from sequences.
    inputBinding:
      position: 102
      prefix: --remove-trailing
  - id: remove_trailing_percentage
    type:
      - 'null'
      - float
    doc: Remove sequence if total amount of trailing missing data exceeds 
      <number> percent.
    inputBinding:
      position: 102
      prefix: --remove-trailingp
  - id: replace_all
    type:
      - 'null'
      - string
    doc: Replace all missing symbols with <char> in sequences.
    inputBinding:
      position: 102
      prefix: --replace-all
  - id: replace_inner
    type:
      - 'null'
      - string
    doc: Replace all inner missing symbols with <char> in sequences.
    inputBinding:
      position: 102
      prefix: --replace-inner
  - id: replace_leading
    type:
      - 'null'
      - string
    doc: Replace all leading missing symbols with <char> in sequences.
    inputBinding:
      position: 102
      prefix: --replace-leading
  - id: replace_trailing
    type:
      - 'null'
      - string
    doc: Replace all trailing missing symbols with <char> in sequences.
    inputBinding:
      position: 102
      prefix: --replace-trailing
  - id: set_missing_N
    type:
      - 'null'
      - boolean
    doc: Set missing symbol to 'N' (case sensitive).
    inputBinding:
      position: 102
      prefix: -N
  - id: set_missing_Q
    type:
      - 'null'
      - boolean
    doc: Set missing symbol to '?'.
    inputBinding:
      position: 102
      prefix: -Q
  - id: set_missing_X
    type:
      - 'null'
      - boolean
    doc: Set missing symbol to 'X'.
    inputBinding:
      position: 102
      prefix: -X
  - id: set_missing_hyphen
    type:
      - 'null'
      - boolean
    doc: Set missing symbol to hyphen ('-'). (Default)
    inputBinding:
      position: 102
      prefix: -G
  - id: shortcut_Z
    type:
      - 'null'
      - boolean
    doc: Shortcut for '-A -N -Q -G -X --noverbose'.
    inputBinding:
      position: 102
      prefix: -Z
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: Print tab-separated output (header tab sequence).
    inputBinding:
      position: 102
      prefix: --tabulate
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: Convert sequence to uppercase. Note that the conversion is done before 
      applying any (case sensitive) removal/replacements.
    inputBinding:
      position: 102
      prefix: -uc
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print warnings when replacements are attempted on empty sequences.
    inputBinding:
      position: 102
      prefix: --Verbose
  - id: wrap
    type:
      - 'null'
      - int
    doc: Wrap fasta sequence to max length <nr>. Default is 60.
    default: 60
    inputBinding:
      position: 102
      prefix: --wrap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastagap:1.0.1--hdfd78af_0
stdout: fastagap.out
