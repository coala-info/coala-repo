cwlVersion: v1.2
class: CommandLineTool
baseCommand: needle
label: needle_specified
doc: "Needle allows you to build an Interleaved Bloom Filter (IBF) with the command
  ibf or estimate the expression of transcripts with the command estimate.\n\nTool
  homepage: https://github.com/seqan/needle"
inputs:
  - id: export_help
    type:
      - 'null'
      - string
    doc: Export the help page information. Value must be one of [html, man].
    inputBinding:
      position: 101
      prefix: --export-help
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Whether to check for the newest app version.
    inputBinding:
      position: 101
      prefix: --version-check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
stdout: needle_specified.out
