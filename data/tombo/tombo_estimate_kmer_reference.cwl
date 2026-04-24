cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - estimate_kmer_reference
label: tombo_estimate_kmer_reference
doc: "Estimate k-mer reference model from FAST5 files.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
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
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: coverage_threshold
    type:
      - 'null'
      - int
    doc: Maximum mean coverage per region when estimating k-mer model (limits 
      compute time for deep samples).
    inputBinding:
      position: 101
      prefix: --coverage-threshold
  - id: downstream_bases
    type:
      - 'null'
      - int
    doc: Downstream bases in k-mer.
    inputBinding:
      position: 101
      prefix: --downstream-bases
  - id: estimate_mean
    type:
      - 'null'
      - boolean
    doc: Use the mean instead of median for model level estimation. Note:This 
      can cause poor fits due to outliers
    inputBinding:
      position: 101
      prefix: --estimate-mean
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
  - id: kmer_specific_sd
    type:
      - 'null'
      - boolean
    doc: Estimate standard deviation for each k-mers individually.
    inputBinding:
      position: 101
      prefix: --kmer-specific-sd
  - id: minimum_kmer_observations
    type:
      - 'null'
      - int
    doc: Number of each k-mer observations required in order to produce a 
      reference (genomic locations for standard reference and per-read for 
      alternative reference).
    inputBinding:
      position: 101
      prefix: --minimum-kmer-observations
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
  - id: tombo_model_filename
    type: File
    doc: Tombo model for event-less resquiggle and significance testing. If no 
      model is provided the default DNA or RNA tombo model will be used.
    inputBinding:
      position: 101
      prefix: --tombo-model-filename
  - id: upstream_bases
    type:
      - 'null'
      - int
    doc: Upstream bases in k-mer.
    inputBinding:
      position: 101
      prefix: --upstream-bases
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
stdout: tombo_estimate_kmer_reference.out
