cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - test_significance
label: tombo_test_significance
doc: "Test for significant differences in signal between two sets of FAST5 files or
  against a model to identify modified bases.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: alternate_bases
    type:
      - 'null'
      - type: array
        items: string
    doc: Default non-standard base model for testing (e.g., 5mC).
    inputBinding:
      position: 101
      prefix: --alternate-bases
  - id: alternate_model_filenames
    type:
      - 'null'
      - type: array
        items: File
    doc: Tombo models for alternative likelihood ratio significance testing.
    inputBinding:
      position: 101
      prefix: --alternate-model-filenames
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    inputBinding:
      position: 101
      prefix: --basecall-subgroups
  - id: control_fast5_basedirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Control set of directories containing fast5 files. These reads should 
      contain only standard nucleotides.
    inputBinding:
      position: 101
      prefix: --control-fast5-basedirs
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
  - id: fishers_method_context
    type:
      - 'null'
      - int
    doc: Number of context bases up and downstream over which to compute 
      Fisher's method combined p-values.
    inputBinding:
      position: 101
      prefix: --fishers-method-context
  - id: minimum_test_reads
    type:
      - 'null'
      - int
    doc: Number of reads required at a position to perform significance testing 
      or contribute to model estimation.
    inputBinding:
      position: 101
      prefix: --minimum-test-reads
  - id: multiprocess_region_size
    type:
      - 'null'
      - int
    doc: Size of regions over which to multiprocesses statistic computation. For
      very deep samples a smaller value is recommmended in order to control 
      memory consumption.
    inputBinding:
      position: 101
      prefix: --multiprocess-region-size
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes.
    inputBinding:
      position: 101
      prefix: --processes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: single_read_threshold
    type:
      - 'null'
      - string
    doc: P-value or log likelihood ratio threshold when computing fraction of 
      significant reads at each genomic position.
    inputBinding:
      position: 101
      prefix: --single-read-threshold
  - id: tombo_model_filename
    type:
      - 'null'
      - File
    doc: Tombo model for event-less resquiggle and significance testing. If no 
      model is provided the default DNA or RNA tombo model will be used.
    inputBinding:
      position: 101
      prefix: --tombo-model-filename
outputs:
  - id: statistics_file_basename
    type: File
    doc: File base name to save base by base statistics from testing. Filenames 
      will be [--statistics-file-basename].[--alternate-bases]?.tombo.stats
    outputBinding:
      glob: $(inputs.statistics_file_basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
