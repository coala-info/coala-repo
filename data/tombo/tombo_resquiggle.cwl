cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - resquiggle
label: tombo_resquiggle
doc: "Re-annotate raw nanopore signal to a genomic reference (resquiggle).\n\nTool
  homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5_basedir
    type: Directory
    doc: Directory containing fast5 files. All files ending in "fast5" found 
      recursively within this base directory will be processed.
    inputBinding:
      position: 1
  - id: genome_fasta
    type: File
    doc: Path to fasta file for mapping.
    inputBinding:
      position: 2
  - id: align_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use for parsing and aligning original basecalls.
    default: 1
    inputBinding:
      position: 103
      prefix: --align-processes
  - id: align_threads_per_process
    type:
      - 'null'
      - int
    doc: Number of threads to use for aligner system call.
    inputBinding:
      position: 103
      prefix: --align-threads-per-process
  - id: alignment_batch_size
    type:
      - 'null'
      - int
    doc: Number of reads included in each alignment call.
    default: 1000
    inputBinding:
      position: 103
      prefix: --alignment-batch-size
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: Bandwidth of events for dynamic sequence to event mapping.
    default: 501
    inputBinding:
      position: 103
      prefix: --bandwidth
  - id: basecall_group
    type:
      - 'null'
      - string
    doc: FAST5 group obtain original basecalls (under Analyses group).
    default: Basecall_1D_000
    inputBinding:
      position: 103
      prefix: --basecall-group
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    default: BaseCalled_template
    inputBinding:
      position: 103
      prefix: --basecall-subgroups
  - id: bwa_mem_executable
    type:
      - 'null'
      - File
    doc: Path to bwa-mem executable.
    inputBinding:
      position: 103
      prefix: --bwa-mem-executable
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    default: RawGenomeCorrected_000
    inputBinding:
      position: 103
      prefix: --corrected-group
  - id: graphmap_executable
    type:
      - 'null'
      - File
    doc: Path to graphmap executable.
    inputBinding:
      position: 103
      prefix: --graphmap-executable
  - id: include_event_stdev
    type:
      - 'null'
      - boolean
    doc: Include corrected event standard deviation in output FAST5 data.
    inputBinding:
      position: 103
      prefix: --include-event-stdev
  - id: match_expected_value
    type:
      - 'null'
      - float
    doc: Expected value when a matched event to genomic sequence is encountered.
    default: 0.5
    inputBinding:
      position: 103
      prefix: --match-expected-value
  - id: minimap2_executable
    type:
      - 'null'
      - File
    doc: Path to minimap2 executable.
    inputBinding:
      position: 103
      prefix: --minimap2-executable
  - id: minimap2_index
    type:
      - 'null'
      - File
    doc: Path to minimap2 index (with map-ont preset) file corresponding to the 
      [genome_fasta] provided.
    inputBinding:
      position: 103
      prefix: --minimap2-index
  - id: obs_per_base_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter reads baseed on observations per base percentile thresholds. 
      Format thresholds as "percentile:thresh [pctl2:thresh2 ...]". For example 
      to filter reads with 99th pctl > 200 obs/base or max > 5k obs/base use 
      "99:200 100:5000".
    inputBinding:
      position: 103
      prefix: --obs-per-base-filter
  - id: outlier_threshold
    type:
      - 'null'
      - float
    doc: Windosrize the signal at this number of scale values. Negative value 
      disables outlier clipping.
    default: 5.0
    inputBinding:
      position: 103
      prefix: --outlier-threshold
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous corrected group in FAST5 files.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes.
    default: 2
    inputBinding:
      position: 103
      prefix: --processes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: resquiggle_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use for resquiggle algorithm.
    inputBinding:
      position: 103
      prefix: --resquiggle-processes
  - id: skip_index
    type:
      - 'null'
      - boolean
    doc: Skip creation of tombo index.
    inputBinding:
      position: 103
      prefix: --skip-index
  - id: skip_penalty
    type:
      - 'null'
      - float
    doc: Penalty applied to skipped genomic bases in event to sequence 
      assignment.
    default: 1.0
    inputBinding:
      position: 103
      prefix: --skip-penalty
  - id: tombo_model_filename
    type:
      - 'null'
      - File
    doc: Tombo model for event-less resquiggle and significance testing. If no 
      model is provided the default DNA or RNA tombo model will be used.
    inputBinding:
      position: 103
      prefix: --tombo-model-filename
outputs:
  - id: failed_reads_filename
    type:
      - 'null'
      - File
    doc: Output failed read filenames with assoicated error.
    outputBinding:
      glob: $(inputs.failed_reads_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
