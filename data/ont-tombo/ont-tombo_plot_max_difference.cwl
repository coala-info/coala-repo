cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot
  - max_difference
label: ont-tombo_plot_max_difference
doc: "Plot raw signal where signal differs most between two read groups.\n\nTool homepage: https://github.com/nanoporetech/tombo"
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
  - id: control_fast5_basedirs
    type:
      type: array
      items: Directory
    doc: "Set of directories containing fast5 files for control reads, containing only canonical nucleotides."
    inputBinding:
      position: 101
      prefix: "--control-fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
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
  - id: pdf_filename
    type:
      - 'null'
      - string
    doc: "PDF filename to store plot(s). Default: tombo_results.max_difference.pdf"
    default: "tombo_results.max_difference.pdf"
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
