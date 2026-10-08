cwlVersion: v1.2
class: CommandLineTool
baseCommand: Fastcp
label: fastk_Fastcp
doc: "Copies a FastK histogram, table or profile with all its hidden part files.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs:
  - id: source_files
    type: File[]
    doc: 'All files of the source: stub (.hist, .ktab or .prof) and hidden part files.'
  - id: source
    type: string
    doc: Name of the source stub file (as in source_files).
    inputBinding:
      position: 100
  - id: dest
    type: string
    doc: Name of the destination stub file.
    inputBinding:
      position: 101
  - id: prompt
    type:
      - 'null'
      - boolean
    doc: Prompt for each (stub) overwrite.
    inputBinding:
      position: 50
      prefix: '-i'
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Do not overwrite existing files.
    inputBinding:
      position: 50
      prefix: '-n'
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
  - id: dest_files
    type:
      type: array
      items: File
    doc: Destination stub and hidden part files.
    outputBinding:
      glob: |
        ${
          var s = inputs.dest.replace(/\.(ktab|prof|hist)$/, '');
          return [s + '.ktab', s + '.prof', s + '.hist', '.' + s + '.ktab.*', '.' + s + '.prof.*', '.' + s + '.pidx.*'];
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.source_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Fastcp.out
