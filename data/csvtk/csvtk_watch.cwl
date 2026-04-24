cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - watch
label: csvtk_watch
doc: "monitor the specified fields\n\nTool homepage: https://github.com/shenwei356/csvtk"
inputs:
  - id: bins
    type:
      - 'null'
      - int
    doc: number of histogram bins
    inputBinding:
      position: 101
      prefix: --bins
  - id: comment_char
    type:
      - 'null'
      - string
    doc: lines starting with commment-character will be ignored
    inputBinding:
      position: 101
      prefix: --comment-char
  - id: delay
    type:
      - 'null'
      - int
    doc: sleep this many seconds after plotting
    inputBinding:
      position: 101
      prefix: --delay
  - id: delete_header
    type:
      - 'null'
      - boolean
    doc: do not output header row
    inputBinding:
      position: 101
      prefix: --delete-header
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiting character of the input CSV file
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: dump
    type:
      - 'null'
      - boolean
    doc: print histogram data to stderr instead of plotting
    inputBinding:
      position: 101
      prefix: --dump
  - id: field
    type:
      - 'null'
      - string
    doc: field to watch
    inputBinding:
      position: 101
      prefix: --field
  - id: ignore_empty_row
    type:
      - 'null'
      - boolean
    doc: ignore empty rows
    inputBinding:
      position: 101
      prefix: --ignore-empty-row
  - id: ignore_illegal_row
    type:
      - 'null'
      - boolean
    doc: ignore illegal rows
    inputBinding:
      position: 101
      prefix: --ignore-illegal-row
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line)
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: lazy_quotes
    type:
      - 'null'
      - boolean
    doc: if given, a quote may appear in an unquoted field and a non-doubled quote
      may appear in a quoted field
    inputBinding:
      position: 101
      prefix: --lazy-quotes
  - id: log
    type:
      - 'null'
      - boolean
    doc: log10(x+1) transform numeric values
    inputBinding:
      position: 101
      prefix: --log
  - id: no_header_row
    type:
      - 'null'
      - boolean
    doc: specifies that the input CSV file does not have header row
    inputBinding:
      position: 101
      prefix: --no-header-row
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --num-cpus
  - id: out_delimiter
    type:
      - 'null'
      - string
    doc: delimiting character of the output CSV file
    inputBinding:
      position: 101
      prefix: --out-delimiter
  - id: out_tabs
    type:
      - 'null'
      - boolean
    doc: specifies that the output is delimited with tabs. Overrides "-D"
    inputBinding:
      position: 101
      prefix: --out-tabs
  - id: pass
    type:
      - 'null'
      - boolean
    doc: passthrough mode (forward input to output)
    inputBinding:
      position: 101
      prefix: --pass
  - id: print_freq
    type:
      - 'null'
      - int
    doc: print/report after this many records (-1 for print after EOF)
    inputBinding:
      position: 101
      prefix: --print-freq
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: supress all plotting to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reset
    type:
      - 'null'
      - boolean
    doc: reset histogram after every report
    inputBinding:
      position: 101
      prefix: --reset
  - id: show_row_number
    type:
      - 'null'
      - boolean
    doc: show row number as the first column, with header row skipped
    inputBinding:
      position: 101
      prefix: --show-row-number
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: specifies that the input CSV file is delimited with tabs. Overrides "-d"
    inputBinding:
      position: 101
      prefix: --tabs
outputs:
  - id: image
    type:
      - 'null'
      - File
    doc: save histogram to this PDF/image file
    outputBinding:
      glob: $(inputs.image)
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
