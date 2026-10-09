cwlVersion: v1.2
class: CommandLineTool
baseCommand: normalize-by-median.py
label: khmer_normalize-by-median.py
doc: |-
  Do digital normalization (remove mostly redundant sequences). Discard sequences based on whether or not their median k-mer abundance lies above a specified cutoff. Kept sequences are placed in <fileN>.keep.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sequence_filename
    type: File[]
    doc: Input FAST[AQ] sequence filename.
    inputBinding:
      position: 1
  - id: info
    type: ['null', boolean]
    doc: print citation information
    inputBinding:
      position: 103
      prefix: --info
  - id: ksize
    type: ['null', int]
    doc: k-mer size to use
    inputBinding:
      position: 103
      prefix: --ksize
  - id: unique_kmers
    type: ['null', float]
    doc: approximate number of unique kmers in the input set
    inputBinding:
      position: 103
      prefix: --unique-kmers
  - id: fp_rate
    type: ['null', float]
    doc: Override the automatic FP rate setting for the current script
    inputBinding:
      position: 103
      prefix: --fp-rate
  - id: max_memory_usage
    type: ['null', string]
    doc: maximum amount of memory to use for data structure (for example 1e8 or 1G)
    inputBinding:
      position: 103
      prefix: --max-memory-usage
  - id: small_count
    type: ['null', boolean]
    doc: Reduce memory usage by using a smaller counter for individual kmers.
    inputBinding:
      position: 103
      prefix: --small-count
  - id: quiet
    type: ['null', boolean]
    doc: quiet
    inputBinding:
      position: 103
      prefix: --quiet
  - id: cutoff
    type: ['null', int]
    doc: when the median k-mer coverage level is above this number the read is not kept.
    inputBinding:
      position: 103
      prefix: --cutoff
  - id: paired
    type: ['null', boolean]
    doc: require that all sequences be properly paired
    inputBinding:
      position: 103
      prefix: --paired
  - id: force_single
    type: ['null', boolean]
    doc: treat all sequences as single-ended/unpaired
    inputBinding:
      position: 103
      prefix: --force_single
  - id: unpaired_reads
    type: ['null', File]
    doc: include a file of unpaired reads to which -p/--paired does not apply.
    inputBinding:
      position: 103
      prefix: --unpaired-reads
  - id: savegraph
    type: ['null', string]
    doc: save the k-mer countgraph to disk after all reads are loaded.
    inputBinding:
      position: 103
      prefix: --savegraph
  - id: report
    type: ['null', string]
    doc: write progress report to report_filename
    inputBinding:
      position: 103
      prefix: --report
  - id: report_frequency
    type: ['null', int]
    doc: report progress every report_frequency reads
    inputBinding:
      position: 103
      prefix: --report-frequency
  - id: force
    type: ['null', boolean]
    doc: continue past file reading errors
    inputBinding:
      position: 103
      prefix: --force
  - id: output
    type: ['null', string]
    doc: only output a single file with the specified filename; use a single dash - to specify that output should go to STDOUT
    inputBinding:
      position: 103
      prefix: --output
  - id: loadgraph
    type: ['null', File]
    doc: load a precomputed k-mer graph from disk
    inputBinding:
      position: 103
      prefix: --loadgraph
  - id: gzip
    type: ['null', boolean]
    doc: Compress output using gzip
    inputBinding:
      position: 103
      prefix: --gzip
  - id: bzip
    type: ['null', boolean]
    doc: Compress output using bzip2
    inputBinding:
      position: 103
      prefix: --bzip
outputs:
  - id: kept_sequences
    type: File[]
    doc: Kept sequences, one <input>.keep file per input file (when --output is not given)
    outputBinding:
      glob: "*.keep"
  - id: output_output
    type: ['null', File]
    doc: Single output file given with --output
    outputBinding:
      glob: "$(inputs.output)"
  - id: savegraph_output
    type: ['null', File]
    doc: k-mer countgraph saved with --savegraph
    outputBinding:
      glob: "$(inputs.savegraph)"
  - id: report_output
    type: ['null', File]
    doc: progress report written with --report
    outputBinding:
      glob: "$(inputs.report)"
  - id: stdout
    type: stdout
    doc: Normalized reads written to standard output (when --output - is used)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_normalize-by-median.py.out
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
