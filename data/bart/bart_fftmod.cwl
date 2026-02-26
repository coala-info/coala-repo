cwlVersion: v1.2
class: CommandLineTool
baseCommand: fftmod
label: bart_fftmod
doc: "Apply 1 -1 modulation along dimensions selected by the {bitmask}.\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: bitmask
    type: string
    doc: Bitmask specifying dimensions for modulation
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input file
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
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
