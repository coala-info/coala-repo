cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - aggregate
label: fanc_aggregate
doc: "Make aggregate plots and matrices of a Hi-C matrix over regions (TADs, loops, ...).\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "FAN-C matrix file (e.g. Hic)."
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - File
    doc: "File with regions (BED, GFF, Tabix, ...) or region pairs (BEDPE)."
    inputBinding:
      position: 2
  - id: output
    type:
      - 'null'
      - string
    doc: "Output AggregateMatrix file for further processing."
    inputBinding:
      position: 3
  - id: save_matrix
    type:
      - 'null'
      - string
    doc: "Path to save aggregate matrix (numpy txt format)"
    inputBinding:
      position: 20
      prefix: --save-matrix
  - id: save_plot
    type:
      - 'null'
      - string
    doc: "Path to save aggregate plot (PDF)"
    inputBinding:
      position: 20
      prefix: --save-plot
  - id: tads
    type:
      - 'null'
      - boolean
    doc: "Use presets for aggregate TADs: --relative 1.0 --expected --log --vmin -1 --vmax 1"
    inputBinding:
      position: 20
      prefix: --tads
  - id: tads_imakaev
    type:
      - 'null'
      - boolean
    doc: "Use presets for aggregate TADs: --relative 1.0 --expected--rescale"
    inputBinding:
      position: 20
      prefix: --tads-imakaev
  - id: loops
    type:
      - 'null'
      - boolean
    doc: "Use presets for aggregate loops: --pixels 16 -l"
    inputBinding:
      position: 20
      prefix: --loops
  - id: loop_strength
    type:
      - 'null'
      - string
    doc: "Calculate loop strengths and save to file. Only works when providing BEDPE file, and Hi-C matrix."
    inputBinding:
      position: 20
      prefix: --loop-strength
  - id: tad_strength
    type:
      - 'null'
      - string
    doc: "Calculate tad strengths and save to file. Only works with --tads preset"
    inputBinding:
      position: 20
      prefix: --tad-strength
  - id: window
    type:
      - 'null'
      - string
    doc: "Width of the region window used for aggregation. If set, will only use the center position from the input regions and extract a submatrix of width -w around this region."
    inputBinding:
      position: 20
      prefix: --window
  - id: pixels
    type:
      - 'null'
      - int
    doc: "Width of the output image in pixels. Default: 90"
    inputBinding:
      position: 20
      prefix: --pixels
  - id: region_viewpoint
    type:
      - 'null'
      - string
    doc: "Viewpoint relative to region when using -w. By default, this measures the window from the region center. You can change this to other locations within each region using this parameter. Possible values:start, end, five_prime, three_prime, center"
    inputBinding:
      position: 20
      prefix: --region-viewpoint
  - id: boundary_mode
    type:
      - 'null'
      - string
    doc: "Points outside the boundaries of the input are filled according to the given mode. Options areconstant, edge, symmetrix, reflect, and warp.Default: reflect."
    inputBinding:
      position: 20
      prefix: --boundary-mode
  - id: interpolation
    type:
      - 'null'
      - int
    doc: "Type of interpolation to use for resizing. 0: Nearest- neighbor (default), 1: Bi-linear, 2: Bi-quadratic, 3: Bi-cubic, 4: Bi-quartic, 5: Bi-quintic"
    inputBinding:
      position: 20
      prefix: --interpolation
  - id: relative
    type:
      - 'null'
      - float
    doc: "Relative extension of each region as fraction of region length (l). Final region in the image will be: <start of region - e*l> to <end of region + e*l>. Default: 1.0 (results in 3 times region size image). Additive with \"-a\" parameter!"
    inputBinding:
      position: 20
      prefix: --relative
  - id: absolute
    type:
      - 'null'
      - string
    doc: "Extension (e) of each region in base pairs. Final region in the image will be: <start of TAD - e> to <end of TAD + e>. Default: 0 (no extension). Additive with \"-r\" parameter!"
    inputBinding:
      position: 20
      prefix: --absolute
  - id: expected_norm
    type:
      - 'null'
      - boolean
    doc: "Normalize matrix to expected values"
    inputBinding:
      position: 20
      prefix: --expected-norm
  - id: log
    type:
      - 'null'
      - boolean
    doc: "log2-transform normalized matrices. Only used in conjunction with \"-e\"."
    inputBinding:
      position: 20
      prefix: --log
  - id: rescale
    type:
      - 'null'
      - boolean
    doc: "Rescale normalized contact matrices using an a=-0.25 power law. Only used in conjunction with \"-e\"."
    inputBinding:
      position: 20
      prefix: --rescale
  - id: colormap
    type:
      - 'null'
      - string
    doc: "Matplotlib colormap to use for matrix"
    inputBinding:
      position: 20
      prefix: --colormap
  - id: vmin
    type:
      - 'null'
      - float
    doc: "Minimum saturation value in image"
    inputBinding:
      position: 20
      prefix: --vmin
  - id: vmax
    type:
      - 'null'
      - float
    doc: "Maximum saturation value in image"
    inputBinding:
      position: 20
      prefix: --vmax
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: "Do not cache chromosome matrices. Slower, but saves a lot of memory. Use this if you are having trouble with memory usage."
    inputBinding:
      position: 20
      prefix: --no-cache
  - id: keep_submatrices
    type:
      - 'null'
      - boolean
    doc: "Save all the individual matrices that make up the aggregate matrix in the output object. Useful for debugging and downstream processing. Potentially uses a lot of memory and/or disk space."
    inputBinding:
      position: 20
      prefix: --keep-submatrices
  - id: orient_by_strand
    type:
      - 'null'
      - boolean
    doc: "Flip submatrix if region is on the negative strand."
    inputBinding:
      position: 20
      prefix: --orient-by-strand
  - id: labels
    type:
      - 'null'
      - string
    doc: "Labels for the left, center, and right edge of the matrix (comma-separated)."
    inputBinding:
      position: 20
      prefix: --labels
  - id: label_locations
    type:
      - 'null'
      - string
    doc: "Relative location of ticks on bottom and left of aggregate plot (comma-separated). Ranges from 0 (left/bottom) to 1.0 (right/top). Default: 0,0.5,1.0"
    inputBinding:
      position: 20
      prefix: --label-locations
outputs:
  - id: aggregate_matrix
    type:
      - 'null'
      - File
    doc: "AggregateMatrix object."
    outputBinding:
      glob: $(inputs.output)
  - id: matrix_file
    type:
      - 'null'
      - File
    doc: "Aggregate matrix (numpy txt)."
    outputBinding:
      glob: $(inputs.save_matrix)
  - id: plot_file
    type:
      - 'null'
      - File
    doc: "Aggregate plot (PDF)."
    outputBinding:
      glob: $(inputs.save_plot)
  - id: loop_strength_file
    type:
      - 'null'
      - File
    doc: "Loop strengths."
    outputBinding:
      glob: $(inputs.loop_strength)
  - id: tad_strength_file
    type:
      - 'null'
      - File
    doc: "TAD strengths."
    outputBinding:
      glob: $(inputs.tad_strength)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
