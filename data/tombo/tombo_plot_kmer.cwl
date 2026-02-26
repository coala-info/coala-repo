cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot_kmer
label: tombo_plot_kmer
doc: "Plot k-mer distributions from FAST5 data using Tombo.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
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
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    default: RawGenomeCorrected_000
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: dont_plot
    type:
      - 'null'
      - boolean
    doc: Don't plot result. Useful to produce only R data file.
    inputBinding:
      position: 101
      prefix: --dont-plot
  - id: downstream_bases
    type:
      - 'null'
      - int
    doc: Downstream bases in k-mer.
    default: 2
    inputBinding:
      position: 101
      prefix: --downstream-bases
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
  - id: num_kmer_threshold
    type:
      - 'null'
      - int
    doc: Observations of each k-mer required to include a read in read level 
      averages.
    default: 1
    inputBinding:
      position: 101
      prefix: --num-kmer-threshold
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to plot.
    default: 100
    inputBinding:
      position: 101
      prefix: --num-reads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read_mean
    type:
      - 'null'
      - boolean
    doc: Plot k-mer means across whole reads as opposed to individual k-mer 
      event levels.
    inputBinding:
      position: 101
      prefix: --read-mean
  - id: upstream_bases
    type:
      - 'null'
      - int
    doc: Upstream bases in k-mer.
    default: 1
    inputBinding:
      position: 101
      prefix: --upstream-bases
outputs:
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    outputBinding:
      glob: $(inputs.pdf_filename)
  - id: r_data_filename
    type:
      - 'null'
      - File
    doc: Filename to save R data structure.
    outputBinding:
      glob: $(inputs.r_data_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
