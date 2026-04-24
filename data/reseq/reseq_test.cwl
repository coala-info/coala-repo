cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reseq
  - test
label: reseq_test
doc: "Runs ReSeq in test mode\n\nTool homepage: https://github.com/schmeing/ReSeq/tree/devel"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used (0=auto)
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Sets the level of verbosity (4=everything, 0=nothing)
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
stdout: reseq_test.out
