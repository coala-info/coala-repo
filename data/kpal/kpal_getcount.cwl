cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal_getcount
label: kpal_getcount
doc: "Retrieve the counts in k-mer profiles for a particular word.\n\nTool homepage:
  https://github.com/LUMC/kPAL"
inputs:
  - id: input
    type: File
    doc: input k-mer profile file
    inputBinding:
      position: 1
  - id: word
    type: string
    doc: the word in question
    inputBinding:
      position: 2
  - id: profiles
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the k-mer profiles to consider
    default: all profiles in INPUT, in alphabetical order
    inputBinding:
      position: 103
      prefix: --profiles
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
stdout: kpal_getcount.out
