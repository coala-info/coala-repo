cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract-long-sequences.py
label: khmer_extract-long-sequences.py
doc: |-
  Extract FASTQ or FASTA sequences longer than specified length (default: 200 bp).

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_filenames
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
  - id: output
    type: ['null', string]
    doc: The name of the output sequence file.
    inputBinding:
      position: 103
      prefix: --output
  - id: length
    type: ['null', int]
    doc: The minimum length of the sequence file.
    inputBinding:
      position: 103
      prefix: --length
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
  - id: output_output
    type: ['null', File]
    doc: Sequences longer than --length, written to the --output file
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: Long sequences written to standard output (when --output is not given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_extract-long-sequences.py.out
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
