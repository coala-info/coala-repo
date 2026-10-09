cwlVersion: v1.2
class: CommandLineTool
baseCommand: abundance-dist.py
label: khmer_abundance-dist.py
doc: |-
  Calculate abundance distribution of the k-mers in the sequence file using a pre-made k-mer countgraph.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_count_graph_filename
    type: File
    doc: The name of the input k-mer countgraph file.
    inputBinding:
      position: 1
  - id: input_sequence_filename
    type: File
    doc: The name of the input FAST[AQ] sequence file.
    inputBinding:
      position: 2
  - id: output_histogram_filename
    type: string
    doc: "The name of the output histogram file. The columns are: (1) k-mer abundance, (2) k-mer count, (3) cumulative count, (4) fraction of total distinct k-mers."
    inputBinding:
      position: 3
  - id: info
    type: ['null', boolean]
    doc: print citation information
    inputBinding:
      position: 103
      prefix: --info
  - id: no_zero
    type: ['null', boolean]
    doc: Do not output zero-count bins
    inputBinding:
      position: 103
      prefix: --no-zero
  - id: squash
    type: ['null', boolean]
    doc: Overwrite existing output_histogram_filename
    inputBinding:
      position: 103
      prefix: --squash
  - id: no_bigcount
    type: ['null', boolean]
    doc: Do not count k-mers past 255
    inputBinding:
      position: 103
      prefix: --no-bigcount
  - id: force
    type: ['null', boolean]
    doc: Continue even if specified input files do not exist or are empty.
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
