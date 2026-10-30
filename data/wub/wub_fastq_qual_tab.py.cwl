cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq_qual_tab.py
label: wub_fastq_qual_tab.py
doc: 'Generate a table of read names and mean quality values.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_fastq
    type: File
    doc: 'Input fastq (default: stdin).'
    inputBinding:
      position: 1
  - id: tsv
    type: string
    doc: Output tab separated file.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: quality_tsv
    type: File
    doc: Table of read names and mean quality values.
    outputBinding:
      glob: $(inputs.tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
