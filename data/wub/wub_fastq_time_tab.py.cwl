cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_time_tab.py
label: wub_fastq_time_tab.py
doc: "Produce a tab separated file with read start times, read and channel numbers sorted by start time.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: read_tsv
    type:
      - 'null'
      - string
    doc: "Tab separated file to save read time table (fastq_time_tab.tsv)."
    inputBinding:
      position: 1
      prefix: -t
  - id: fastq
    type: File
    doc: "Input fastq file."
    inputBinding:
      position: 100
outputs:
  - id: output_tsv
    type: File
    doc: "Read time table"
    outputBinding:
      glob: '${ return inputs.read_tsv ? inputs.read_tsv : "fastq_time_tab.tsv"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
