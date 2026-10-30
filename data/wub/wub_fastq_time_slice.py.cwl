cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq_time_slice.py
label: wub_fastq_time_slice.py
doc: 'Filter a fastq file by starting time.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_fastq
    type: File
    doc: 'Input fastq (default: stdin).'
    inputBinding:
      position: 1
  - id: output_fastq
    type:
      - 'null'
      - string
    doc: 'Output fastq (default: stdout).'
    default: fastq_time_slice.out.fastq
    inputBinding:
      position: 2
  - id: time_tsv
    type: File
    doc: Tab separeted file produced by fastq_time_tab.py.
    inputBinding:
      position: 103
      prefix: -t
  - id: start_perc
    type:
      - 'null'
      - float
    doc: Start of slice as percent of total time.
    inputBinding:
      position: 103
      prefix: -s
  - id: end_perc
    type:
      - 'null'
      - float
    doc: End of slice as percent of total time.
    inputBinding:
      position: 103
      prefix: -e
outputs:
  - id: output_fastq_file
    type: File
    doc: Fastq reads started within the time slice.
    outputBinding:
      glob: $(inputs.output_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
