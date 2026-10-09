cwlVersion: v1.2
class: CommandLineTool
baseCommand: count-median.py
label: khmer_count-median.py
doc: |-
  Count k-mers summary stats for sequences. Count the median/avg k-mer abundance for each sequence in the input file, based on the k-mer counts in the given k-mer countgraph. The output file contains sequence id, median, average, stddev, and seq length, in comma-separated value (CSV) format.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_count_graph_filename
    type: File
    doc: input k-mer countgraph filename
    inputBinding:
      position: 1
  - id: input_sequence_filename
    type: File
    doc: input FAST[AQ] sequence filename
    inputBinding:
      position: 2
  - id: output_summary_filename
    type: string
    doc: output summary filename
    inputBinding:
      position: 3
  - id: info
    type: ['null', boolean]
    doc: print citation information
    inputBinding:
      position: 103
      prefix: --info
  - id: force
    type: ['null', boolean]
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
outputs:
  - id: output_summary
    type: File
    doc: CSV summary of median, average and standard deviation of k-mer abundance per sequence
    outputBinding:
      glob: "$(inputs.output_summary_filename)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
