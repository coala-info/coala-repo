cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeDe2
label: geco2_GeDe2
doc: "GeDe2 v1.1: decompresses genomic sequences compressed by GeCo2.\n\nTool homepage: https://github.com/cobilab/geco2"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force mode. Overwrites old files."
    inputBinding:
      position: 101
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose mode (more information)."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: reference_file
    type:
      - 'null'
      - File
    doc: "Reference sequence filename (the same reference used for the compression)."
    inputBinding:
      position: 101
      prefix: --reference
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input compressed filename (to decompress), mandatory and the last argument. For more files use the \":\" separator."
    inputBinding:
      position: 200
      itemSeparator: ':'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: decompressed_files
    type:
      type: array
      items: File
    doc: Decompressed files (.de) written next to the input files
    outputBinding:
      glob: '*.de'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geco2:1.1--h7b50bb2_5
stdout: geco2_GeDe2.out
