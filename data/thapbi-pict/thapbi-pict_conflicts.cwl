cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - conflicts
label: thapbi-pict_conflicts
doc: "Count genus or species conflicts in a marker database.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: database
    type:
      - 'null'
      - File
    doc: "Marker database to use, default '-' for bundled DB."
    inputBinding:
      position: 101
      prefix: -d
  - id: output
    type:
      - 'null'
      - string
    doc: "File to write to (default '-' meaning stdout)"
    inputBinding:
      position: 101
      prefix: -o
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Conflict report"
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
    doc: "Standard output when no output file is given"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_conflicts.out
