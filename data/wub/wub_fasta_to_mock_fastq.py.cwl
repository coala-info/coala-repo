cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasta_to_mock_fastq.py
label: wub_fasta_to_mock_fastq.py
doc: 'Convert fasta file to fastq with mock qualities.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_fasta
    type: File
    doc: 'Input fasta (default: stdin).'
    inputBinding:
      position: 1
  - id: output_fastq
    type:
      - 'null'
      - string
    doc: 'Output fastq (default: stdout).'
    default: fasta_to_mock_fastq.out.fastq
    inputBinding:
      position: 2
  - id: mock_quals
    type:
      - 'null'
      - int
    doc: Mock quality value (40).
    inputBinding:
      position: 103
      prefix: -q
outputs:
  - id: output_fastq_file
    type: File
    doc: Fastq with mock quality values.
    outputBinding:
      glob: $(inputs.output_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
