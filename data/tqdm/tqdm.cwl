cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdm
label: tqdm
doc: "A fast, extensible progress bar for Python and CLI\n\nTool homepage: https://github.com/tqdm/tqdm"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input file to read and pipe to stdout while showing a progress bar
    inputBinding:
      position: 1
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
    default: it
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdm:4.7.2--py36_0
stdout: tqdm.out
