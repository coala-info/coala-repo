cwlVersion: v1.2
class: CommandLineTool
baseCommand: sake
label: bart_sake
doc: "Use SAKE algorithm to recover a full k-space from undersampled data using low-rank
  matrix completion.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: File
    doc: Input k-space data
    inputBinding:
      position: 1
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of iterations
    inputBinding:
      position: 102
      prefix: -i
  - id: signal_subspace_size
    type:
      - 'null'
      - float
    doc: rel. size of the signal subspace
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output
    type: File
    doc: Output file for the recovered k-space
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
