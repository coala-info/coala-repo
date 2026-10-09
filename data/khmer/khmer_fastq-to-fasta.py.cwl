cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-to-fasta.py
label: khmer_fastq-to-fasta.py
doc: Converts FASTQ format (.fq) files to FASTA format (.fa).
inputs:
  - id: input_sequence
    type: File
    doc: The name of the input FASTQ sequence file.
    inputBinding:
      position: 1
  - id: info
    type:
      - 'null'
      - boolean
    doc: print citation information
    inputBinding:
      position: 102
      prefix: --info
  - id: output
    type:
      - 'null'
      - string
    doc: The name of the output FASTA sequence file.
    inputBinding:
      position: 102
      prefix: --output
  - id: n_keep
    type:
      - 'null'
      - boolean
    doc: Option to keep reads containing 'N's in input_sequence file. Default is
      to drop reads
    inputBinding:
      position: 102
      prefix: --n_keep
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress output using gzip
    inputBinding:
      position: 102
      prefix: --gzip
  - id: bzip
    type:
      - 'null'
      - boolean
    doc: Compress output using bzip2
    inputBinding:
      position: 102
      prefix: --bzip
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: The name of the output FASTA sequence file.
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: FASTA written to standard output (when --output is not given)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_fastq-to-fasta.py.out
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
