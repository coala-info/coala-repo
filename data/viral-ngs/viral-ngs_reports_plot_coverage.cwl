cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reports.py
  - plot_coverage
label: viral-ngs_reports_plot_coverage
doc: "Generate a coverage plot from an aligned bam file\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input reads, BAM format."
    inputBinding:
      position: 1
  - id: out_plot_file
    type: string
    doc: "The generated chart file"
    inputBinding:
      position: 2
  - id: plot_format
    type:
      - 'null'
      - string
    doc: "File format of the coverage plot. By default it is inferred from the file extension of out_plot_file."
    inputBinding:
      position: 20
      prefix: --plotFormat
  - id: plot_data_style
    type:
      - 'null'
      - string
    doc: "The plot data display style. Valid options: filled, line, dots (default: filled)"
    inputBinding:
      position: 20
      prefix: --plotDataStyle
  - id: plot_style
    type:
      - 'null'
      - string
    doc: "The plot visual style (default: ggplot)"
    inputBinding:
      position: 20
      prefix: --plotStyle
  - id: plot_width
    type:
      - 'null'
      - int
    doc: "Width of the plot in pixels (default: 1024)"
    inputBinding:
      position: 20
      prefix: --plotWidth
  - id: plot_height
    type:
      - 'null'
      - int
    doc: "Height of the plot in pixels (default: 768)"
    inputBinding:
      position: 20
      prefix: --plotHeight
  - id: plot_dpi
    type:
      - 'null'
      - float
    doc: "dots per inch for rendered output, more useful for vector modes (default: 80.0)"
    inputBinding:
      position: 20
      prefix: --plotDPI
  - id: plot_title
    type:
      - 'null'
      - string
    doc: "The title displayed on the coverage plot (default: 'Coverage Plot')"
    inputBinding:
      position: 20
      prefix: --plotTitle
  - id: base_q_threshold
    type:
      - 'null'
      - int
    doc: "The minimum base quality threshold"
    inputBinding:
      position: 20
      prefix: -q
  - id: mapping_q_threshold
    type:
      - 'null'
      - int
    doc: "The minimum mapping quality threshold"
    inputBinding:
      position: 20
      prefix: -Q
  - id: max_coverage_depth
    type:
      - 'null'
      - int
    doc: "The max coverage depth (default: 1000000)"
    inputBinding:
      position: 20
      prefix: -m
  - id: read_length_threshold
    type:
      - 'null'
      - int
    doc: "Read length threshold"
    inputBinding:
      position: 20
      prefix: -l
  - id: out_summary
    type:
      - 'null'
      - string
    doc: "Coverage summary TSV file. Default is to write to temp."
    inputBinding:
      position: 20
      prefix: --outSummary
  - id: plot_only_non_duplicates
    type:
      - 'null'
      - boolean
    doc: "Plot only non-duplicates (samtools -F 1024)"
    inputBinding:
      position: 20
      prefix: --plotOnlyNonDuplicates
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_plot
    type: File
    doc: "Coverage plot"
    outputBinding:
      glob: $(inputs.out_plot_file)
  - id: out_summary_file
    type:
      - 'null'
      - File
    doc: "Coverage summary TSV"
    outputBinding:
      glob: $(inputs.out_summary)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_reports_plot_coverage.out
