cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabview
label: tabview
doc: "View a tab-delimited file in a spreadsheet-like display. Press F1 or '?' while
  running for a list of available keybindings.\n\nTool homepage: https://github.com/firecat53/tabview"
inputs:
  - id: filename
    type: File
    doc: File to read. Use '-' to read from the standard input instead.
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: CSV delimiter. Not typically necessary since automatic delimiter 
      sniffing is used.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: double_width
    type:
      - 'null'
      - boolean
    doc: Force full handling of double-width characters for large files (with a 
      performance penalty)
    inputBinding:
      position: 102
      prefix: --double_width
  - id: encoding
    type:
      - 'null'
      - string
    doc: Encoding, if required. If the file is UTF-8, Latin-1(iso8859-1) or a 
      few other common encodings, it should be detected automatically. If not, 
      you can pass 'CP720', or 'iso8859-2', for example.
    inputBinding:
      position: 102
      prefix: --encoding
  - id: quote_char
    type:
      - 'null'
      - string
    doc: Quote character. Not typically necessary.
    inputBinding:
      position: 102
      prefix: --quote-char
  - id: quoting
    type:
      - 'null'
      - string
    doc: CSV quoting style. Not typically required.
    inputBinding:
      position: 102
      prefix: --quoting
  - id: start_pos
    type:
      - 'null'
      - string
    doc: Initial cursor display position. Single number for just y (row) 
      position, or two comma-separated numbers (--start_pos 2,3) for both. 
      Alternatively, you can pass the numbers in the more classic +y:[x] format 
      without the --start_pos label. Like 'tabview <fn> +5:10'
    inputBinding:
      position: 102
      prefix: --start_pos
  - id: width
    type:
      - 'null'
      - string
    doc: Specify column width. 'max' or 'mode' (default) for variable widths, or
      an integer value for fixed column width.
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabview:1.4.3--pyh4bbf42b_0
stdout: tabview.out
