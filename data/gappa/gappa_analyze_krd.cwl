cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - analyze
  - krd
label: gappa_analyze_krd
doc: "Calculate the pairwise Kantorovich-Rubinstein (KR) distance matrix between samples.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: jplace_path
    type:
      type: array
      items:
        - File
        - Directory
    doc: "List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed."
    inputBinding:
      position: 1
      prefix: --jplace-path
  - id: exponent
    type: ['null', float]
    doc: "Exponent for KR integration. (Default: 1)"
    inputBinding:
      position: 2
      prefix: --exponent
  - id: normalize
    type: ['null', boolean]
    doc: "Divide the KR distance by the tree length to get normalized values."
    inputBinding:
      position: 3
      prefix: --normalize
  - id: point_mass
    type: ['null', boolean]
    doc: "Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0."
    inputBinding:
      position: 4
      prefix: --point-mass
  - id: ignore_multiplicities
    type: ['null', boolean]
    doc: "Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag."
    inputBinding:
      position: 5
      prefix: --ignore-multiplicities
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 6
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 7
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 8
      prefix: --file-suffix
  - id: compress
    type: ['null', boolean]
    doc: "If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`."
    inputBinding:
      position: 9
      prefix: --compress
  - id: matrix_format
    type:
      - 'null'
      - type: enum
        symbols: [list, matrix, triangular]
    doc: "Format of the output matrix file. (Default: matrix)"
    inputBinding:
      position: 10
      prefix: --matrix-format
  - id: omit_matrix_labels
    type: ['null', boolean]
    doc: "If set, the output matrix is written without column and row labels."
    inputBinding:
      position: 11
      prefix: --omit-matrix-labels
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 12
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 13
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 14
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 15
      prefix: --log-file
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory (--out-dir)."
    outputBinding:
      glob: "$(inputs.out_dir)"
  - id: log_file_out
    type: File?
    doc: "Log file written by --log-file."
    outputBinding:
      glob: "$(inputs.log_file)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
