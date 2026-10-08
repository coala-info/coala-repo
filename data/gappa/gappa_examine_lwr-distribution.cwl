cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - examine
  - lwr-distribution
label: gappa_examine_lwr-distribution
doc: "Print a summary table that represents the distribution of the likelihood weight ratios (LWRs) of all pqueries.\n\nTool homepage: https://github.com/lczech/gappa"
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
  - id: num_entries
    type: ['null', int]
    doc: "Number of entries representing the pqueries. This is the length of the output table, representing the pquery LWR distribution. If set to 0, or if the input has fewer pqueries that the given number, the output table will contain all pqueries. (Default: 100)"
    inputBinding:
      position: 2
      prefix: --num-entries
  - id: num_lwrs
    type: ['null', int]
    doc: "Number of LWRs per pquery to output (the most likely, second most likely, etc); all remaining LWRs are accumulated into the Remainder column. This is the number of LWR columns of the output table. (Default: 5)"
    inputBinding:
      position: 3
      prefix: --num-lwrs
  - id: numerical_sort
    type: ['null', boolean]
    doc: "By default, we sort the entries in the output table using a weighted sum of the LWRs of each pquery, with weight 1 for the most likely LWR, weight 1/2 for the second most likely LWR, weight 1/3 for the third most likely, etc. If this option is set however, the entries in the output table are sorted by the most likely LWR first, then sorting identical entries by the second most likely LWR, and so forth."
    inputBinding:
      position: 4
      prefix: --numerical-sort
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 5
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 6
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 7
      prefix: --file-suffix
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 8
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 9
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 10
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 11
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
