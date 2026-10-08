cwlVersion: v1.2
class: CommandLineTool
baseCommand: GIXmv
label: fastga_GIXmv
doc: "Moves (renames) a genome database (.1gdb) or genome index (.gix) together with its hidden files.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: source_files
    type: File[]
    doc: 'All files of the source database or index: .1gdb with its hidden .bps, and .gix with its hidden .ktab.N files.'
  - id: source
    type: string
    doc: Name of the source .1gdb or .gix file (as in source_files).
    inputBinding:
      position: 100
  - id: target
    type: string
    doc: Name of the target .1gdb or .gix file.
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose mode, list what is being deleted.'
    inputBinding:
      position: 101
      prefix: '-v'
  - id: prompt
    type:
      - 'null'
      - boolean
    doc: Prompt for each deletion.
    inputBinding:
      position: 101
      prefix: '-i'
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Do not overwrite existing files.
    inputBinding:
      position: 101
      prefix: '-n'
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force operation quietly.
    inputBinding:
      position: 101
      prefix: '-f'
outputs:
  - id: result_files
    type:
      type: array
      items: File
    doc: Moved files.
    outputBinding:
      glob: |
        ${
          var s = inputs.target.replace(/\.(gix|1gdb)$/, '');
          return [s + '.gix', s + '.1gdb', '.' + s + '.*'];
        }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.source_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXmv.out
