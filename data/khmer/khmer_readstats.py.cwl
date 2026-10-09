cwlVersion: v1.2
class: CommandLineTool
baseCommand: readstats.py
label: khmer_readstats.py
doc: |-
  Display summary statistics for one or more FASTA/FASTQ files. Reports number of bases, number of sequences, and average sequence length for each file, and aggregate statistics at the end.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: filenames
    type: File[]
    doc: Input FASTA/FASTQ files
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
    doc: output file for statistics; defaults to stdout.
    inputBinding:
      position: 103
      prefix: --output
  - id: csv
    type: ['null', boolean]
    doc: Use the CSV format for the statistics, including column headers.
    inputBinding:
      position: 103
      prefix: --csv
outputs:
  - id: output_output
    type: ['null', File]
    doc: Statistics written to the --output file
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: Statistics written to standard output (when --output is not given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_readstats.py.out
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
