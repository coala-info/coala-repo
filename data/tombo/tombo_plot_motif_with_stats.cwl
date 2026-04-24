cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot_motif_with_stats
label: tombo_plot_motif_with_stats
doc: "Plot signal and statistics at a specific motif using Tombo.\n\nTool homepage:
  https://github.com/nanoporetech/tombo"
inputs:
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    inputBinding:
      position: 101
      prefix: --basecall-subgroups
  - id: control_fast5_basedirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Control set of directories containing fast5 files. These reads should 
      contain only standard nucleotides.
    inputBinding:
      position: 101
      prefix: --control-fast5-basedirs
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
  - id: motif
    type: string
    doc: Motif of interest at which to plot signal and statsitics. Supports 
      IUPAC single letter codes (use T for RNA).
    inputBinding:
      position: 101
      prefix: --motif
  - id: num_context
    type:
      - 'null'
      - int
    doc: Number of context bases around motif.
    inputBinding:
      position: 101
      prefix: --num-context
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    inputBinding:
      position: 101
      prefix: --num-regions
  - id: num_statistics
    type:
      - 'null'
      - int
    doc: Number of motif centered regions to include in statistic distributions.
    inputBinding:
      position: 101
      prefix: --num-statistics
  - id: overplot_threshold
    type:
      - 'null'
      - int
    doc: Coverage level to trigger alternative plot type instead of raw signal.
    inputBinding:
      position: 101
      prefix: --overplot-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: statistic_order
    type:
      - 'null'
      - boolean
    doc: 'Order selected locations by p-values or mean likelihood ratio. Default:
      fraction of significant reads.'
    inputBinding:
      position: 101
      prefix: --statistic-order
  - id: statistics_filename
    type: File
    doc: File to save/load base by base statistics.
    inputBinding:
      position: 101
      prefix: --statistics-filename
  - id: tombo_model_filename
    type:
      - 'null'
      - File
    doc: Tombo model for event-less resquiggle and significance testing. If no 
      model is provided the default DNA or RNA tombo model will be used.
    inputBinding:
      position: 101
      prefix: --tombo-model-filename
outputs:
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    outputBinding:
      glob: $(inputs.pdf_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
