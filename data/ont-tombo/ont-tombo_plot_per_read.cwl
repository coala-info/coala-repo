cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot
  - per_read
label: ont-tombo_plot_per_read
doc: "Plot per-read modified base probabilities.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: genome_locations
    type:
      type: array
      items: string
    doc: "Genomic locations at which to plot signal. Format locations as \"chrm:position[:strand] [chrm2:position2[:strand2] ...]\" (strand not applicable for all applications)"
    inputBinding:
      position: 101
      prefix: "--genome-locations"
  - id: per_read_statistics_filename
    type: File
    doc: "Binary file containing per-read statistics from statistical testing."
    inputBinding:
      position: 101
      prefix: "--per-read-statistics-filename"
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: "FASTA file used to re-squiggle. For faster sequence access."
    inputBinding:
      position: 101
      prefix: "--genome-fasta"
      valueFrom: "$(self.basename)"
  - id: fast5_basedirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "Directories containing fast5 files."
    inputBinding:
      position: 101
      prefix: "--fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: num_reads
    type:
      - 'null'
      - int
    doc: "Number of reads to plot. Default: 100"
    inputBinding:
      position: 101
      prefix: "--num-reads"
  - id: num_bases
    type:
      - 'null'
      - int
    doc: "Number of bases to plot/output. Default: 51"
    inputBinding:
      position: 101
      prefix: "--num-bases"
  - id: box_center
    type:
      - 'null'
      - boolean
    doc: "Plot a box around the central base."
    inputBinding:
      position: 101
      prefix: "--box-center"
  - id: pdf_filename
    type:
      - 'null'
      - string
    doc: "PDF filename to store plot(s). Default: tombo_results.per_read_stats.pdf"
    default: "tombo_results.per_read_stats.pdf"
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
