cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - analyze
  - squash
label: gappa_analyze_squash
doc: "Perform Squash Clustering for a set of samples.\n\nTool homepage: https://github.com/lczech/gappa"
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
  - id: point_mass
    type: ['null', boolean]
    doc: "Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0."
    inputBinding:
      position: 3
      prefix: --point-mass
  - id: ignore_multiplicities
    type: ['null', boolean]
    doc: "Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag."
    inputBinding:
      position: 4
      prefix: --ignore-multiplicities
  - id: color_list
    type: ['null', string]
    doc: "List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names. (Default: BuPuBk)"
    inputBinding:
      position: 5
      prefix: --color-list
  - id: reverse_color_list
    type: ['null', boolean]
    doc: "If set, the order of colors of the `--color-list` is reversed."
    inputBinding:
      position: 6
      prefix: --reverse-color-list
  - id: log_scaling
    type: ['null', boolean]
    doc: "If set, the sequential color list is logarithmically scaled instead of linearily."
    inputBinding:
      position: 7
      prefix: --log-scaling
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 8
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 9
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 10
      prefix: --file-suffix
  - id: write_newick_tree
    type: ['null', boolean]
    doc: "If set, the tree is written to a Newick file. This format cannot store color information."
    inputBinding:
      position: 11
      prefix: --write-newick-tree
  - id: write_nexus_tree
    type: ['null', boolean]
    doc: "If set, the tree is written to a Nexus file. This can for example be opened in FigTree."
    inputBinding:
      position: 12
      prefix: --write-nexus-tree
  - id: write_phyloxml_tree
    type: ['null', boolean]
    doc: "If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx."
    inputBinding:
      position: 13
      prefix: --write-phyloxml-tree
  - id: write_svg_tree
    type: ['null', boolean]
    doc: "If set, the tree is written to a SVG file. This gives a file for vector graphics editors."
    inputBinding:
      position: 14
      prefix: --write-svg-tree
  - id: newick_tree_branch_length_precision
    type: ['null', int]
    doc: "Number of digits to print for branch lengths in Newick format. (Needs: --write-newick-tree; Default: 6)"
    inputBinding:
      position: 15
      prefix: --newick-tree-branch-length-precision
  - id: newick_tree_quote_invalid_chars
    type: ['null', boolean]
    doc: "If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools. (Needs: --write-newick-tree)"
    inputBinding:
      position: 16
      prefix: --newick-tree-quote-invalid-chars
  - id: svg_tree_shape
    type:
      - 'null'
      - type: enum
        symbols: [circular, rectangular]
    doc: "Shape of the tree. (Needs: --write-svg-tree; Default: circular)"
    inputBinding:
      position: 17
      prefix: --svg-tree-shape
  - id: svg_tree_type
    type:
      - 'null'
      - type: enum
        symbols: [cladogram, phylogram]
    doc: "Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`). (Needs: --write-svg-tree; Default: cladogram)"
    inputBinding:
      position: 18
      prefix: --svg-tree-type
  - id: svg_tree_stroke_width
    type: ['null', float]
    doc: "Svg stroke width for the branches of the tree. (Needs: --write-svg-tree; Default: 5)"
    inputBinding:
      position: 19
      prefix: --svg-tree-stroke-width
  - id: svg_tree_ladderize
    type: ['null', boolean]
    doc: "If set, the tree is ladderized. (Needs: --write-svg-tree)"
    inputBinding:
      position: 20
      prefix: --svg-tree-ladderize
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 21
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 22
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 23
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 24
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
