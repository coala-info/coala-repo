cwlVersion: v1.2
class: CommandLineTool
baseCommand: cryfa_keygen
label: cryfa_keygen
doc: "A utility to generate a key for Cryfa encryption by providing a password and
  an output file path.\n\nTool homepage: https://github.com/smortezah/cryfa"
inputs:
  - id: password
    type: string
    doc: Password used to generate the key
    inputBinding:
      position: 1
outputs:
  - id: key_file
    type: File
    doc: File name/path to save the generated key
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cryfa:20.04--h9948957_3
