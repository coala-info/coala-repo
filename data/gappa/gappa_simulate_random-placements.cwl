cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - simulate
  - random-placements
label: gappa_simulate_random-placements
doc: "Create a set of random phylogenetic placements on a given reference tree.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: reference_tree
    type: File
    doc: "File containing a reference tree in newick format."
    inputBinding:
      position: 1
      prefix: --reference-tree
  - id: pquery_count
    type: int
    doc: "Number of pqueries to create. (Default: 0)"
    inputBinding:
      position: 2
      prefix: --pquery-count
  - id: subtree
    type: ['null', int]
    doc: "If given, only generate random placements in one of the subtrees of the root node. For example, if the root is a trifurcation, values 0-2 are allowed. (Default: -1)"
    inputBinding:
      position: 3
      prefix: --subtree
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 4
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 5
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 6
      prefix: --file-suffix
  - id: compress
    type: ['null', boolean]
    doc: "If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`."
    inputBinding:
      position: 7
      prefix: --compress
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
