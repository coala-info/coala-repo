cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genodsp
label: genodsp
doc: "General workbench for processing signals along genomic intervals. Reads
  intervals (chromosome, start, end, value) from standard input, applies a
  pipeline of operations separated by '=', and writes the resulting intervals to
  standard output. List each operation with its own options as one string in
  'operations', for example 'smooth --window=101' or 'clump 5 --length=20'. The
  operations are joined with '=' in the given order.\n\nTool homepage:
  https://github.com/richard-burhans/genodsp"
inputs:
  - id: signal
    type: File
    doc: Input intervals (chromosome, start, end, value), read from standard 
      input. Not used when the first operation is 'input <filename>'.
  - id: chromosomes
    type: File
    doc: Read chromosome names and lengths from a file (two columns, 
      whitespace-separated).
    inputBinding:
      position: 1
      prefix: --chromosomes=
      separate: false
  - id: value
    type:
      - 'null'
      - int
    doc: Input intervals contain a value in the specified column. By default 
      this is column 4.
    inputBinding:
      position: 2
      prefix: --value=
      separate: false
  - id: novalue
    type:
      - 'null'
      - boolean
    doc: Input intervals have no value (value given is 1).
    inputBinding:
      position: 2
      prefix: --novalue
  - id: nooutputvalue
    type:
      - 'null'
      - boolean
    doc: Do not write the value with output intervals.
    inputBinding:
      position: 2
      prefix: --nooutputvalue
  - id: precision
    type:
      - 'null'
      - int
    doc: Number of digits to round output values to. By default, output is 
      rounded to integers.
    inputBinding:
      position: 2
      prefix: --precision=
      separate: false
  - id: nocollapse
    type:
      - 'null'
      - boolean
    doc: In output, do not collapse runs of identical values to intervals.
    inputBinding:
      position: 2
      prefix: --nocollapse
  - id: uncovered
    type:
      - 'null'
      - type: enum
        name: uncovered_mode
        symbols:
          - hide
          - show
          - NA
    doc: How to report intervals that have no coverage (hide is the default; 
      show includes them; NA marks them as NA).
    inputBinding:
      position: 2
      prefix: '--uncovered:'
      separate: false
  - id: cliptochromosome
    type:
      - 'null'
      - boolean
    doc: Clip intervals to chromosome length. The default is to report such 
      intervals as errors.
    inputBinding:
      position: 2
      prefix: --cliptochromosome
  - id: origin
    type:
      - 'null'
      - type: enum
        name: origin_mode
        symbols:
          - one
          - zero
    doc: Input and output intervals are origin-one closed (one) or origin-zero 
      half-open (zero, the default).
    inputBinding:
      position: 2
      prefix: --origin=
      separate: false
  - id: nooutput
    type:
      - 'null'
      - boolean
    doc: Do not output the resulting intervals and values.
    inputBinding:
      position: 2
      prefix: --nooutput
  - id: window
    type:
      - 'null'
      - string
    doc: Size of window, for operators that have a window size.
    inputBinding:
      position: 2
      prefix: --window=
      separate: false
  - id: report_comments
    type:
      - 'null'
      - boolean
    doc: Copy comments (lines starting with '#') from the input to standard 
      error.
    inputBinding:
      position: 2
      prefix: --report=comments
  - id: progress
    type:
      - 'null'
      - string
    doc: Report progress, either 'input:<n>' (every nth input line) or 
      'operations' (each operation as it begins).
    inputBinding:
      position: 2
      prefix: --progress=
      separate: false
  - id: operations
    type:
      type: array
      items: string
    doc: Operations to apply, in order. Each item is one operator with its 
      options, for example 'smooth --window=101'. Run 'genodsp --help' for the
      list of operators.
  - id: output_name
    type: string
    default: genodsp_output.tsv
    doc: Name of the file that receives the resulting intervals (standard 
      output).
outputs:
  - id: output
    type: stdout
    doc: Resulting intervals (chromosome, start, end, value).
  - id: messages
    type: stderr
    doc: Messages and reports written to standard error (for example percentile
      values).
arguments:
  - position: 10
    shellQuote: false
    valueFrom: |
      ${ return inputs.operations.map(function(o){ return "= " + o; }).join(" "); }
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1
stdin: $(inputs.signal.path)
stdout: $(inputs.output_name)
stderr: genodsp_messages.txt
