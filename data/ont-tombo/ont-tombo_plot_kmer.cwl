cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot
  - kmer
label: ont-tombo_plot_kmer
doc: "Plot signal distributions acorss kmers.\n\nTool homepage: https://github.com/nanoporetech/tombo"
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
  - id: upstream_bases
    type:
      - 'null'
      - int
    doc: "Upstream bases in k-mer. Default: 1"
    inputBinding:
      position: 101
      prefix: "--upstream-bases"
  - id: downstream_bases
    type:
      - 'null'
      - int
    doc: "Downstream bases in k-mer. Default: 2"
    inputBinding:
      position: 101
      prefix: "--downstream-bases"
  - id: read_mean
    type:
      - 'null'
      - boolean
    doc: "Plot k-mer means across whole reads as opposed to individual k-mer event levels."
    inputBinding:
      position: 101
      prefix: "--read-mean"
  - id: num_kmer_threshold
    type:
      - 'null'
      - int
    doc: "Observations of each k-mer required to include a read in read level averages. Default: 1"
    inputBinding:
      position: 101
      prefix: "--num-kmer-threshold"
  - id: num_reads
    type:
      - 'null'
      - int
    doc: "Number of reads to plot. Default: 100"
    inputBinding:
      position: 101
      prefix: "--num-reads"
  - id: pdf_filename
    type:
      - 'null'
      - string
    doc: "PDF filename to store plot(s). Default: tombo_results.kmer_distribution.pdf"
    default: "tombo_results.kmer_distribution.pdf"
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
  - id: dont_plot
    type:
      - 'null'
      - boolean
    doc: "Don't plot result. Useful to produce only R data file."
    inputBinding:
      position: 101
      prefix: "--dont-plot"
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
    type:
      - 'null'
      - File
    doc: "PDF with the plots (not written with --dont-plot)"
    outputBinding:
      glob: "$(inputs.pdf_filename ? [inputs.pdf_filename] : [])"
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
      - entry: $(inputs.fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
