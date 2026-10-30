cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - calculate_coverage.py
label: wub_calculate_coverage.py
doc: 'Calculate total number of bases and genome coverage if genome size is given.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_fastx
    type: File
    doc: 'Input (default: stdin).'
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Input format (fastq).
    inputBinding:
      position: 102
      prefix: -f
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Genome size (None).
    inputBinding:
      position: 102
      prefix: -s
  - id: results_pickle
    type:
      - 'null'
      - string
    doc: Save pickled results in this file.
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: coverage_txt
    type: File
    doc: Total bases, genome size and coverage.
    outputBinding:
      glob: coverage.txt
  - id: pickle
    type:
      - 'null'
      - File
    doc: Pickled results.
    outputBinding:
      glob: $(inputs.results_pickle)
stdout: coverage.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
