cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal scale
label: kpal_scale
doc: "Scale two profiles such that the total number of k-mers is equal. If the files
  contain more than one profile, they are linked by name and processed pairwise.\n\
  \nTool homepage: https://github.com/LUMC/kPAL"
inputs:
  - id: input_left
    type: File
    doc: input k-mer profile file (left)
    inputBinding:
      position: 1
  - id: input_right
    type: File
    doc: input k-mer profile file (right)
    inputBinding:
      position: 2
  - id: profiles_left
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the k-mer profiles to consider (left)
    default: all profiles in INPUT_LEFT, in alphabetical order
    inputBinding:
      position: 103
      prefix: --profiles-left
  - id: profiles_right
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the k-mer profiles to consider (right)
    default: all profiles in INPUT_RIGHT, in alphabetical order
    inputBinding:
      position: 103
      prefix: --profiles-right
  - id: scale_down
    type:
      - 'null'
      - boolean
    doc: scale down
    inputBinding:
      position: 103
      prefix: -d
outputs:
  - id: output_left
    type: File
    doc: output k-mer profile file (left)
    outputBinding:
      glob: '*.out'
  - id: output_right
    type: File
    doc: output k-mer profile file (right)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
