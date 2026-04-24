cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfs_view
label: sfs_view
doc: "Format, marginalize, project, and convert SFS.\n\nTool homepage: https://github.com/malthesr/sfs"
inputs:
  - id: path
    type:
      - 'null'
      - File
    doc: "Input SFS.\n          \n          The input SFS can be provided here or
      read from stdin in any of the supported formats."
    inputBinding:
      position: 1
  - id: marginalize_keep
    type:
      - 'null'
      - type: array
        items: int
    doc: "Marginalize remaining populations.\n          \n          Alternative to
      `--marginalize-remove`, see documentation for background. Using this argument,
      the marginalization can be specified in terms of dimensions to keep, rather
      than dimensions to remove."
    inputBinding:
      position: 102
      prefix: --marginalize-keep
  - id: marginalize_remove
    type:
      - 'null'
      - type: array
        items: int
    doc: "Marginalize populations.\n          \n          Marginalize out provided
      populations. Marginalization corresponds to an array sum over the SFS seen as
      an array. Use a comma-separated list of 0-based dimensions to  keep, using the
      same ordering of the dimensions of the SFS as specified e.g. in the header."
    inputBinding:
      position: 102
      prefix: --marginalize-remove
  - id: mask_monomorphic
    type:
      - 'null'
      - boolean
    doc: Set monomorphic sites zero
    inputBinding:
      position: 102
      prefix: --mask-monomorphic
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize SFS
    inputBinding:
      position: 102
      prefix: --normalize
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format\n          \n          [default: text]\n          [possible
      values: npy, text]"
    inputBinding:
      position: 102
      prefix: --output-format
  - id: precision
    type:
      - 'null'
      - int
    doc: "Print precision.\n          \n          This is only used for printing SFS
      to plain text format, and will be ignored otherwise.\n          \n         \
      \ [default: 6]"
    inputBinding:
      position: 102
      prefix: --precision
  - id: project_individuals
    type:
      - 'null'
      - type: array
        items: int
    doc: "Projected individuals.\n          \n          Using this argument, it is
      possible to project the SFS down to a lower number of individuals.  Use a comma-separated
      list of values giving the new shape of the SFS. For example, `--project-individuals
      3,2` would project a two-dimensional SFS down to three individuals in the first
      dimension and two in the second.\n          \n          Note that it is also
      possible to project during creation of the SFS using the `create` subcommand,
      and projection after creation is not in equivalent. Where applicable, prefer
      projecting during creation to use more data in the presence of missingness."
    inputBinding:
      position: 102
      prefix: --project-individuals
  - id: project_shape
    type:
      - 'null'
      - type: array
        items: int
    doc: "Projected shape.\n          \n          Alternative to `--project-individuals`,
      see documentation for background. Using this argument, the projection can be
      specified by shape, rather than number of individuals. For example, `--project-shape
      7,5` would project a two-dimensional SFS down to three diploid individuals in
      the first dimension and two in the second."
    inputBinding:
      position: 102
      prefix: --project-shape
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: "Suppress log output.\n          \n          By default, information may
      be logged to stderr while running. Set this flag once to silence normal logging
      output, and set twice to silence warnings."
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: "Log output verbosity.\n          \n          Set this flag times to show
      debug information, and set twice to show trace information."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: "Output path.\n          \n          If no path is given, SFS will be output
      to stdout."
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
