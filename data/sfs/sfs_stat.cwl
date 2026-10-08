cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sfs
  - stat
label: sfs_stat
doc: "Tools for working with site frequency spectra\n\nTool homepage: https://github.com/malthesr/sfs"
inputs:
  - id: path
    type: File
    doc: "Input SFS. The file is sent to the tool on standard input, because the
      tool fails with a file argument when standard input is not a terminal."
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter between statistics
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: header
    type:
      - 'null'
      - boolean
    doc: Include a header with the names of statistics
    inputBinding:
      position: 102
      prefix: --header
  - id: precision
    type:
      - 'null'
      - type: array
        items: int
    doc: Precision to use when printing statistics. If a single value is 
      provided, this will be used for all statistics. If more than one statistic
      is calculated, the same number of precision specifiers may be provided, 
      and they will be applied in the same order. Use comma to separate 
      precision specifiers.
    inputBinding:
      position: 102
      prefix: --precision
      itemSeparator: ','
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
        inputBinding:
          prefix: --quiet
    doc: Suppress log output. By default, information may be logged to stderr 
      while running. Set this flag once to silence normal logging output, and 
      set twice to silence warnings.
    inputBinding:
      position: 102
  - id: statistics
    type:
      type: array
      items: string
    doc: Statistics to calculate. More than one statistic can be output. Use 
      comma to separate statistics. An error will be thrown if the shape or 
      dimensionality of the SFS is incompatible with the required statistics.
    inputBinding:
      position: 102
      prefix: --statistics
      itemSeparator: ','
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
        inputBinding:
          prefix: --verbose
    doc: Log output verbosity. Set this flag times to show debug information, 
      and set twice to show trace information.
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
stdout: sfs_stat.out
stdin: $(inputs.path.path)
