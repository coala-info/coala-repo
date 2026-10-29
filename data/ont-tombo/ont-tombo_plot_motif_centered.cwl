cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot
  - motif_centered
label: ont-tombo_plot_motif_centered
doc: "Plot raw signal at a specific motif.\n\nTool homepage: https://github.com/nanoporetech/tombo"
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
  - id: deepest_coverage
    type:
      - 'null'
      - boolean
    doc: "Plot the deepest coverage regions."
    inputBinding:
      position: 101
      prefix: "--deepest-coverage"
  - id: pdf_filename
    type:
      - 'null'
      - string
    doc: "PDF filename to store plot(s). Default: tombo_results.motif_centered.pdf"
    default: "tombo_results.motif_centered.pdf"
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
