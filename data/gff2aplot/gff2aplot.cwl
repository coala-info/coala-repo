cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff2aplot
label: gff2aplot
doc: "Convert GFF files for pairwise alignments (and the annotations of the two sequences) into a color-filled alignment plot in PostScript. The PostScript is written to standard output.\n\nTool homepage: http://genome.imim.es/software/gfftools/GFF2APLOT.html"
inputs:
  - id: gff_files
    type:
      type: array
      items: File
    doc: "Input GFF file(s): the alignment and the annotations of the X and Y sequences."
    inputBinding:
      position: 200
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose mode, a full report is sent to standard error (default is set to showing only WARNINGS)."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: logs_filename
    type:
      - 'null'
      - string
    doc: "Report is written to a log file (created in the working directory)."
    inputBinding:
      position: 101
      prefix: --logs-filename
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Quiet mode, do not show any message/warning to standard error (reporting only ERRORS)."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: page_bbox
    type:
      - 'null'
      - string
    doc: "User-defined page size as <width,height>; points if no unit is given, or pt, mm, cm, in. Overrides ANY page-size definition."
    inputBinding:
      position: 101
      prefix: --page-bbox
  - id: page_size
    type:
      - 'null'
      - string
    doc: "Page size among the pre-defined formats (A0 to A10, B0 to B10, 10x14, executive, folio, ledger, legal, letter, quarto, statement, tabloid)."
    inputBinding:
      position: 101
      prefix: --page-size
  - id: margin_left
    type:
      - 'null'
      - string
    doc: "Left page margin (points, or with units pt, mm, cm, in)."
    inputBinding:
      position: 101
      prefix: --margin-left
  - id: margin_right
    type:
      - 'null'
      - string
    doc: "Right page margin."
    inputBinding:
      position: 101
      prefix: --margin-right
  - id: margin_top
    type:
      - 'null'
      - string
    doc: "Top page margin."
    inputBinding:
      position: 101
      prefix: --margin-top
  - id: margin_bottom
    type:
      - 'null'
      - string
    doc: "Bottom page margin."
    inputBinding:
      position: 101
      prefix: --margin-bottom
  - id: background_color
    type:
      - 'null'
      - string
    doc: "Background color."
    inputBinding:
      position: 101
      prefix: --background-color
  - id: foreground_color
    type:
      - 'null'
      - string
    doc: "Foreground color."
    inputBinding:
      position: 101
      prefix: --foreground-color
  - id: title
    type:
      - 'null'
      - string
    doc: "Plot title."
    inputBinding:
      position: 101
      prefix: --title
  - id: subtitle
    type:
      - 'null'
      - string
    doc: "Plot subtitle."
    inputBinding:
      position: 101
      prefix: --subtitle
  - id: x_label
    type:
      - 'null'
      - string
    doc: "X-axis label."
    inputBinding:
      position: 101
      prefix: --x-label
  - id: y_label
    type:
      - 'null'
      - string
    doc: "Y-axis label."
    inputBinding:
      position: 101
      prefix: --y-label
  - id: percent_box_label
    type:
      - 'null'
      - string
    doc: "Percent-box label."
    inputBinding:
      position: 101
      prefix: --percent-box-label
  - id: extra_box_label
    type:
      - 'null'
      - string
    doc: "Extra-box label."
    inputBinding:
      position: 101
      prefix: --extra-box-label
  - id: x_sequence_coords
    type:
      - 'null'
      - string
    doc: "X-sequence coordinates as <pos..pos>."
    inputBinding:
      position: 101
      prefix: --x-sequence-coords
  - id: start_x_sequence
    type:
      - 'null'
      - int
    doc: "Sets X-sequence first nucleotide."
    inputBinding:
      position: 101
      prefix: --start-x-sequence
  - id: end_x_sequence
    type:
      - 'null'
      - int
    doc: "Sets X-sequence last nucleotide."
    inputBinding:
      position: 101
      prefix: --end-x-sequence
  - id: y_sequence_coords
    type:
      - 'null'
      - string
    doc: "Y-sequence coordinates as <pos..pos>."
    inputBinding:
      position: 101
      prefix: --y-sequence-coords
  - id: start_y_sequence
    type:
      - 'null'
      - int
    doc: "Sets Y-sequence first nucleotide."
    inputBinding:
      position: 101
      prefix: --start-y-sequence
  - id: end_y_sequence
    type:
      - 'null'
      - int
    doc: "Sets Y-sequence last nucleotide."
    inputBinding:
      position: 101
      prefix: --end-y-sequence
  - id: x_sequence_zoom
    type:
      - 'null'
      - string
    doc: "X-sequence zoom region as <pos..pos>."
    inputBinding:
      position: 101
      prefix: --x-sequence-zoom
  - id: y_sequence_zoom
    type:
      - 'null'
      - string
    doc: "Y-sequence zoom region as <pos..pos>."
    inputBinding:
      position: 101
      prefix: --y-sequence-zoom
  - id: zoom
    type:
      - 'null'
      - boolean
    doc: "Zooms the area selected with the start/end sequence options."
    inputBinding:
      position: 101
      prefix: --zoom
  - id: zoom_area
    type:
      - 'null'
      - boolean
    doc: "Marks the zoom area on the plot, but does not zoom."
    inputBinding:
      position: 101
      prefix: --zoom-area
  - id: alignment_name
    type:
      - 'null'
      - string
    doc: "Which alignment is plotted if the GFF input has more than one, as <SeqXName:SeqYName>."
    inputBinding:
      position: 101
      prefix: --alignment-name
  - id: x_sequence_name
    type:
      - 'null'
      - string
    doc: "Which sequence is plotted on the X-axis."
    inputBinding:
      position: 101
      prefix: --x-sequence-name
  - id: y_sequence_name
    type:
      - 'null'
      - string
    doc: "Which sequence is plotted on the Y-axis."
    inputBinding:
      position: 101
      prefix: --y-sequence-name
  - id: aplot_xy_noteq
    type:
      - 'null'
      - boolean
    doc: "X and Y axes get lengths proportional to their nucleotide lengths (by default both axes have the same length)."
    inputBinding:
      position: 101
      prefix: --aplot-xy-noteq
  - id: xy_axes_scale
    type:
      - 'null'
      - string
    doc: "Scale between X and Y axes lengths as an X/Y ratio (default 1)."
    inputBinding:
      position: 101
      prefix: --xy-axes-scale
  - id: aln_scale_width
    type:
      - 'null'
      - boolean
    doc: "Scaling score on width for Aplot lines."
    inputBinding:
      position: 101
      prefix: --aln-scale-width
  - id: aln_scale_color
    type:
      - 'null'
      - boolean
    doc: "Scaling score on color for Aplot lines."
    inputBinding:
      position: 101
      prefix: --aln-scale-color
  - id: show_ribbons
    type:
      - 'null'
      - string
    doc: "Force ribbons for all features on axes: (N)one, (L)ines, (R)ibbons, (B)oth."
    inputBinding:
      position: 101
      prefix: --show-ribbons
  - id: show_grid
    type:
      - 'null'
      - boolean
    doc: "Switches grid on."
    inputBinding:
      position: 101
      prefix: --show-grid
  - id: hide_grid
    type:
      - 'null'
      - boolean
    doc: "Switches grid off."
    inputBinding:
      position: 101
      prefix: --hide-grid
  - id: show_percent_box
    type:
      - 'null'
      - boolean
    doc: "Switches the percent box on."
    inputBinding:
      position: 101
      prefix: --show-percent-box
  - id: hide_percent_box
    type:
      - 'null'
      - boolean
    doc: "Switches the percent box off."
    inputBinding:
      position: 101
      prefix: --hide-percent-box
  - id: show_extra_box
    type:
      - 'null'
      - boolean
    doc: "Switches the extra box on."
    inputBinding:
      position: 101
      prefix: --show-extra-box
  - id: hide_extra_box
    type:
      - 'null'
      - boolean
    doc: "Switches the extra box off."
    inputBinding:
      position: 101
      prefix: --hide-extra-box
  - id: aplot_box_color
    type:
      - 'null'
      - string
    doc: "Aplot main box background color."
    inputBinding:
      position: 101
      prefix: --aplot-box-color
  - id: percent_box_color
    type:
      - 'null'
      - string
    doc: "Percent box background color."
    inputBinding:
      position: 101
      prefix: --percent-box-color
  - id: extra_box_color
    type:
      - 'null'
      - string
    doc: "Extra box background color."
    inputBinding:
      position: 101
      prefix: --extra-box-color
  - id: nopswarnings
    type:
      - 'null'
      - boolean
    doc: "Switch off warnings on the final PostScript figure when X sequence, Y sequence and/or alignment data is missing."
    inputBinding:
      position: 101
      prefix: --nopswarnings
  - id: hide_credits
    type:
      - 'null'
      - boolean
    doc: "Switch off the gff2aplot credits line on the plot."
    inputBinding:
      position: 101
      prefix: --hide-credits
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Report variable contents when testing (requires logs_filename)."
    inputBinding:
      position: 101
      prefix: --debug
  - id: layout_var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --layout-var
    doc: "Layout customization variable '<variable=value>'; repeat for several."
    inputBinding:
      position: 102
  - id: sequence_var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sequence-var
    doc: "Sequence customization variable '<sequence::variable=value>'; repeat for several."
    inputBinding:
      position: 102
  - id: source_var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --source-var
    doc: "Source customization variable '<source::variable=value>'; repeat for several."
    inputBinding:
      position: 102
  - id: strand_var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --strand-var
    doc: "Strand customization variable '<strand::variable=value>'; repeat for several."
    inputBinding:
      position: 102
  - id: group_var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --group-var
    doc: "Group customization variable '<group::variable=value>'; repeat for several."
    inputBinding:
      position: 102
  - id: feature_var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --feature-var
    doc: "Feature customization variable '<feature::variable=value>'; repeat for several."
    inputBinding:
      position: 102
  - id: custom_filename
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --custom-filename
    doc: Customization file(s) loaded after the default .gff2aplotrc; repeat for several.
    inputBinding:
      position: 103
arguments:
  - position: 199
    valueFrom: "--"
outputs:
  - id: postscript
    type: stdout
    doc: The alignment plot in PostScript.
  - id: logs_file
    type:
      - 'null'
      - File
    doc: Report file, written when logs_filename is given.
    outputBinding:
      glob: $(inputs.logs_filename)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gff2aplot:v2.0-11-deb_cv1
stdout: gff2aplot.ps
