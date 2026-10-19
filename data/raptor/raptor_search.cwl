cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - raptor
  - search
label: raptor_search
doc: "Queries a Raptor index; the hits of each query (bins that may contain it) are\
  \ written to the output file.\n\nTool homepage: https://github.com/seqan/raptor"
inputs:
  - id: index
    type: File
    doc: 'Provide a valid path to an index. Parts: Without suffix _0'
    inputBinding:
      position: 101
      prefix: --index
  - id: query
    type: File
    doc: Provide a path to the query file. The input file must exist and read permissions
      must be granted. Valid file extensions are [embl,fasta,fa,fna,ffn,faa,frn,fas,fastq,fq,genbank,gb,gbk,sam],
      possibly followed by [bz2,gz,bgzf].
    inputBinding:
      position: 101
      prefix: --query
  - id: output
    type: string
    doc: A valid path for the output file. Write permissions must be granted.
    inputBinding:
      position: 102
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use. Default: 1. Value must be a positive integer.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print time and memory usage.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: error
    type:
      - 'null'
      - int
    doc: 'The number of errors. Mutually exclusive with --threshold. Default: 0. Value
      must be a positive integer or 0.'
    inputBinding:
      position: 101
      prefix: --error
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Ratio of k-mers that need to be found for a hit to occur. Mutually exclusive
      with --error. Default: None. Value must be in range [0,1].'
    inputBinding:
      position: 101
      prefix: --threshold
  - id: query_length
    type:
      - 'null'
      - int
    doc: 'The query length. Only influences the threshold when using --error. Enables
      skipping of the query length computation for both --error and --threshold. Default:
      Median of sequence lengths in query file.'
    inputBinding:
      position: 101
      prefix: --query_length
  - id: tau
    type:
      - 'null'
      - float
    doc: 'The higher tau, the lower the threshold. Default: 0.9999. Value must be
      in range [0,1].'
    inputBinding:
      position: 101
      prefix: --tau
  - id: p_max
    type:
      - 'null'
      - float
    doc: 'The higher p_max, the lower the threshold. Default: 0.15. Value must be
      in range [0,1].'
    inputBinding:
      position: 101
      prefix: --p_max
  - id: cache_thresholds
    type:
      - 'null'
      - boolean
    doc: 'Stores the computed thresholds with an unique name next to the index. In
      the next search call using this option, the stored thresholds are re-used. Two
      files are stored: threshold_*.bin: Depends on query_length, window, kmer/shape,
      errors, and tau. correction_*.bin: Depends on query_length, window, kmer/shape,
      p_max, and fpr.'
    inputBinding:
      position: 101
      prefix: --cache-thresholds
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (time and memory usage)
  - id: hits
    type: File
    doc: Search result
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
stdout: raptor_search.out
