cwlVersion: v1.2
class: CommandLineTool
baseCommand: bases
label: seqfu_bases
doc: "Print the DNA bases, and %GC content, in the input files\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: abspath
    type:
      - 'null'
      - boolean
    doc: Print absolute path
    inputBinding:
      position: 102
      prefix: --abspath
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Print the basename of the file
    inputBinding:
      position: 102
      prefix: --basename
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
  - id: digits
    type:
      - 'null'
      - int
    doc: Number of digits to print
    default: 2
    inputBinding:
      position: 102
      prefix: --digits
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print header
    inputBinding:
      position: 102
      prefix: --header
  - id: nice
    type:
      - 'null'
      - boolean
    doc: Print terminal table
    inputBinding:
      position: 102
      prefix: --nice
  - id: raw_counts
    type:
      - 'null'
      - boolean
    doc: Print counts and not ratios
    inputBinding:
      position: 102
      prefix: --raw-counts
  - id: thousands
    type:
      - 'null'
      - boolean
    doc: Print thousands separator
    inputBinding:
      position: 102
      prefix: --thousands
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_bases.out
