cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - krepp
  - dist
label: krepp_dist
doc: "Estimate distances of queries to genomes in an index.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: query
    type: File
    doc: "Query FASTA/FASTQ file path (gzip compatible)"
    inputBinding:
      position: 101
      prefix: --query
  - id: index_dir
    type: Directory
    doc: "Directory containing the reference index"
    inputBinding:
      position: 101
      prefix: --index-dir
  - id: hdist_th
    type:
      - 'null'
      - int
    doc: "Maximum Hamming distance for a k-mer to match [4]"
    inputBinding:
      position: 101
      prefix: --hdist-th
  - id: output_path_path
    type:
      - 'null'
      - string
    doc: "Write output to a file at this path [stdout]"
    inputBinding:
      position: 102
      prefix: --output-path
  - id: chisq
    type:
      - 'null'
      - float
    doc: "Chi-square value for statistical distinguishability test, default corresponds to alpha=90% [2.706]"
    inputBinding:
      position: 101
      prefix: --chisq
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: "Summarize results into a table of read counts; if a read is mapped/placed to n references/edges, each gets 1/n. Overrides --no-multi and --no-filter"
    inputBinding:
      position: 101
      prefix: --summarize
  - id: no_summarize
    type:
      - 'null'
      - boolean
    doc: "Do not summarize results into a table of read counts"
    inputBinding:
      position: 101
      prefix: --no-summarize
  - id: dist_max
    type:
      - 'null'
      - float
    doc: "Maximum distance to report for matching references, overrides --filter if given (1e-08 - 0.33) [0.25]"
    inputBinding:
      position: 101
      prefix: --dist-max
  - id: multi
    type:
      - 'null'
      - boolean
    doc: "Output all distances/placements satisfying the filters (not just the closest) [true]"
    inputBinding:
      position: 101
      prefix: --multi
  - id: no_multi
    type:
      - 'null'
      - boolean
    doc: "Output only the closest reference / largest clade"
    inputBinding:
      position: 101
      prefix: --no-multi
  - id: filter
    type:
      - 'null'
      - boolean
    doc: "Apply the significance filter"
    inputBinding:
      position: 101
      prefix: --filter
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: "Do not apply the significance filter"
    inputBinding:
      position: 101
      prefix: --no-filter
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use in OpenMP-based parallelism [1]"
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed for the LSH and other parts that require randomness [0]"
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increased verbosity and progress report"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: no_verbose
    type:
      - 'null'
      - boolean
    doc: "Disable increased verbosity and progress report"
    inputBinding:
      position: 101
      prefix: --no-verbose
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: "Output file (when --output-path is given)"
    outputBinding:
      glob: $(inputs.output_path_path)
  - id: stdout_out
    type: stdout
    doc: "Standard output (the result when --output-path is not given)"
stdout: krepp_dist.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
