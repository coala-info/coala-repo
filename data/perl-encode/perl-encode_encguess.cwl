cwlVersion: v1.2
class: CommandLineTool
baseCommand: encguess
label: perl-encode_encguess
doc: "Guess the character encoding of files. The result is one line per file.\n\nTool homepage: http://metacpan.org/pod/Encode"
inputs:
  - id: files
    type: 'File[]'
    doc: Files whose encoding is to be guessed
    inputBinding:
      position: 10
  - id: suspects
    type:
      - 'null'
      - string
    doc: List of suspect encoding types to test, separated by ":" or ","
    inputBinding:
      position: 1
      prefix: -s
  - id: list_suspects
    type:
      - 'null'
      - boolean
    doc: Output a list of all acceptable encoding types that can be used with -s
    inputBinding:
      position: 1
      prefix: -S
  - id: suppress_unidentified
    type:
      - 'null'
      - boolean
    doc: Suppress display of unidentified types
    inputBinding:
      position: 1
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Guessed encoding per file on standard output
stdout: perl-encode_encguess.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-encode:3.19--pl5321hec16e2b_1
