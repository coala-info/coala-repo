cwlVersion: v1.2
class: CommandLineTool
baseCommand: keygen
label: cryfa_keygen
doc: "A utility to generate a key for Cryfa encryption by providing a password and
  an output file path. keygen reads the password and the key file name from standard
  input; this wrapper writes both lines to a file that is redirected to standard input.\n\n\
  Tool homepage: https://github.com/smortezah/cryfa"
inputs:
  - id: password
    type: string
    doc: Password used to generate the key
  - id: key_name
    type: string
    default: key.txt
    doc: File name to save the generated key (no spaces)
outputs:
  - id: key_file
    type: File
    doc: Generated key file
    outputBinding:
      glob: $(inputs.key_name)
arguments:
  - position: 1
    valueFrom: <
    shellQuote: false
  - position: 2
    valueFrom: keygen_stdin.txt
requirements:
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: keygen_stdin.txt
        entry: "$(inputs.password)\n$(inputs.key_name)\n"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cryfa:20.04--h9948957_3
