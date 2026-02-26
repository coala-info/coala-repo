cwlVersion: v1.2
class: CommandLineTool
baseCommand: window-acgt
label: tigr-glimmer_window-acgt
doc: Read multi-fasta-format file from standard input. Print the acgt-content of
  windows in each sequence.
inputs:
  - id: window_len
    type: int
    doc: The width of windows
    inputBinding:
      position: 1
  - id: window_skip
    type: int
    doc: The number of positions between windows to report
    inputBinding:
      position: 2
  - id: input_file
    type: File
    doc: Input file in multi-fasta format (reads from stdin)
    inputBinding:
      position: 3
  - id: percent
    type:
      - 'null'
      - boolean
    doc: Output percentages instead of counts
    inputBinding:
      position: 104
      prefix: --percent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_window-acgt.out
