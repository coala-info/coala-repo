cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot
  - motif_with_stats
label: ont-tombo_plot_motif_with_stats
doc: "Plot example signal and statistic distributions around a motif of interst.\n\nTool homepage: https://github.com/nanoporetech/tombo"
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
  - id: motif
    type: string
    doc: "Motif of interest at which to plot signal and statsitics. Supports IUPAC single letter codes (use T for RNA)."
    inputBinding:
      position: 101
      prefix: "--motif"
  - id: statistics_filename
    type: File
    doc: "File to save/load genomic base anchored statistics."
    inputBinding:
      position: 101
      prefix: "--statistics-filename"
  - id: genome_fasta
    type: File
    doc: "FASTA file used to re-squiggle. For faster sequence access."
    inputBinding:
      position: 101
      prefix: "--genome-fasta"
      valueFrom: "$(self.basename)"
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
  - id: num_regions
    type:
      - 'null'
      - int
    doc: "Number of regions to plot. Default: 3"
    inputBinding:
      position: 101
      prefix: "--num-regions"
  - id: num_context
    type:
      - 'null'
      - int
    doc: "Number of context bases around motif. Default: 5"
    inputBinding:
      position: 101
      prefix: "--num-context"
  - id: num_statistics
    type:
      - 'null'
      - int
    doc: "Number of motif centered regions to include in statistic distributions. Default: 200"
    inputBinding:
      position: 101
      prefix: "--num-statistics"
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
    doc: "PDF filename to store plot(s). Default: tombo_results.motif_statistics.pdf"
    default: "tombo_results.motif_statistics.pdf"
    inputBinding:
      position: 101
      prefix: "--pdf-filename"
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
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_fasta)
        writable: true
      - entry: $(inputs.fast5_basedirs)
        writable: true
      - entry: $(inputs.control_fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
