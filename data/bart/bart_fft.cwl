cwlVersion: v1.2
class: CommandLineTool
baseCommand: fft
label: bart_fft
doc: "Performs a fast Fourier transform (FFT) along selected dimensions.\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: bitmask
    type: string
    doc: bitmask
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: input
    inputBinding:
      position: 2
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: inverse
    inputBinding:
      position: 103
      prefix: -i
  - id: uncentered
    type:
      - 'null'
      - boolean
    doc: un-centered
    inputBinding:
      position: 103
      prefix: -n
  - id: unitary
    type:
      - 'null'
      - boolean
    doc: unitary
    inputBinding:
      position: 103
      prefix: -u
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
