cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./GeDe3
label: geco3_GeDe3
doc: "Decompress genomic sequences for compressed by GeCo3.\n\nTool homepage: https://github.com/cobilab/geco3"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input compressed filename (to decompress) -- MANDATORY.\n           File(s)
      to decompress (last argument).\n           For more files use splitting \":\"\
      \ characters."
    inputBinding:
      position: 1
  - id: force_mode
    type:
      - 'null'
      - boolean
    doc: force mode. Overwrites old files.
    inputBinding:
      position: 102
      prefix: --force
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference sequence filename ("-rm" are trainned here).
    inputBinding:
      position: 102
      prefix: --reference
  - id: verbose_mode
    type:
      - 'null'
      - boolean
    doc: verbose mode (more information).
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geco3:1.0--h7b50bb2_5
stdout: geco3_GeDe3.out
