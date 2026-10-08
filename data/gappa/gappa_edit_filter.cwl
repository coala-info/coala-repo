cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - edit
  - filter
label: gappa_edit_filter
doc: "Filter jplace files according to some criteria, that is, remove all queries and/or placement locations that do not pass the provided filter(s).\n\nTool homepage: https://github.com/lczech/gappa"
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
  - id: normalize_before
    type: ['null', boolean]
    doc: "Before filtering placements, normalize the initial placement masses (likelihood weight ratios) by proportially scaling them so that they sum to one per pquery."
    inputBinding:
      position: 2
      prefix: --normalize-before
  - id: min_accumulated_mass
    type: ['null', float]
    doc: "Only keep the most likely placements per query so that their accumulated mass is above the given minimum value. (Default: 0; Range: [0 - 1])"
    inputBinding:
      position: 3
      prefix: --min-accumulated-mass
  - id: min_mass_threshold
    type: ['null', float]
    doc: "Only keep those placements per query whose mass is above the given minimum threshold. (Default: 0; Range: [0 - 1])"
    inputBinding:
      position: 4
      prefix: --min-mass-threshold
  - id: max_n_placements
    type: ['null', int]
    doc: "Only keep the n most likely placements per query. (Default: 0)"
    inputBinding:
      position: 5
      prefix: --max-n-placements
  - id: min_pendant_len
    type: ['null', float]
    doc: "Only keep placements with at least the given pendant length. (Default: 0)"
    inputBinding:
      position: 6
      prefix: --min-pendant-len
  - id: max_pendant_len
    type: ['null', float]
    doc: "Only keep placements with at most the given pendant length. (Default: 0)"
    inputBinding:
      position: 7
      prefix: --max-pendant-len
  - id: no_remove_empty
    type: ['null', boolean]
    doc: "After filtering placements, there might be pqueries that do not have any placement locations remaining. By default, the whole pquery is removed in this case, as it is useless. However, if this flag is set, they are kept as empty pqueries with just their name."
    inputBinding:
      position: 8
      prefix: --no-remove-empty
  - id: normalize_after
    type: ['null', boolean]
    doc: "After filtering placements, normalize the remaining placement masses (likelihood weight ratios) by proportially scaling them so that they sum to one per pquery."
    inputBinding:
      position: 9
      prefix: --normalize-after
  - id: keep_names
    type: ['null', string]
    doc: "Keep queries whose name matches the given names, which can be provided either as a regular expression (regex), or as a file with one name per line. Remove all others."
    inputBinding:
      position: 10
      prefix: --keep-names
  - id: remove_names
    type: ['null', string]
    doc: "Remove queries whose name matches the given names, which can be provided either as a regular expression (regex), or as a file with one name per line. Keep all others."
    inputBinding:
      position: 11
      prefix: --remove-names
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 12
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 13
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 14
      prefix: --file-suffix
  - id: compress
    type: ['null', boolean]
    doc: "If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`."
    inputBinding:
      position: 15
      prefix: --compress
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 16
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 17
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 18
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 19
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
