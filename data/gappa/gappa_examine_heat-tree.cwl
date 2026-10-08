cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - examine
  - heat-tree
label: gappa_examine_heat-tree
doc: "Make a tree with edges colored according to the placement mass of the samples.\n\nTool homepage: https://github.com/lczech/gappa"
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
  - id: mass_norm
    type:
      - 'null'
      - type: enum
        symbols: [absolute, relative]
    doc: "Set the per-sample normalization method. With `absolute`, the total mass is not changed, so that input jplace samples with more pqueries (more placed sequences) have a higher influence on the result. With `relative`, the total mass of each sample is normalized to 1.0, so that each sample has the same influence on the result, independent of its number of sequences and their abundances. (Default: absolute)"
    inputBinding:
      position: 2
      prefix: --mass-norm
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
  - id: under_color
    type: ['null', string]
    doc: "Color used to indicate values below the min value. Color can be specified in the format `#rrggbb` using hex values, or by web color names. (Default: #ff00ff)"
    inputBinding:
      position: 7
      prefix: --under-color
  - id: clip_under
    type: ['null', boolean]
    doc: "Clip (i.e., clamp) values less than min to be inside `[ min, max ]`, by setting values that are too low to the specified min value. If set, `--under-color` is not used to indicate values out of range."
    inputBinding:
      position: 8
      prefix: --clip-under
  - id: over_color
    type: ['null', string]
    doc: "Color used to indicate values above the max value. Color can be specified in the format `#rrggbb` using hex values, or by web color names. (Default: #00ffff)"
    inputBinding:
      position: 9
      prefix: --over-color
  - id: clip_over
    type: ['null', boolean]
    doc: "Clip (i.e., clamp) values greater than max to be inside `[ min, max ]`, by setting values that are too high to the specified max value. If set, `--over-color` is not used to indicate values out of range."
    inputBinding:
      position: 10
      prefix: --clip-over
  - id: clip
    type: ['null', boolean]
    doc: "Clip (i.e., clamp) values to be inside `[ min, max ]`, by setting values outside of that interval to the nearest boundary of it. This option is a shortcut to set `--clip-under` and `--clip-over` at once."
    inputBinding:
      position: 11
      prefix: --clip
  - id: mask_color
    type: ['null', string]
    doc: "Color used to indicate masked or invalid values, such as infinities or NaNs. Color can be specified in the format `#rrggbb` using hex values, or by web color names. (Default: #ffff00)"
    inputBinding:
      position: 12
      prefix: --mask-color
  - id: log_scaling
    type: ['null', boolean]
    doc: "If set, the sequential color list is logarithmically scaled instead of linearily."
    inputBinding:
      position: 13
      prefix: --log-scaling
  - id: min_value
    type: ['null', float]
    doc: "Minimum value that is represented by the color scale. If not set, the minimum value of the data is used. (Default: 0)"
    inputBinding:
      position: 14
      prefix: --min-value
  - id: max_value
    type: ['null', float]
    doc: "Maximum value that is represented by the color scale. If not set, the maximum value of the data is used. (Default: 1)"
    inputBinding:
      position: 15
      prefix: --max-value
  - id: mask_value
    type: ['null', float]
    doc: "Mask value that identifies invalid values (in addition to infinities and NaN values, which are always considered invalid, and hence always masked). Value of the data that compare equal to the mask value are colored using --mask-color. This is meant as a simple means of filtering and visualizing invalid values. If not set, no masking value is applied. (Default: nan)"
    inputBinding:
      position: 16
      prefix: --mask-value
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 17
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 18
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 19
      prefix: --file-suffix
  - id: write_newick_tree
    type: ['null', boolean]
    doc: "If set, the tree is written to a Newick file. This format cannot store color information."
    inputBinding:
      position: 20
      prefix: --write-newick-tree
  - id: write_nexus_tree
    type: ['null', boolean]
    doc: "If set, the tree is written to a Nexus file. This can for example be opened in FigTree."
    inputBinding:
      position: 21
      prefix: --write-nexus-tree
  - id: write_phyloxml_tree
    type: ['null', boolean]
    doc: "If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx."
    inputBinding:
      position: 22
      prefix: --write-phyloxml-tree
  - id: write_svg_tree
    type: ['null', boolean]
    doc: "If set, the tree is written to a SVG file. This gives a file for vector graphics editors."
    inputBinding:
      position: 23
      prefix: --write-svg-tree
  - id: newick_tree_branch_length_precision
    type: ['null', int]
    doc: "Number of digits to print for branch lengths in Newick format. (Needs: --write-newick-tree; Default: 6)"
    inputBinding:
      position: 24
      prefix: --newick-tree-branch-length-precision
  - id: newick_tree_quote_invalid_chars
    type: ['null', boolean]
    doc: "If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools. (Needs: --write-newick-tree)"
    inputBinding:
      position: 25
      prefix: --newick-tree-quote-invalid-chars
  - id: svg_tree_shape
    type:
      - 'null'
      - type: enum
        symbols: [circular, rectangular]
    doc: "Shape of the tree. (Needs: --write-svg-tree; Default: circular)"
    inputBinding:
      position: 26
      prefix: --svg-tree-shape
  - id: svg_tree_type
    type:
      - 'null'
      - type: enum
        symbols: [cladogram, phylogram]
    doc: "Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`). (Needs: --write-svg-tree; Default: cladogram)"
    inputBinding:
      position: 27
      prefix: --svg-tree-type
  - id: svg_tree_stroke_width
    type: ['null', float]
    doc: "Svg stroke width for the branches of the tree. (Needs: --write-svg-tree; Default: 5)"
    inputBinding:
      position: 28
      prefix: --svg-tree-stroke-width
  - id: svg_tree_ladderize
    type: ['null', boolean]
    doc: "If set, the tree is ladderized. (Needs: --write-svg-tree)"
    inputBinding:
      position: 29
      prefix: --svg-tree-ladderize
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 30
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 31
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 32
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 33
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
