cwlVersion: v1.2
class: CommandLineTool
baseCommand: abundance-dist-single.py
label: khmer_abundance-dist-single.py
doc: |-
  Calculate the abundance distribution of k-mers from a single sequence file.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sequence_filename
    type: File
    doc: The name of the input FAST[AQ] sequence file.
    inputBinding:
      position: 1
  - id: output_histogram_filename
    type: string
    doc: "The name of the output histogram file. The columns are: (1) k-mer abundance, (2) k-mer count, (3) cumulative count, (4) fraction of total distinct k-mers."
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
  - id: no_zero
    type: ['null', boolean]
    doc: Do not output zero-count bins
    inputBinding:
      position: 103
      prefix: --no-zero
  - id: no_bigcount
    type: ['null', boolean]
    doc: Do not count k-mers past 255
    inputBinding:
      position: 103
      prefix: --no-bigcount
  - id: squash
    type: ['null', boolean]
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --squash
  - id: savegraph
    type: ['null', string]
    doc: Save the k-mer countgraph to the specified filename.
    inputBinding:
      position: 103
      prefix: --savegraph
  - id: force
    type: ['null', boolean]
    doc: Override sanity checks
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
  - id: output_histogram
    type: File
    doc: k-mer abundance histogram
    outputBinding:
      glob: "$(inputs.output_histogram_filename)"
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
