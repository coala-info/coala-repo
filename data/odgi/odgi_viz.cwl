cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi viz
label: odgi_viz
doc: "Visualize a variation graph in 1D.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: alignment_prefix
    type:
      - 'null'
      - string
    doc: Apply alignment related visual motifs to paths which have this name 
      prefix. It affects the [-S, --show-strand] and [-d, –change-darkness] 
      options.
    inputBinding:
      position: 101
      prefix: --alignment-prefix
  - id: bin_width
    type:
      - 'null'
      - string
    doc: The bin width specifies the size of each bin in the binned mode. If it 
      is not specified, the bin width is calculated from the width in pixels of 
      the output image.
    inputBinding:
      position: 101
      prefix: --bin-width
  - id: black_path_borders
    type:
      - 'null'
      - boolean
    doc: Draw path borders in black (default is white).
    inputBinding:
      position: 101
      prefix: --black-path-borders
  - id: change_darkness
    type:
      - 'null'
      - boolean
    doc: 'Change the color darkness based on nucleotide position in the path. When
      it is used in binned mode, the mean inversion rate of the bin node is considered
      to set the color gradient starting position: when this rate is greater than
      0.5, the bin is considered inverted, and the color gradient starts from the
      right-end of the bin. This parameter can be set in combination with [-A, –alignment-prefix=*STRING*].'
    inputBinding:
      position: 101
      prefix: --change-darkness
  - id: cluster_paths
    type:
      - 'null'
      - boolean
    doc: Automatically order paths by similarity (bin-level Jaccard) so similar 
      paths are adjacent.
    inputBinding:
      position: 101
      prefix: --cluster-paths
  - id: color_by_mean_depth
    type:
      - 'null'
      - boolean
    doc: Change the color with respect to the mean coverage of the path for each
      bin, using the colorbrewer palette specified in -B --colorbrewer-palette
    inputBinding:
      position: 101
      prefix: --color-by-mean-depth
  - id: color_by_mean_inversion_rate
    type:
      - 'null'
      - boolean
    doc: Change the color respect to the node strandness (black for forward, red
      for reverse); in binned mode (--binned-mode), change the color respect to 
      the mean inversion rate of the path for each bin, from black (no 
      inversions) to red (bin mean inversion rate equals to 1).
    inputBinding:
      position: 101
      prefix: --color-by-mean-inversion-rate
  - id: color_by_prefix
    type:
      - 'null'
      - string
    doc: Color paths by their names looking at the prefix before the given 
      character CHAR.
    inputBinding:
      position: 101
      prefix: --color-by-prefix
  - id: color_by_uncalled_bases
    type:
      - 'null'
      - boolean
    doc: Change the color with respect to the uncalled bases of the path for 
      each bin, from black (no uncalled bases) to green (all uncalled bases).
    inputBinding:
      position: 101
      prefix: --color-by-uncalled-bases
  - id: color_path_names_background
    type:
      - 'null'
      - boolean
    doc: Color path names background with the same color as paths.
    inputBinding:
      position: 101
      prefix: --color-path-names-background
  - id: colorbrewer_palette
    type:
      - 'null'
      - string
    doc: Use the colorbrewer palette specified by the given SCHEME, with the 
      number of levels N. Specifiy 'show' to see available palettes.
    inputBinding:
      position: 101
      prefix: --colorbrewer-palette
  - id: compressed_mode
    type:
      - 'null'
      - boolean
    doc: Compress the view vertically, summarizing the path coverage across all 
      paths displaying the information using only one path 'COMPRESSED_MODE'. A 
      heatmap color-coding from 
      https://colorbrewer2.org/#type=diverging&scheme=RdBu&n=11 is used. 
      Alternatively, one can enter a colorbrewer palette via -B, 
      --colorbrewer-palette.
    inputBinding:
      position: 101
      prefix: --compressed-mode
  - id: height
    type:
      - 'null'
      - int
    doc: Set the height in pixels of the output image
    default: 500
    inputBinding:
      position: 101
      prefix: --height
  - id: hide_path_names
    type:
      - 'null'
      - boolean
    doc: Hide the path names on the left of the generated image.
    inputBinding:
      position: 101
      prefix: --hide-path-names
  - id: highlight_node_ids
    type:
      - 'null'
      - File
    doc: Color nodes listed in FILE (one id per row) in red and all other nodes 
      in grey.
    inputBinding:
      position: 101
      prefix: --highlight-node-ids
  - id: ignore_prefix
    type:
      - 'null'
      - string
    doc: Ignore paths starting with the given *PREFIX*.
    inputBinding:
      position: 101
      prefix: --ignore-prefix
  - id: input_graph_file
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: link_path_pieces
    type:
      - 'null'
      - float
    doc: Show thin links of this relative width to connect path pieces.
    inputBinding:
      position: 101
      prefix: --link-path-pieces
  - id: longest_path
    type:
      - 'null'
      - boolean
    doc: Use the longest path length to change the color darkness.
    inputBinding:
      position: 101
      prefix: --longest-path
  - id: max_num_of_characters
    type:
      - 'null'
      - int
    doc: Maximum number of characters to display for each path name (max 128 
      characters). The default value is *the length of the longest path name* 
      (up to 128 characters).
    inputBinding:
      position: 101
      prefix: --max-num-of-characters
  - id: no_grey_depth
    type:
      - 'null'
      - boolean
    doc: Use the colorbrewer palette for <0.5x and ~1x coverage bins. By 
      default, these bins are light and neutral grey.
    inputBinding:
      position: 101
      prefix: --no-grey-depth
  - id: no_path_borders
    type:
      - 'null'
      - boolean
    doc: Don't show path borders.
    inputBinding:
      position: 101
      prefix: --no-path-borders
  - id: pack_paths
    type:
      - 'null'
      - boolean
    doc: Pack all paths rather than displaying a single path per row.
    inputBinding:
      position: 101
      prefix: --pack-paths
  - id: path_colors
    type:
      - 'null'
      - File
    doc: 'Read per-path RGB colors from FILE. Each non-empty, non-comment line must
      be: PATH<TAB>R,G,B or PATH<TAB>#RRGGBB.'
    inputBinding:
      position: 101
      prefix: --path-colors
  - id: path_height
    type:
      - 'null'
      - int
    doc: The height in pixels for a path.
    inputBinding:
      position: 101
      prefix: --path-height
  - id: path_range
    type:
      - 'null'
      - string
    doc: 'Nucleotide range to visualize: "STRING=[PATH:]start-end". "*-end" for "[0,end]";
      "start-*" for "[start,pangenome_length]". If no PATH is specified, the nucleotide
      positions refer to the pangenome’s sequence (i.e., the sequence obtained arranging
      all the graph’s node from left to right).'
    inputBinding:
      position: 101
      prefix: --path-range
  - id: path_x_padding
    type:
      - 'null'
      - int
    doc: The padding in pixels on the x-axis for a path.
    inputBinding:
      position: 101
      prefix: --path-x-padding
  - id: paths_to_display
    type:
      - 'null'
      - File
    doc: List of paths to display in the specified order; the file must contain 
      one path name per line and a subset of all paths can be specified.
    inputBinding:
      position: 101
      prefix: --paths-to-display
  - id: prefix_merges
    type:
      - 'null'
      - File
    doc: Merge paths beginning with prefixes listed (one per line) in *FILE*.
    inputBinding:
      position: 101
      prefix: --prefix-merges
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: show_strand
    type:
      - 'null'
      - boolean
    doc: Use red and blue coloring to display forward and reverse alignments. 
      This parameter can be set in combination with [-A, 
      –alignment-prefix=*STRING*].
    inputBinding:
      position: 101
      prefix: --show-strand
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: white_to_black
    type:
      - 'null'
      - boolean
    doc: Change the color darkness from white (for the first nucleotide 
      position) to black (for the last nucleotide position).
    inputBinding:
      position: 101
      prefix: --white-to-black
  - id: width
    type:
      - 'null'
      - int
    doc: Set the width in pixels of the output image
    default: 1500
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write the visualization in PNG format to this *FILE*.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
