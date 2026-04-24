cwlVersion: v1.2
class: CommandLineTool
baseCommand: krepp dist
label: krepp_dist
doc: "Estimate distances of queries to genomes in an index.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: chisq
    type:
      - 'null'
      - float
    doc: Chi-square value for statistical distinguishability test, default 
      correspons to alpha=90%.
    inputBinding:
      position: 101
      prefix: --chisq
  - id: dist_max
    type:
      - 'null'
      - float
    doc: Maximum distance to report for matching references, overrides --filter 
      if given.
    inputBinding:
      position: 101
      prefix: --dist-max
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Filter a hit if its distance is too high compared to the best hit 
      (based on the statistical significance).
    inputBinding:
      position: 101
      prefix: --filter
  - id: hdist_th
    type:
      - 'null'
      - int
    doc: Maximum Hamming distance for a k-mer to match.
    inputBinding:
      position: 101
      prefix: --hdist-th
  - id: index_dir
    type: Directory
    doc: Directory <path> containing the reference index.
    inputBinding:
      position: 101
      prefix: --index-dir
  - id: multi
    type:
      - 'null'
      - boolean
    doc: Output all distances satisfying the filters (not just the closest 
      reference).
    inputBinding:
      position: 101
      prefix: --multi
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Filter a hit if its distance is too high compared to the best hit 
      (based on the statistical significance).
    inputBinding:
      position: 101
      prefix: --no-filter
  - id: no_multi
    type:
      - 'null'
      - boolean
    doc: Output all distances satisfying the filters (not just the closest 
      reference).
    inputBinding:
      position: 101
      prefix: --no-multi
  - id: no_summarize
    type:
      - 'null'
      - boolean
    doc: Summarize results into a table of read counts. If a read is 
      mapped/placed to n references/edges, each gets 1/n. Overrides --no-multi 
      and --no-filter.
    inputBinding:
      position: 101
      prefix: --no-summarize
  - id: query
    type: File
    doc: Query FASTA/FASTQ file <path> (or URL) (gzip compatible).
    inputBinding:
      position: 101
      prefix: --query
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: Summarize results into a table of read counts. If a read is 
      mapped/placed to n references/edges, each gets 1/n. Overrides --no-multi 
      and --no-filter.
    inputBinding:
      position: 101
      prefix: --summarize
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Write output to a file at <path>.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
