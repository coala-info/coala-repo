cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw_write_wiggles
label: nanoraw_write_wiggles
doc: "Write wiggle files for Nanopore data.\n\nTool homepage: https://github.com/marcus1487/nanoraw"
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
    default: "['BaseCalled_template']"
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
  - id: fishers_method_offset
    type:
      - 'null'
      - int
    doc: Offset up and downstream over which to compute combined p-values using 
      Fisher's method.
    default: 2
    inputBinding:
      position: 102
      prefix: --fishers-method-offset
  - id: input_2d
    type:
      - 'null'
      - boolean
    doc: Input contains 2D reads. Equivalent to `--basecall- subgroups 
      BaseCalled_template BaseCalled_complement`
    inputBinding:
      position: 102
      prefix: --2d
  - id: minimum_test_reads
    type:
      - 'null'
      - int
    doc: Number of reads required from both samples to test for significant 
      difference in signal level.
    default: 5
    inputBinding:
      position: 102
      prefix: --minimum-test-reads
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: statistics_filename
    type:
      - 'null'
      - File
    doc: Filename to save/load base by base signal difference statistics. If 
      file exists it will try to be loaded, if it does not exist it will be 
      created to save statistics.
    inputBinding:
      position: 102
      prefix: --statistics-filename
  - id: test_type
    type:
      - 'null'
      - string
    doc: 'Type of significance test to apply. Choices are: mw_utest (default; mann-whitney
      u-test), ttest.'
    inputBinding:
      position: 102
      prefix: --test-type
  - id: wiggle_basename
    type:
      - 'null'
      - string
    doc: Basename for output files. Two files (plus and minus strand) will be 
      produced for each --wiggle-types supplied. Filenames will be formatted as 
      "[wiggle- basename].[wiggle-type].[group1/2]?. [plus/minus].wig".
    default: Nanopore_data
    inputBinding:
      position: 102
      prefix: --wiggle-basename
  - id: wiggle_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Data types for which wiggles should be created (select one or more data
      types). Choices: coverage, signal, signal_sd, length, pvals, qvals (both negative
      log10), difference. Note that signal, signal_sd and length (number of observations
      per base) are means over all reads at each base.'
    default: coverage, pvals
    inputBinding:
      position: 102
      prefix: --wiggle-types
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw_write_wiggles.out
