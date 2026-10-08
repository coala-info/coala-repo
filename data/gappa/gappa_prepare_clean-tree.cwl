cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - prepare
  - clean-tree
label: gappa_prepare_clean-tree
doc: "Clean a tree in Newick format by removing parts that other parsers have difficulties with.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: tree_file
    type: File
    doc: "Tree file in Newick format."
    inputBinding:
      position: 1
      prefix: --tree-file
  - id: remove_inner_labels
    type: ['null', boolean]
    doc: "Some Newick trees contain inner node labels, which can confuse some parsers. This option removes them."
    inputBinding:
      position: 2
      prefix: --remove-inner-labels
  - id: replace_invalid_chars
    type: ['null', boolean]
    doc: "Replace invalid characters in node labels (` ,:;\"()[]`) by underscores. The Newick format requires node labels to be wrapped in double quotation marks if they contain these characters, but many parsers cannot handle this. For such cases, replacing the characters can help."
    inputBinding:
      position: 3
      prefix: --replace-invalid-chars
  - id: remove_comments_and_nhx
    type: ['null', boolean]
    doc: "The Newick format allows for comments in square brackets `[]`, which are also often (mis-)used for ad-hoc and more established extensions such as the New Hampshire eXtended (NHX) format `[&&NHX:key=value:...]`. Many parsers cannot handle this; this option removes such annotations."
    inputBinding:
      position: 4
      prefix: --remove-comments-and-nhx
  - id: remove_extra_numbers
    type: ['null', boolean]
    doc: "The Rich/Rice Newick format extension allows to annotate bootstrap values and probabilities per branch, by adding additional `:[bootstrap]:[prob]` fields after the branch length. Many parsers cannot handle this; this option removes such annotations."
    inputBinding:
      position: 5
      prefix: --remove-extra-numbers
  - id: remove_jplace_tags
    type: ['null', boolean]
    doc: "The Jplace file format for phylogenetic placements also uses a custom Newick extension, by introducing curly brackets to annotate edge numbers in the tree `{1}`. We are not aware of any other Newick extension that uses this style, but still, with this option, all annotations in curly brackets is removed."
    inputBinding:
      position: 6
      prefix: --remove-jplace-tags
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
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 10
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 11
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 12
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 13
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
