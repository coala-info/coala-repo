cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal shuffle
label: kpal_shuffle
doc: "Randomise k-mer profiles.\n\nTool homepage: https://github.com/LUMC/kPAL"
inputs:
  - id: input
    type: File
    doc: input k-mer profile file
    inputBinding:
      position: 1
  - id: profiles
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the k-mer profiles to consider
    default: all profiles in INPUT, in alphabetical order
    inputBinding:
      position: 102
      prefix: --profiles
outputs:
  - id: output
    type: File
    doc: output k-mer profile file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
