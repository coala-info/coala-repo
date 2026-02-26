cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw plot_kmer
label: nanoraw_plot_kmer
doc: "Plot k-mer distribution from FAST5 files.\n\nTool homepage: https://github.com/marcus1487/nanoraw"
inputs:
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 1
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup (under Analyses/[corrected-group]) where individual 
      template and/or complement reads are stored.
    default:
      - BaseCalled_template
    inputBinding:
      position: 102
      prefix: --basecall-subgroups
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group to access/plot created by genome_resquiggle script.
    default: RawGenomeCorrected_000
    inputBinding:
      position: 102
      prefix: --corrected-group
  - id: dont_plot
    type:
      - 'null'
      - boolean
    doc: Don't actually plot the result. Useful when you only want the R data 
      file.
    inputBinding:
      position: 102
      prefix: --dont-plot
  - id: downstream_bases
    type:
      - 'null'
      - int
    doc: Downstream bases in k-mer. Should be one of {0,1,2,3}.
    default: 2
    inputBinding:
      position: 102
      prefix: --downstream-bases
  - id: num_kmer_threshold
    type:
      - 'null'
      - int
    doc: Number of each kmer required to include a read in read level averages.
    default: 4
    inputBinding:
      position: 102
      prefix: --num-kmer-threshold
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to plot (one region per read).
    default: 500
    inputBinding:
      position: 102
      prefix: --num-reads
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    default: Nanopore_kmer_distribution.pdf
    inputBinding:
      position: 102
      prefix: --pdf-filename
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: r_data_filename
    type:
      - 'null'
      - string
    doc: "Filename to save R data structure. Defualt: Don't save"
    inputBinding:
      position: 102
      prefix: --r-data-filename
  - id: read_mean
    type:
      - 'null'
      - boolean
    doc: Plot kmer event means across reads as opposed to each event.
    inputBinding:
      position: 102
      prefix: --read-mean
  - id: two_d
    type:
      - 'null'
      - boolean
    doc: Input contains 2D reads. Equivalent to `--basecall-subgroups 
      BaseCalled_template BaseCalled_complement`
    inputBinding:
      position: 102
      prefix: --2d
  - id: upstream_bases
    type:
      - 'null'
      - int
    doc: Upstream bases in k-mer. Should be one of {0,1,2,3}.
    default: 1
    inputBinding:
      position: 102
      prefix: --upstream-bases
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw_plot_kmer.out
