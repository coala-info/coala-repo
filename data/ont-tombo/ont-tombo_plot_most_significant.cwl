cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot
  - most_significant
label: ont-tombo_plot_most_significant
doc: "Plot raw signal at most modified locations.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: "Directories containing fast5 files."
    inputBinding:
      position: 101
      prefix: "--fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: statistics_filename
    type: File
    doc: "File to save/load genomic base anchored statistics."
    inputBinding:
      position: 101
      prefix: "--statistics-filename"
  - id: control_fast5_basedirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "Set of directories containing fast5 files for control reads, containing only canonical nucleotides."
    inputBinding:
      position: 101
      prefix: "--control-fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: plot_standard_model
    type:
      - 'null'
      - boolean
    doc: "Add default standard model distribution to the plot."
    inputBinding:
      position: 101
      prefix: "--plot-standard-model"
  - id: plot_alternate_model
    type:
      - 'null'
      - string
    doc: "Add alternative model distribution to the plot."
    inputBinding:
      position: 101
      prefix: "--plot-alternate-model"
  - id: overplot_threshold
    type:
      - 'null'
      - int
    doc: "Coverage level to trigger alternative plot type instead of raw signal. Default: 50"
    inputBinding:
      position: 101
      prefix: "--overplot-threshold"
  - id: overplot_type
    type:
      - 'null'
      - string
    doc: "Plot type for regions with higher coverage. Default: Downsample"
    inputBinding:
      position: 101
      prefix: "--overplot-type"
  - id: num_regions
    type:
      - 'null'
      - int
    doc: "Number of regions to plot. Default: 10"
    inputBinding:
      position: 101
      prefix: "--num-regions"
  - id: num_bases
    type:
      - 'null'
      - int
    doc: "Number of bases to plot/output. Default: 21"
    inputBinding:
      position: 101
      prefix: "--num-bases"
  - id: coverage_dampen_counts
    type:
      - 'null'
      - type: array
        items: float
    doc: "Dampen fraction modified estimates for low coverage sites. Two parameters are unmodified and modified pseudo read counts. This is equivalent to a beta prior on the fraction estimate. Set to \"0 0\" to disable dampened fraction estimation. Default: [2, 0]"
    inputBinding:
      position: 101
      prefix: "--coverage-dampen-counts"
  - id: pdf_filename
    type:
      - 'null'
      - string
    doc: "PDF filename to store plot(s). Default: tombo_results.significant_difference.pdf"
    default: "tombo_results.significant_difference.pdf"
    inputBinding:
      position: 101
      prefix: "--pdf-filename"
  - id: sequences_filename
    type:
      - 'null'
      - string
    doc: "File for sequences from selected regions. Sequences will be stored in FASTA format. Default: None."
    inputBinding:
      position: 101
      prefix: "--sequences-filename"
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: "FAST5 group created by resquiggle command. Default: RawGenomeCorrected_000"
    inputBinding:
      position: 101
      prefix: "--corrected-group"
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: "FAST5 subgroup(s) (under /Analyses/[--basecall- group]/) containing basecalls and created within [--corrected-group] containing re-squiggle results. Default: ['BaseCalled_template']"
    inputBinding:
      position: 101
      prefix: "--basecall-subgroups"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't print status information."
    inputBinding:
      position: 101
      prefix: "--quiet"
outputs:
  - id: plot_pdf
    type: File
    doc: "PDF with the plots"
    outputBinding:
      glob: "$(inputs.pdf_filename)"
  - id: sequences_file
    type:
      - 'null'
      - File
    doc: "FASTA file of plotted sequences written with --sequences-filename"
    outputBinding:
      glob: "$(inputs.sequences_filename ? [inputs.sequences_filename] : [])"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
      - entry: $(inputs.control_fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
