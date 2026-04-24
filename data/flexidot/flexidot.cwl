cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexidot
label: flexidot
doc: "FlexiDot: Flexible dotplot generation tool\n\nTool homepage: https://github.com/flexidot-bio/flexidot"
inputs:
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Pre-calculated alignment file (BLAST6 or PAF format). When provided, alignments
      from this file will be plotted instead of performing k-mer matching.
    inputBinding:
      position: 101
      prefix: --alignment_file
  - id: alignment_format
    type:
      - 'null'
      - string
    doc: "Format of the alignment file: 'blast6' or 'paf'. If not specified, format
      is auto-detected from file extension."
    inputBinding:
      position: 101
      prefix: --alignment_format
  - id: collage
    type:
      - 'null'
      - boolean
    doc: Combine multiple dotplots in a collage.
    inputBinding:
      position: 101
      prefix: --collage
  - id: filetype
    type:
      - 'null'
      - string
    doc: 'Output file format: png, pdf, svg'
    inputBinding:
      position: 101
      prefix: --filetype
  - id: gff
    type:
      - 'null'
      - type: array
        items: File
    doc: GFF3 files for markup in self-dotplots. Provide a space-delimited list of
      GFF files.
    inputBinding:
      position: 101
      prefix: --gff
  - id: gff_color_config
    type:
      - 'null'
      - File
    doc: Config file for custom GFF shading.
    inputBinding:
      position: 101
      prefix: --gff_color_config
  - id: infiles
    type:
      type: array
      items: File
    doc: Input fasta files (fasta file name or space-separated file list.)
    inputBinding:
      position: 101
      prefix: --infiles
  - id: label_size
    type:
      - 'null'
      - int
    doc: Font size
    inputBinding:
      position: 101
      prefix: --label_size
  - id: lcs_shading
    type:
      - 'null'
      - boolean
    doc: Shade subdotplot based on longest common subsequence (LCS).
    inputBinding:
      position: 101
      prefix: --lcs_shading
  - id: lcs_shading_interval_len
    type:
      - 'null'
      - int
    doc: Length of intervals for LCS shading (only if --lcs_shading_ref=2)
    inputBinding:
      position: 101
      prefix: --lcs_shading_interval_len
  - id: lcs_shading_num
    type:
      - 'null'
      - int
    doc: Number of shading intervals.
    inputBinding:
      position: 101
      prefix: --lcs_shading_num
  - id: lcs_shading_ori
    type:
      - 'null'
      - int
    doc: Shade subdotplots based on LCS 0 = forward [default] 1 = reverse, or 2 =
      both strands
    inputBinding:
      position: 101
      prefix: --lcs_shading_ori
  - id: lcs_shading_ref
    type:
      - 'null'
      - int
    doc: Reference for LCS shading. 0 = maximal LCS length [default] 1 = maximally
      possible length 2 = given interval sizes
    inputBinding:
      position: 101
      prefix: --lcs_shading_ref
  - id: length_scaling
    type:
      - 'null'
      - boolean
    doc: Scale plot size for pairwise comparison.
    inputBinding:
      position: 101
      prefix: --length_scaling
  - id: line_col_for
    type:
      - 'null'
      - string
    doc: Line color
    inputBinding:
      position: 101
      prefix: --line_col_for
  - id: line_col_rev
    type:
      - 'null'
      - string
    doc: Reverse line color
    inputBinding:
      position: 101
      prefix: --line_col_rev
  - id: line_width
    type:
      - 'null'
      - int
    doc: Line width
    inputBinding:
      position: 101
      prefix: --line_width
  - id: loglevel
    type:
      - 'null'
      - string
    doc: "Set logging level. Default: 'INFO'"
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: max_n
    type:
      - 'null'
      - int
    doc: Maximum percentage of Ns allowed in a kmer window. Applies only if --wobble_conversion
      is set, else kmers with Ns are skipped.
    inputBinding:
      position: 101
      prefix: --max_n
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum percent identity for filtering alignments (0-100).
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length for filtering.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: mirror_y_axis
    type:
      - 'null'
      - boolean
    doc: Flip y-axis (bottom-to-top or top-to-bottom)
    inputBinding:
      position: 101
      prefix: --mirror_y_axis
  - id: mode
    type:
      - 'null'
      - int
    doc: Mode of FlexiDot dotplotting. 0 = self [default], 1 = paired, 2 = poly (matrix
      with all-against-all dotplots). Call -m multiple times to run multiple modes.
    inputBinding:
      position: 101
      prefix: --mode
  - id: n_col
    type:
      - 'null'
      - int
    doc: Number of columns per page (if collage is ON.
    inputBinding:
      position: 101
      prefix: --n_col
  - id: n_row
    type:
      - 'null'
      - int
    doc: Number of rows per page (if collage is ON).
    inputBinding:
      position: 101
      prefix: --n_row
  - id: norev
    type:
      - 'null'
      - boolean
    doc: Do not calculate reverse complementary matches (only for nucleotide sequences.)
    inputBinding:
      position: 101
      prefix: --norev
  - id: only_vs_first_seq
    type:
      - 'null'
      - boolean
    doc: Limit pairwise comparisons to the 1st sequence only (if plotting mode=1 paired.)
    inputBinding:
      position: 101
      prefix: --only_vs_first_seq
  - id: plot_size
    type:
      - 'null'
      - int
    doc: Plot size
    inputBinding:
      position: 101
      prefix: --plot_size
  - id: representation
    type:
      - 'null'
      - int
    doc: 'Region of plot to display. Only if plotting mode is 2: polyplot 0 = full
      [default] 1 = upper 2 = lower'
    inputBinding:
      position: 101
      prefix: --representation
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort sequences alphabetically by name.
    inputBinding:
      position: 101
      prefix: --sort
  - id: spacing
    type:
      - 'null'
      - float
    doc: Spacing between dotplots (if plotting mode=2 polyplot).
    inputBinding:
      position: 101
      prefix: --spacing
  - id: substitution_count
    type:
      - 'null'
      - int
    doc: Number of substitutions allowed per window.
    inputBinding:
      position: 101
      prefix: --substitution_count
  - id: title_length
    type:
      - 'null'
      - int
    doc: 'Limit title length for comparisons. Default: 50 characters'
    inputBinding:
      position: 101
      prefix: --title_length
  - id: type_seq
    type:
      - 'null'
      - string
    doc: 'Biological sequence type: aa (amino acid) or nuc (nucleotide).'
    inputBinding:
      position: 101
      prefix: --type_seq
  - id: user_matrix_file
    type:
      - 'null'
      - File
    doc: Matrix file for shading above diagonal.
    inputBinding:
      position: 101
      prefix: --user_matrix_file
  - id: user_matrix_print
    type:
      - 'null'
      - boolean
    doc: Display matrix entries above diagonal.
    inputBinding:
      position: 101
      prefix: --user_matrix_print
  - id: wobble_conversion
    type:
      - 'null'
      - boolean
    doc: 'Ambiguity handling for relaxed matching. Note: This may make kmer matching
      slower.'
    inputBinding:
      position: 101
      prefix: --wobble_conversion
  - id: wordsize
    type:
      - 'null'
      - int
    doc: Wordsize (kmer length) for dotplot comparison.
    inputBinding:
      position: 101
      prefix: --wordsize
  - id: x_label_pos
    type:
      - 'null'
      - string
    doc: "Position of the X-label. Default: 'top'"
    inputBinding:
      position: 101
      prefix: --x_label_pos
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: File prefix to be added to the generated filenames.
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'Output directory. Default: current directory.'
    outputBinding:
      glob: $(inputs.outdir)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Name of log file
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexidot:2.1.0--pyhdfd78af_0
