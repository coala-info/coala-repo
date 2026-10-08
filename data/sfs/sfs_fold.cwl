cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sfs
  - fold
label: sfs_fold
doc: "Tools for working with site frequency spectra\n\nTool homepage: https://github.com/malthesr/sfs"
inputs:
  - id: path
    type: File
    doc: "Input SFS. The file is sent to the tool on standard input, because the
      tool fails with a file argument when standard input is not a terminal."
  - id: fill
    type:
      - 'null'
      - string
    doc: "Fill value to use when folding.\n          \n          By default, the \"\
      lower\" part of the SFS will be filled with nan values. Set this option to use
      another fill values.\n          \n          Possible values:\n          - nan:\
      \       Set folded value to nan\n          - zero:      Set folded value to
      0\n          - minus-one: Set folded value to -1\n          - inf:       Set
      folded value to Inf"
    inputBinding:
      position: 102
      prefix: --fill
  - id: precision
    type:
      - 'null'
      - int
    doc: Precision to use when printing SFS
    inputBinding:
      position: 102
      prefix: --precision
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
        inputBinding:
          prefix: --quiet
    doc: "Suppress log output.\n          \n          By default, information may
      be logged to stderr while running. Set this flag once to silence normal logging
      output, and set twice to silence warnings."
    inputBinding:
      position: 102
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
        inputBinding:
          prefix: --verbose
    doc: "Log output verbosity.\n          \n          Set this flag times to show
      debug information, and set twice to show trace information."
    inputBinding:
      position: 102
  - id: output_path
    type: string
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Output SFS path.\n          \n          If no path is given, SFS will be
      output to stdout."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
stdin: $(inputs.path.path)
