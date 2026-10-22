cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdm
label: tqdm
doc: "A fast, extensible progress bar for Python and CLI\n\nTool homepage: https://github.com/tqdm/tqdm"
inputs:
  - id: input
    type: File
    doc: Input file; its lines are read from standard input and copied to standard
      output while the progress bar is shown on standard error
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Use ASCII characters to fill the progress bar
    inputBinding:
      position: 102
      prefix: --ascii
  - id: desc
    type:
      - 'null'
      - string
    doc: Prefix for the progress bar
    inputBinding:
      position: 102
      prefix: --desc
  - id: leave
    type:
      - 'null'
      - boolean
    doc: Keep the progress bar after termination
    inputBinding:
      position: 102
      prefix: --leave
  - id: maxinterval
    type:
      - 'null'
      - float
    doc: 'Maximum progress display update interval [default: 10] seconds'
    inputBinding:
      position: 102
      prefix: --maxinterval
  - id: mininterval
    type:
      - 'null'
      - float
    doc: 'Minimum progress display update interval [default: 0.1] seconds'
    inputBinding:
      position: 102
      prefix: --mininterval
  - id: miniters
    type:
      - 'null'
      - int
    doc: Minimum progress display update interval, in iterations
    inputBinding:
      position: 102
      prefix: --miniters
  - id: ncols
    type:
      - 'null'
      - int
    doc: The width of the entire output message
    inputBinding:
      position: 102
      prefix: --ncols
  - id: total
    type:
      - 'null'
      - int
    doc: The number of expected iterations
    inputBinding:
      position: 102
      prefix: --total
  - id: unit
    type:
      - 'null'
      - string
    doc: String that will be used to define the unit of each iteration
    inputBinding:
      position: 102
      prefix: --unit
  - id: unit_scale
    type:
      - 'null'
      - boolean
    doc: If set, the number of iterations will be reduced/scaled automatically and
      a metric prefix following the International System of Units standard will be
      added
    inputBinding:
      position: 102
      prefix: --unit_scale
  - id: bar_format
    type:
      - 'null'
      - string
    doc: Custom bar string formatting
    inputBinding:
      position: 102
      prefix: --bar_format
  - id: buf_size
    type:
      - 'null'
      - int
    doc: String buffer size in bytes (default 256), used when delim is specified
    inputBinding:
      position: 102
      prefix: --buf_size
  - id: delim
    type:
      - 'null'
      - string
    doc: Delimiting character (default newline)
    inputBinding:
      position: 102
      prefix: --delim
  - id: disable
    type:
      - 'null'
      - boolean
    doc: Whether to disable the entire progress bar wrapper
    inputBinding:
      position: 102
      prefix: --disable
  - id: dynamic_ncols
    type:
      - 'null'
      - boolean
    doc: Constantly alter ncols to the environment
    inputBinding:
      position: 102
      prefix: --dynamic_ncols
  - id: initial
    type:
      - 'null'
      - int
    doc: The initial counter value
    inputBinding:
      position: 102
      prefix: --initial
  - id: position
    type:
      - 'null'
      - int
    doc: Line offset to print this bar (starting from 0)
    inputBinding:
      position: 102
      prefix: --position
  - id: smoothing
    type:
      - 'null'
      - float
    doc: Exponential moving average smoothing factor for speed estimates
    inputBinding:
      position: 102
      prefix: --smoothing
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (a copy of the input)
  - id: progress
    type: stderr
    doc: Progress bar text written to standard error
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdm:4.7.2--py36_0
stdin: $(inputs.input.path)
stdout: tqdm.out
stderr: tqdm.err
