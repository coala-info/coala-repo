cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal_cat
label: kpal_cat
doc: "Save k-mer profiles from several files to one k-mer profile file.\n\nTool homepage:
  https://github.com/LUMC/kPAL"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: input k-mer profile file
    inputBinding:
      position: 1
  - id: prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: prefixes to use for the saved k-mer profile names, one per INPUT
    inputBinding:
      position: 102
      prefix: --prefixes
  - id: profiles
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the k-mer profiles to consider
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
