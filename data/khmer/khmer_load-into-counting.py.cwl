cwlVersion: v1.2
class: CommandLineTool
baseCommand: load-into-counting.py
label: khmer_load-into-counting.py
doc: |-
  Build a k-mer countgraph from the given sequences.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: output_countgraph_filename
    type: string
    doc: The name of the file to write the k-mer countgraph to.
    inputBinding:
      position: 1
  - id: input_sequence_filename
    type: File[]
    doc: The names of one or more FAST[AQ] input sequence files.
    inputBinding:
      position: 2
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
  - id: no_bigcount
    type: ['null', boolean]
    doc: The default behaviour is to count past 255 using bigcount. This flag turns bigcount off, limiting counts to 255.
    inputBinding:
      position: 103
      prefix: --no-bigcount
  - id: summary_info
    type: ['null', string]
    doc: What format should the machine readable run summary be in? (json or tsv, disabled by default)
    inputBinding:
      position: 103
      prefix: --summary-info
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
outputs:
  - id: output_countgraph
    type: File
    doc: The k-mer countgraph file
    outputBinding:
      glob: "$(inputs.output_countgraph_filename)"
  - id: countgraph_info
    type: ['null', File]
    doc: Run information written beside the countgraph
    outputBinding:
      glob: "$(inputs.output_countgraph_filename).info"
  - id: summary_output
    type: ['null', File]
    doc: Machine readable run summary written with --summary-info
    outputBinding:
      glob: "$(inputs.output_countgraph_filename).info.*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
