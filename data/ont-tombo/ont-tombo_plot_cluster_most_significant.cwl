cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot
  - cluster_most_significant
label: ont-tombo_plot_cluster_most_significant
doc: "Clustering traces at bases with most significant stats.\n\nTool homepage: https://github.com/nanoporetech/tombo"
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
  - id: statistics_filename
    type: File
    doc: "File to save/load genomic base anchored statistics."
    inputBinding:
      position: 101
      prefix: "--statistics-filename"
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: "FASTA file used to re-squiggle. For faster sequence access."
    inputBinding:
      position: 101
      prefix: "--genome-fasta"
      valueFrom: "$(self.basename)"
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes. Default: 1"
    inputBinding:
      position: 101
      prefix: "--processes"
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
  - id: slide_span
    type:
      - 'null'
      - int
    doc: "Number of bases offset over which to search when computing distances for signal cluster plotting. Default: 0 (exact position)"
    inputBinding:
      position: 101
      prefix: "--slide-span"
  - id: pdf_filename
    type:
      - 'null'
      - string
    doc: "PDF filename to store plot(s). Default: tombo_results.signal_clusters.pdf"
    default: "tombo_results.signal_clusters.pdf"
    inputBinding:
      position: 101
      prefix: "--pdf-filename"
  - id: r_data_filename
    type:
      - 'null'
      - string
    doc: "Filename to save R data structure. Default: Don't save"
    inputBinding:
      position: 101
      prefix: "--r-data-filename"
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
  - id: r_data_file
    type:
      - 'null'
      - File
    doc: "R data structure written with --r-data-filename"
    outputBinding:
      glob: "$(inputs.r_data_filename ? [inputs.r_data_filename] : [])"
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
