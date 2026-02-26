cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot_genome_location
label: tombo_plot_genome_location
doc: "Plot raw signal at specific genomic locations from fast5 files.\n\nTool homepage:
  https://github.com/nanoporetech/tombo"
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
  - id: genome_locations
    type:
      type: array
      items: string
    doc: Genomic locations at which to plot signal. Format locations as 
      "chrm:position[:strand] [chrm2:position2[:strand2] ...]"
    inputBinding:
      position: 101
      prefix: --genome-locations
  - id: num_bases
    type:
      - 'null'
      - int
    doc: Number of bases to plot/output.
    default: 21
    inputBinding:
      position: 101
      prefix: --num-bases
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
    doc: Plot type for regions with higher coverage (Downsample, Boxplot, 
      Quantile, Density).
    default: Downsample
    inputBinding:
      position: 101
      prefix: --overplot-type
  - id: plot_alternate_model
    type:
      - 'null'
      - string
    doc: Add alternative model distribution to the plot (e.g., 5mC).
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
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
