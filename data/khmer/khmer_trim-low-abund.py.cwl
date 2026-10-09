cwlVersion: v1.2
class: CommandLineTool
baseCommand: trim-low-abund.py
label: khmer_trim-low-abund.py
doc: |-
  Trim low-abundance k-mers using a streaming algorithm. The output is one file for each input file, <input file>.abundtrim, placed in the current directory. Reads may be in a different order than in the input; read pairs are kept together in broken-paired format.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_filenames
    type: File[]
    doc: Input FAST[AQ] sequence filenames
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
  - id: cutoff
    type: ['null', int]
    doc: remove k-mers below this abundance
    inputBinding:
      position: 103
      prefix: --cutoff
  - id: trim_at_coverage
    type: ['null', int]
    doc: trim reads when entire read above this coverage
    inputBinding:
      position: 103
      prefix: --trim-at-coverage
  - id: output
    type: ['null', string]
    doc: only output a single file with the specified filename; use a single dash - to specify that output should go to STDOUT
    inputBinding:
      position: 103
      prefix: --output
  - id: variable_coverage
    type: ['null', boolean]
    doc: Only trim low-abundance k-mers from sequences that have high coverage.
    inputBinding:
      position: 103
      prefix: --variable-coverage
  - id: loadgraph
    type: ['null', File]
    doc: load a precomputed k-mer graph from disk
    inputBinding:
      position: 103
      prefix: --loadgraph
  - id: savegraph
    type: ['null', string]
    doc: save the k-mer countgraph to disk after all reads are loaded.
    inputBinding:
      position: 103
      prefix: --savegraph
  - id: quiet
    type: ['null', boolean]
    doc: quiet
    inputBinding:
      position: 103
      prefix: --quiet
  - id: summary_info
    type: ['null', string]
    doc: What format should the machine readable run summary be in? (json or tsv, disabled by default)
    inputBinding:
      position: 103
      prefix: --summary-info
  - id: force
    type: ['null', boolean]
    doc: Continue past errors
    inputBinding:
      position: 103
      prefix: --force
  - id: ignore_pairs
    type: ['null', boolean]
    doc: treat all reads as if they were singletons
    inputBinding:
      position: 103
      prefix: --ignore-pairs
  - id: tempdir
    type: ['null', string]
    doc: Set location of temporary directory for second pass
    inputBinding:
      position: 103
      prefix: --tempdir
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
  - id: diginorm
    type: ['null', boolean]
    doc: Eliminate high-coverage reads altogether (digital normalization).
    inputBinding:
      position: 103
      prefix: --diginorm
  - id: diginorm_coverage
    type: ['null', int]
    doc: Coverage threshold for --diginorm
    inputBinding:
      position: 103
      prefix: --diginorm-coverage
  - id: single_pass
    type: ['null', boolean]
    doc: Do not do a second pass across the low coverage data
    inputBinding:
      position: 103
      prefix: --single-pass
outputs:
  - id: trimmed_sequences
    type: File[]
    doc: Trimmed sequences, one <input>.abundtrim file per input file (when --output is not given)
    outputBinding:
      glob: "*.abundtrim"
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
  - id: summary_output
    type: File[]
    doc: Machine readable run summary written with --summary-info
    outputBinding:
      glob: "*.info.*"
  - id: stdout
    type: stdout
    doc: Trimmed reads written to standard output (when --output - is used)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_trim-low-abund.py.out
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
