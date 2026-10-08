cwlVersion: v1.2
class: CommandLineTool
baseCommand: Fastrm
label: fastk_Fastrm
doc: "Deletes FastK histograms, tables or profiles with all their hidden part files.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs:
  - id: source_files
    type: File[]
    doc: 'All files of the items to delete: stubs and hidden part files.'
  - id: sources
    type: string[]
    doc: Names of the stub files to delete (as in source_files).
    inputBinding:
      position: 100
  - id: prompt
    type:
      - 'null'
      - boolean
    doc: Prompt for each (stub) deletion.
    inputBinding:
      position: 50
      prefix: '-i'
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force operation quietly.
    inputBinding:
      position: 50
      prefix: '-f'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: remaining_files
    type:
      type: array
      items: File
    doc: Files left in the working directory after the deletion.
    outputBinding:
      glob: |
        ${
          return ['*', '.*.*'];
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.source_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Fastrm.out
