cwlVersion: v1.2
class: CommandLineTool
baseCommand: samplot_plot
label: samplot_plot
doc: "Plot BAM/CRAM files\n\nTool homepage: https://github.com/ryanlayer/samplot"
inputs:
  - id: annotation_filenames
    type:
      - 'null'
      - type: array
        items: string
    doc: "Space-delimited list of names for the tracks in\n                      \
      \  --annotation_files"
    inputBinding:
      position: 101
      prefix: --annotation_filenames
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Space-delimited list of bed.gz tabixed files of\n                      \
      \  annotations (such as repeats, mappability, etc.)"
    inputBinding:
      position: 101
      prefix: --annotation_files
  - id: annotation_fontsize
    type:
      - 'null'
      - int
    doc: Font size for annotation labels (default 6)
    default: 6
    inputBinding:
      position: 101
      prefix: --annotation_fontsize
  - id: annotation_scalar
    type:
      - 'null'
      - float
    doc: "scaling factor for the optional annotation/trascript\n                 \
      \       tracks"
    inputBinding:
      position: 101
      prefix: --annotation_scalar
  - id: bams
    type:
      type: array
      items: File
    doc: Space-delimited list of BAM/CRAM file names
    inputBinding:
      position: 101
      prefix: --bams
  - id: chrom
    type: string
    doc: Chromosome (add multiple for translocation/BND events)
    inputBinding:
      position: 101
      prefix: --chrom
  - id: common_insert_size
    type:
      - 'null'
      - boolean
    doc: Set common insert size for all plots
    inputBinding:
      position: 101
      prefix: --common_insert_size
  - id: coverage_only
    type:
      - 'null'
      - boolean
    doc: Hide all reads and show only coverage
    inputBinding:
      position: 101
      prefix: --coverage_only
  - id: coverage_tracktype
    type:
      - 'null'
      - string
    doc: type of track to use for low MAPQ coverage plot.
    inputBinding:
      position: 101
      prefix: --coverage_tracktype
  - id: debug
    type:
      - 'null'
      - string
    doc: Print debug statements
    inputBinding:
      position: 101
      prefix: --debug
  - id: dpi
    type:
      - 'null'
      - int
    doc: Dots per inches (pixel count, default 300)
    default: 300
    inputBinding:
      position: 101
      prefix: --dpi
  - id: end
    type: int
    doc: "End position of region/variant (add multiple for\n                     \
      \   translocation/BND events)"
    inputBinding:
      position: 101
      prefix: --end
  - id: end_ci
    type:
      - 'null'
      - string
    doc: "confidence intervals of SV end breakpoint (distance\n                  \
      \      from the breakpoint). Must be a comma-separated pair\n              \
      \          of ints (i.e. 20,40)"
    inputBinding:
      position: 101
      prefix: --end_ci
  - id: hide_annotation_labels
    type:
      - 'null'
      - boolean
    doc: "Hide the label (fourth column text) from annotation\n                  \
      \      files, useful for regions with many annotations"
    inputBinding:
      position: 101
      prefix: --hide_annotation_labels
  - id: ignore_hp
    type:
      - 'null'
      - boolean
    doc: Choose to ignore HP tag in alignment files
    inputBinding:
      position: 101
      prefix: --ignore_hp
  - id: include_mqual
    type:
      - 'null'
      - int
    doc: "Min mapping quality of reads to be included in plot\n                  \
      \      (default 1)"
    default: 1
    inputBinding:
      position: 101
      prefix: --include_mqual
  - id: json_only
    type:
      - 'null'
      - boolean
    doc: Create only the json file, not the image plot
    inputBinding:
      position: 101
      prefix: --json_only
  - id: legend_fontsize
    type:
      - 'null'
      - int
    doc: Font size for legend labels (default 6)
    default: 6
    inputBinding:
      position: 101
      prefix: --legend_fontsize
  - id: long_read
    type:
      - 'null'
      - int
    doc: "Min length of a read to be treated as a long-read\n                    \
      \    (default 1000)"
    default: 1000
    inputBinding:
      position: 101
      prefix: --long_read
  - id: marker_size
    type:
      - 'null'
      - int
    doc: Size of marks on pairs and splits (default 3)
    default: 3
    inputBinding:
      position: 101
      prefix: --marker_size
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: apply a maximum coverage cutoff. Unlimited by default
    inputBinding:
      position: 101
      prefix: --max_coverage
  - id: max_coverage_points
    type:
      - 'null'
      - int
    doc: "number of points to plot in coverage axis (downsampled\n               \
      \         from region size for speed)"
    inputBinding:
      position: 101
      prefix: --max_coverage_points
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Max number of normal pairs to plot
    inputBinding:
      position: 101
      prefix: --max_depth
  - id: min_event_size
    type:
      - 'null'
      - int
    doc: "Min size of an event in long-read CIGAR to include\n                   \
      \     (default 20)"
    default: 20
    inputBinding:
      position: 101
      prefix: --min_event_size
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory name. Defaults to working dir.\n                      \
      \  Ignored if --output_file is set"
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: plot_height
    type:
      - 'null'
      - int
    doc: Plot height
    inputBinding:
      position: 101
      prefix: --plot_height
  - id: plot_width
    type:
      - 'null'
      - int
    doc: Plot width
    inputBinding:
      position: 101
      prefix: --plot_width
  - id: print_args
    type:
      - 'null'
      - boolean
    doc: "Print commandline arguments to a json file, useful\n                   \
      \     with PlotCritic"
    inputBinding:
      position: 101
      prefix: --print_args
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file for CRAM, required if CRAM files used
    inputBinding:
      position: 101
      prefix: --reference
  - id: same_yaxis_scales
    type:
      - 'null'
      - boolean
    doc: Set the scales of the Y axes to the max of all
    inputBinding:
      position: 101
      prefix: --same_yaxis_scales
  - id: separate_mqual
    type:
      - 'null'
      - int
    doc: "coverage from reads with MAPQ <= separate_mqual\n                      \
      \  plotted in lighter grey. To disable, pass in negative\n                 \
      \       value"
    inputBinding:
      position: 101
      prefix: --separate_mqual
  - id: start
    type: int
    doc: "Start position of region/variant (add multiple for\n                   \
      \     translocation/BND events)"
    inputBinding:
      position: 101
      prefix: --start
  - id: start_ci
    type:
      - 'null'
      - string
    doc: "confidence intervals of SV first breakpoint (distance\n                \
      \        from the breakpoint). Must be a comma-separated pair\n            \
      \            of ints (i.e. 20,40)"
    inputBinding:
      position: 101
      prefix: --start_ci
  - id: sv_type
    type:
      - 'null'
      - string
    doc: "SV type. If omitted, plot is created without variant\n                 \
      \       bar"
    inputBinding:
      position: 101
      prefix: --sv_type
  - id: titles
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-delimited list of plot titles. Use quote marks to include spaces 
      (i.e. "plot 1" "plot 2")
    inputBinding:
      position: 101
      prefix: --titles
  - id: transcript_file
    type:
      - 'null'
      - File
    doc: GFF3 of transcripts
    inputBinding:
      position: 101
      prefix: --transcript_file
  - id: transcript_filename
    type:
      - 'null'
      - string
    doc: Name for transcript track
    inputBinding:
      position: 101
      prefix: --transcript_filename
  - id: window
    type:
      - 'null'
      - int
    doc: "Window size (count of bases to include in view),\ndefault(0.5 * len)"
    inputBinding:
      position: 101
      prefix: --window
  - id: xaxis_label_fontsize
    type:
      - 'null'
      - int
    doc: Font size for X-axis labels (default 6)
    default: 6
    inputBinding:
      position: 101
      prefix: --xaxis_label_fontsize
  - id: yaxis_label_fontsize
    type:
      - 'null'
      - int
    doc: Font size for Y-axis labels (default 6)
    default: 6
    inputBinding:
      position: 101
      prefix: --yaxis_label_fontsize
  - id: z
    type:
      - 'null'
      - float
    doc: Number of stdevs from the mean (default 4)
    default: 4
    inputBinding:
      position: 101
      prefix: --z
  - id: zoom
    type:
      - 'null'
      - int
    doc: "Only show +- zoom amount around breakpoints, much\n                    \
      \    faster for large regions. Ignored if region smaller\n                 \
      \       than --zoom (default 500000)"
    default: 500000
    inputBinding:
      position: 101
      prefix: --zoom
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output file name/type. Defaults to\n                        {type}_{chrom}_{start}_{end}.png"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samplot:1.3.0--pyh5e36f6f_1
