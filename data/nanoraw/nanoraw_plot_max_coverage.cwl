cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw plot_max_coverage
label: nanoraw_plot_max_coverage
doc: "Plots the maximum coverage of Nanopore reads across genomic regions.\n\nTool
  homepage: https://github.com/marcus1487/nanoraw"
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
  - id: fast5_basedirs2
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Second set of directories containing fast5 files to compare.
    inputBinding:
      position: 102
      prefix: --fast5-basedirs2
  - id: input_2d
    type:
      - 'null'
      - boolean
    doc: Input contains 2D reads. Equivalent to `--basecall-subgroups 
      BaseCalled_template BaseCalled_complement`
    inputBinding:
      position: 102
      prefix: --2d
  - id: num_bases
    type:
      - 'null'
      - int
    doc: Number of bases to plot from region.
    default: 51
    inputBinding:
      position: 102
      prefix: --num-bases
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    default: 10
    inputBinding:
      position: 102
      prefix: --num-regions
  - id: obs_per_base_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter reads for plotting baseed on threshold of percentiles of the 
      number of observations assigned to a base (default no filter). Format 
      thresholds as "percentile:thresh [pctl2:thresh2 ...]". E.g. reads with 
      99th pctl <200 obs and max <5k obs would be "99:200 100:5000".
    inputBinding:
      position: 102
      prefix: --obs-per-base-filter
  - id: overplot_threshold
    type:
      - 'null'
      - int
    doc: Number of reads to trigger alternative plot type instead of raw signal 
      due to overplotting.
    default: 50
    inputBinding:
      position: 102
      prefix: --overplot-threshold
  - id: overplot_type
    type:
      - 'null'
      - string
    doc: 'Plot type for regions with higher coverage. Choices: Downsample (default),
      Boxplot , Quantile, Violin'
    default: Downsample
    inputBinding:
      position: 102
      prefix: --overplot-type
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    default: Nanopore_read_coverage.max_coverage.pdf
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw_plot_max_coverage.out
