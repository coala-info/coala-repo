cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrge
label: lrge
doc: "Genome size estimation from long read overlaps\n\nTool homepage: https://github.com/mbhall88/lrge"
inputs:
  - id: input
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: filter_contained
    type:
      - 'null'
      - boolean
    doc: Exclude overlaps for internal matches
    inputBinding:
      position: 102
      prefix: --filter-contained
  - id: float_my_boat
    type:
      - 'null'
      - boolean
    doc: I neeeeeed that precision! Output the estimate as a floating point 
      number
    inputBinding:
      position: 102
      prefix: --float-my-boat
  - id: include_infinite_estimates
    type:
      - 'null'
      - boolean
    doc: Take the estimate as the median of all estimates, *including infinite 
      estimates*
    inputBinding:
      position: 102
      prefix: --inf
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Don't clean up temporary files
    inputBinding:
      position: 102
      prefix: --keep-temp
  - id: max_overhang_ratio
    type:
      - 'null'
      - float
    doc: Maximum overhang size to alignment length ratio for internal overlap 
      filtering
    inputBinding:
      position: 102
      prefix: --max-overhang-ratio
  - id: num
    type:
      - 'null'
      - int
    doc: Number of reads to use (for all-vs-all strategy)
    inputBinding:
      position: 102
      prefix: --num
  - id: platform
    type:
      - 'null'
      - string
    doc: Sequencing platform of the reads
    inputBinding:
      position: 102
      prefix: --platform
  - id: q1
    type:
      - 'null'
      - float
    doc: The lower quantile to use for the estimate
    inputBinding:
      position: 102
      prefix: --q1
  - id: q3
    type:
      - 'null'
      - float
    doc: The upper quantile to use for the estimate
    inputBinding:
      position: 102
      prefix: --q3
  - id: query
    type:
      - 'null'
      - int
    doc: Query number of reads to use (for two-set strategy; default)
    inputBinding:
      position: 102
      prefix: --query
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: '`-q` only show errors and warnings. `-qq` only show errors. `-qqq` shows
      nothing'
    inputBinding:
      position: 102
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed to use - making the estimate repeatable
    inputBinding:
      position: 102
      prefix: --seed
  - id: target
    type:
      - 'null'
      - int
    doc: Target number of reads to use (for two-set strategy; default)
    inputBinding:
      position: 102
      prefix: --target
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for storing intermediate files
    inputBinding:
      position: 102
      prefix: --temp
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_min_ref
    type:
      - 'null'
      - boolean
    doc: Use the smaller Q/T dataset as minimap2 reference (for two-set 
      strategy)
    inputBinding:
      position: 102
      prefix: --use-min-ref
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: '`-v` show debug output. `-vv` show trace output'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file for the estimate
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrge:0.2.1--h9f13da3_0
