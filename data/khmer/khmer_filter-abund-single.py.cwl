cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter-abund-single.py
label: khmer_filter-abund-single.py
doc: |-
  Trims sequences at a minimum k-mer abundance (in memory version). Trimmed sequences are placed in ${input_sequence_filename}.abundfilt.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sequence_filename
    type: File
    doc: FAST[AQ] sequence file to trim
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
  - id: threads
    type: ['null', int]
    doc: Number of simultaneous threads to execute
    inputBinding:
      position: 103
      prefix: --threads
  - id: cutoff
    type: ['null', int]
    doc: Trim at k-mers below this abundance.
    inputBinding:
      position: 103
      prefix: --cutoff
  - id: variable_coverage
    type: ['null', boolean]
    doc: Only trim low-abundance k-mers from sequences that have high coverage.
    inputBinding:
      position: 103
      prefix: --variable-coverage
  - id: normalize_to
    type: ['null', int]
    doc: Base the variable-coverage cutoff on this median k-mer abundance.
    inputBinding:
      position: 103
      prefix: --normalize-to
  - id: savegraph
    type: ['null', string]
    doc: If present, the name of the file to save the k-mer countgraph to
    inputBinding:
      position: 103
      prefix: --savegraph
  - id: outfile
    type: ['null', string]
    doc: Override default output filename and output trimmed sequences into a file with the given filename.
    inputBinding:
      position: 103
      prefix: --outfile
  - id: force
    type: ['null', boolean]
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
  - id: quiet
    type: ['null', boolean]
    doc: quiet
    inputBinding:
      position: 103
      prefix: --quiet
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
  - id: trimmed_sequences
    type: File[]
    doc: "Trimmed sequences (${input_sequence_filename}.abundfilt, or the --outfile name)"
    outputBinding:
      glob: "${ return inputs.outfile ? [inputs.outfile] : ['*.abundfilt']; }"
  - id: savegraph_output
    type: ['null', File]
    doc: k-mer countgraph saved with --savegraph
    outputBinding:
      glob: "$(inputs.savegraph)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
