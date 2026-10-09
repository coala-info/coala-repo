cwlVersion: v1.2
class: CommandLineTool
baseCommand: do-partition.py
label: khmer_do-partition.py
doc: |-
  Load, partition, and annotate FAST[AQ] sequences. This script combines load-graph.py, partition-graph.py, merge-partitions.py and annotate-partitions.py into one script. The input files are annotated with partition information in <input file>.part files.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: graphbase
    type: string
    doc: base name for output files
    inputBinding:
      position: 1
  - id: input_sequence_filename
    type: File[]
    doc: input FAST[AQ] sequence filenames
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
  - id: threads
    type: ['null', int]
    doc: Number of simultaneous threads to execute
    inputBinding:
      position: 103
      prefix: --threads
  - id: subset_size
    type: ['null', float]
    doc: Set subset size (usually 1e5-1e6 is good)
    inputBinding:
      position: 103
      prefix: --subset-size
  - id: no_big_traverse
    type: ['null', boolean]
    doc: Truncate graph joins at big traversals
    inputBinding:
      position: 103
      prefix: --no-big-traverse
  - id: keep_subsets
    type: ['null', boolean]
    doc: Keep individual subsets
    inputBinding:
      position: 103
      prefix: --keep-subsets
  - id: force
    type: ['null', boolean]
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
outputs:
  - id: partitioned_sequences
    type: File[]
    doc: Input sequences annotated with partition numbers (<input file>.part)
    outputBinding:
      glob: "*.part"
  - id: graph_files
    type: File[]
    doc: Other files written with the graph base name (nodegraph, tagset, merged partition map, kept subsets)
    outputBinding:
      glob: "$(inputs.graphbase)*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
