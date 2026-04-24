cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw plot_most_significant
label: nanoraw_plot_most_significant
doc: "Plot regions with significant differences in signal level between two sets of
  FAST5 files.\n\nTool homepage: https://github.com/marcus1487/nanoraw"
inputs:
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 1
  - id: fast5_basedirs2
    type:
      type: array
      items: Directory
    doc: Second set of directories containing fast5 files to compare.
    inputBinding:
      position: 2
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup (under Analyses/[corrected-group]) where individual 
      template and/or complement reads are stored.
      - BaseCalled_template
    inputBinding:
      position: 103
      prefix: --basecall-subgroups
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group to access/plot created by genome_resquiggle script.
    inputBinding:
      position: 103
      prefix: --corrected-group
  - id: fishers_method_offset
    type:
      - 'null'
      - int
    doc: Offset up and downstream over which to compute combined p-values using 
      Fisher's method.
    inputBinding:
      position: 103
      prefix: --fishers-method-offset
  - id: minimum_test_reads
    type:
      - 'null'
      - int
    doc: Number of reads required from both samples to test for significant 
      difference in signal level.
    inputBinding:
      position: 103
      prefix: --minimum-test-reads
  - id: num_bases
    type:
      - 'null'
      - int
    doc: Number of bases to plot from region.
    inputBinding:
      position: 103
      prefix: --num-bases
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    inputBinding:
      position: 103
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
      position: 103
      prefix: --obs-per-base-filter
  - id: overplot_threshold
    type:
      - 'null'
      - int
    doc: Number of reads to trigger alternative plot type instead of raw signal 
      due to overplotting.
    inputBinding:
      position: 103
      prefix: --overplot-threshold
  - id: overplot_type
    type:
      - 'null'
      - string
    doc: 'Plot type for regions with higher coverage. Choices: Downsample (default),
      Boxplot , Quantile, Violin'
    inputBinding:
      position: 103
      prefix: --overplot-type
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    inputBinding:
      position: 103
      prefix: --pdf-filename
  - id: q_value_threshold
    type:
      - 'null'
      - float
    doc: Choose the number of regions to select by the FDR corrected p-values. 
      Note that --num-regions will be ignored if this option is set.
    inputBinding:
      position: 103
      prefix: --q-value-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: sequences_filename
    type:
      - 'null'
      - File
    doc: 'Filename to store sequences for selected regions (e.g. for PWM search).
      Sequences will be stored in FASTA format. Default: None.'
    inputBinding:
      position: 103
      prefix: --sequences-filename
  - id: statistics_filename
    type:
      - 'null'
      - File
    doc: "Filename to save/load base by base signal difference statistics. If file
      exists it will try to be loaded, if it does not exist it will be created to
      save statistics. Default: Don't save/load."
    inputBinding:
      position: 103
      prefix: --statistics-filename
  - id: test_type
    type:
      - 'null'
      - string
    doc: 'Type of significance test to apply. Choices are: mw_utest (default; mann-whitney
      u-test), ttest.'
    inputBinding:
      position: 103
      prefix: --test-type
  - id: two_d
    type:
      - 'null'
      - boolean
    doc: Input contains 2D reads. Equivalent to --basecall- subgroups 
      BaseCalled_template BaseCalled_complement
    inputBinding:
      position: 103
      prefix: --2d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw_plot_most_significant.out
