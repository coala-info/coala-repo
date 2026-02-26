cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw cluster_most_significant
label: nanoraw_cluster_most_significant
doc: "Compares two sets of fast5 files to find significant differences in signal levels.\n\
  \nTool homepage: https://github.com/marcus1487/nanoraw"
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
    default:
      - BaseCalled_template
    inputBinding:
      position: 103
      prefix: --basecall-subgroups
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group to access/plot created by genome_resquiggle script.
    default: RawGenomeCorrected_000
    inputBinding:
      position: 103
      prefix: --corrected-group
  - id: fishers_method_offset
    type:
      - 'null'
      - int
    doc: Offset up and downstream over which to compute combined p-values using 
      Fisher's method.
    default: 2
    inputBinding:
      position: 103
      prefix: --fishers-method-offset
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: FASTA file used to map reads with "genome_resquiggle" command.
    inputBinding:
      position: 103
      prefix: --genome-fasta
  - id: minimum_test_reads
    type:
      - 'null'
      - int
    doc: Number of reads required from both samples to test for significant 
      difference in signal level.
    default: 5
    inputBinding:
      position: 103
      prefix: --minimum-test-reads
  - id: num_bases
    type:
      - 'null'
      - int
    doc: Number of bases to plot from region.
    default: 5
    inputBinding:
      position: 103
      prefix: --num-bases
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    default: 10
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
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    default: Nanopore_most_significant_clustering.pdf
    inputBinding:
      position: 103
      prefix: --pdf-filename
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes.
    default: 1
    inputBinding:
      position: 103
      prefix: --processes
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
  - id: r_data_filename
    type:
      - 'null'
      - File
    doc: "Filename to save R data structure. Defualt: Don't save"
    inputBinding:
      position: 103
      prefix: --r-data-filename
  - id: slide_span
    type:
      - 'null'
      - int
    doc: 'Number of bases to slide up and down when computing distances for signal
      cluster plotting. Default: Exact position'
    inputBinding:
      position: 103
      prefix: --slide-span
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
    default: mw_utest
    inputBinding:
      position: 103
      prefix: --test-type
  - id: two_d
    type:
      - 'null'
      - boolean
    doc: Input contains 2D reads. Equivalent to --basecall-subgroups 
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
stdout: nanoraw_cluster_most_significant.out
