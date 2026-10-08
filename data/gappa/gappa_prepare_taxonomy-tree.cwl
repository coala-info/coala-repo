cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - prepare
  - taxonomy-tree
label: gappa_prepare_taxonomy-tree
doc: "Turn a taxonomy into a tree that can be used as a constraint for tree inference.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: taxon_list_file
    type: ['null', File]
    doc: "File that maps taxon names to taxonomic paths."
    inputBinding:
      position: 1
      prefix: --taxon-list-file
  - id: taxonomy_file
    type: ['null', File]
    doc: "File that lists the taxa of the taxonomy as taxonomic paths."
    inputBinding:
      position: 2
      prefix: --taxonomy-file
  - id: keep_singleton_inner_nodes
    type: ['null', boolean]
    doc: "Taxonomic paths can go down several levels without any furcation. Use this option to keep such paths, instead of collapsing them into a single level."
    inputBinding:
      position: 3
      prefix: --keep-singleton-inner-nodes
  - id: keep_inner_node_names
    type: ['null', boolean]
    doc: "Taxonomies contain names at every level, while trees usually do not. Use this option to also set taxonomic names for the inner nodes of the tree."
    inputBinding:
      position: 4
      prefix: --keep-inner-node-names
  - id: max_level
    type: ['null', int]
    doc: "Maximum taxonomic level to process (0-based). Taxa below this level are not added to the tree. (Default: -1)"
    inputBinding:
      position: 5
      prefix: --max-level
  - id: replace_invalid_chars
    type: ['null', boolean]
    doc: "Replace invalid characters in node labels (` ,:;\"()[]`) by underscores, which can occur if the input taxonomic paths contain such characters. The Newick format requires node labels to be wrapped in double quotation marks if they contain these characters, but many parsers cannot handle this. For such cases, replacing the characters can help."
    inputBinding:
      position: 6
      prefix: --replace-invalid-chars
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 7
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 8
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 9
      prefix: --file-suffix
  - id: newick_tree_quote_invalid_chars
    type: ['null', boolean]
    doc: "If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools."
    inputBinding:
      position: 10
      prefix: --newick-tree-quote-invalid-chars
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 11
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 12
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 13
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 14
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
