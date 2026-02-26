cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal_showbalance
label: kpal_showbalance
doc: "Show the balance of k-mer profiles.\n\nTool homepage: https://github.com/LUMC/kPAL"
inputs:
  - id: input
    type: File
    doc: input k-mer profile file
    inputBinding:
      position: 1
  - id: precision
    type:
      - 'null'
      - int
    doc: precision in number of decimals
    default: 10
    inputBinding:
      position: 102
      prefix: -n
  - id: profiles
    type:
      - 'null'
      - type: array
        items: string
    doc: 'names of the k-mer profiles to consider (default: all profiles in INPUT,
      in alphabetical order)'
    inputBinding:
      position: 102
      prefix: --profiles
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
stdout: kpal_showbalance.out
