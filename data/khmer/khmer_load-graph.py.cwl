cwlVersion: v1.2
class: CommandLineTool
baseCommand: load-graph.py
label: khmer_load-graph.py
doc: |-
  Load sequences into the compressible graph format plus optional tagset.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: output_nodegraph_filename
    type: string
    doc: output k-mer nodegraph filename.
    inputBinding:
      position: 1
  - id: input_sequence_filename
    type: File[]
    doc: input FAST[AQ] sequence filename
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
  - id: no_build_tagset
    type: ['null', boolean]
    doc: Do NOT construct tagset while loading sequences
    inputBinding:
      position: 103
      prefix: --no-build-tagset
  - id: force
    type: ['null', boolean]
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
outputs:
  - id: output_nodegraph
    type: File
    doc: k-mer nodegraph file
    outputBinding:
      glob: "$(inputs.output_nodegraph_filename)"
  - id: tagset
    type: ['null', File]
    doc: Tagset file (not written with --no-build-tagset)
    outputBinding:
      glob: "$(inputs.output_nodegraph_filename).tagset"
  - id: nodegraph_info
    type: ['null', File]
    doc: Run information written beside the nodegraph
    outputBinding:
      glob: "$(inputs.output_nodegraph_filename).info"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
