cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal_convert
label: kpal_convert
doc: "Save k-mer profiles from files in the old plaintext format (used by kPAL versions
  < 1.0.0) to a k-mer profile file in the current HDF5 format.\n\nTool homepage: https://github.com/LUMC/kPAL"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: input file
    default: stdin
    inputBinding:
      position: 1
  - id: profiles
    type:
      - 'null'
      - type: array
        items: string
    doc: names for the saved k-mer profiles, one per INPUT
    default: profiles are named according to the input filenames, or numbered 
      consecutively from 1 if no filenames are available
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
