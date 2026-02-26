cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot_most_significant
label: tombo_plot_most_significant
doc: "Plot the most significant regions of difference between two sets of FAST5 files
  or based on statistics.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: alternate_model_filename
    type:
      - 'null'
      - File
    doc: Tombo model for alternative likelihood ratio significance testing.
    inputBinding:
      position: 101
      prefix: --alternate-model-filename
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    default: BaseCalled_template
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
    default: RawGenomeCorrected_000
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
  - id: num_bases
    type:
      - 'null'
      - int
    doc: Number of bases to plot/output.
    default: 21
    inputBinding:
      position: 101
      prefix: --num-bases
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    default: 10
    inputBinding:
      position: 101
      prefix: --num-regions
  - id: overplot_threshold
    type:
      - 'null'
      - int
    doc: Coverage level to trigger alternative plot type instead of raw signal.
    default: 50
    inputBinding:
      position: 101
      prefix: --overplot-threshold
  - id: overplot_type
    type:
      - 'null'
      - string
    doc: 'Plot type for regions with higher coverage. Options: {Downsample,Boxplot,Quantile,Density}'
    default: Downsample
    inputBinding:
      position: 101
      prefix: --overplot-type
  - id: plot_alternate_model
    type:
      - 'null'
      - string
    doc: 'Add alternative model distribution to the plot. Options: {5mC}'
    inputBinding:
      position: 101
      prefix: --plot-alternate-model
  - id: plot_standard_model
    type:
      - 'null'
      - boolean
    doc: Add default standard model distribution to the plot.
    inputBinding:
      position: 101
      prefix: --plot-standard-model
  - id: q_value_threshold
    type:
      - 'null'
      - float
    doc: Plot all regions below provied q-value. Overrides --num-regions.
    inputBinding:
      position: 101
      prefix: --q-value-threshold
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
  - id: sequences_filename
    type:
      - 'null'
      - File
    doc: File for sequences from selected regions. Sequences will be stored in 
      FASTA format.
    outputBinding:
      glob: $(inputs.sequences_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
