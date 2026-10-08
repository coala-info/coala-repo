cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - edit
  - extract
label: gappa_edit_extract
doc: "Extract placements from clades of the tree and write per-clade jplace files.\n\nTool homepage: https://github.com/lczech/gappa"
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
  - id: clade_list_file
    type: File
    doc: "File containing a tab-separated list of taxon to clade mapping."
    inputBinding:
      position: 2
      prefix: --clade-list-file
  - id: fasta_path
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: "List of fasta files or directories to process. For directories, only files with the extension `.(fasta|fas|fsa|fna|ffn|faa|frn)[.gz]` are processed."
    inputBinding:
      position: 3
      prefix: --fasta-path
  - id: threshold
    type: ['null', float]
    doc: "Threshold of how much placement mass needs to be in a clade for extracting a pquery. (Default: 0.95; Range: [0.5 - 1])"
    inputBinding:
      position: 4
      prefix: --threshold
  - id: exclude_clade_stems
    type: ['null', boolean]
    doc: "By default, the branch connecting a specified clade to the rest of the tree is considered part of the clade. With this option, these branches are excluded, and instead considered as basal branches."
    inputBinding:
      position: 5
      prefix: --exclude-clade-stems
  - id: basal_clade_name
    type: ['null', string]
    doc: "The name of the clade used for queries that do not fall into one of the specified clades. (Default: basal)"
    inputBinding:
      position: 6
      prefix: --basal-clade-name
  - id: uncertain_clade_name
    type: ['null', string]
    doc: "The name of the clade used for queries that do not fall into any clade with more than the threshold amount of their mass. (Default: uncertain)"
    inputBinding:
      position: 7
      prefix: --uncertain-clade-name
  - id: point_mass
    type: ['null', boolean]
    doc: "Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0."
    inputBinding:
      position: 8
      prefix: --point-mass
  - id: color_tree_file
    type: ['null', string]
    doc: "If a path is provided, an svg file with a tree colored by clades is written."
    inputBinding:
      position: 9
      prefix: --color-tree-file
  - id: samples_out_dir
    type: ['null', string]
    doc: "Directory to write output samples files to. (Default: samples)"
    default: "samples"
    inputBinding:
      position: 10
      prefix: --samples-out-dir
  - id: samples_file_prefix
    type: ['null', string]
    doc: "File prefix for samples files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 11
      prefix: --samples-file-prefix
  - id: samples_file_suffix
    type: ['null', string]
    doc: "File suffix for samples files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 12
      prefix: --samples-file-suffix
  - id: sequences_out_dir
    type: ['null', string]
    doc: "Directory to write output sequences files to. (Default: sequences)"
    default: "sequences"
    inputBinding:
      position: 13
      prefix: --sequences-out-dir
  - id: sequences_file_prefix
    type: ['null', string]
    doc: "File prefix for sequences files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 14
      prefix: --sequences-file-prefix
  - id: sequences_file_suffix
    type: ['null', string]
    doc: "File suffix for sequences files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 15
      prefix: --sequences-file-suffix
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
  - id: color_tree
    type: File?
    doc: "SVG tree colored by clades."
    outputBinding:
      glob: "$(inputs.color_tree_file)"
  - id: samples_dir
    type: Directory
    doc: "Output directory (--samples-out-dir)."
    outputBinding:
      glob: "$(inputs.samples_out_dir)"
  - id: sequences_dir
    type: Directory?
    doc: "Output directory (--sequences-out-dir)."
    outputBinding:
      glob: "$(inputs.sequences_out_dir)"
  - id: log_file_out
    type: File?
    doc: "Log file written by --log-file."
    outputBinding:
      glob: "$(inputs.log_file)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
