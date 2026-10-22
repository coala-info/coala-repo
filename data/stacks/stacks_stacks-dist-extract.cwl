cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-dist-extract
label: stacks_stacks-dist-extract
doc: "Export a particular section of a Stacks log or distribs file; with a log path alone it lists the available sections.

Tool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: "Output data as a table with columns lined up."
    inputBinding:
      position: 101
      prefix: --pretty
  - id: out_path
    type:
      - 'null'
      - string
    doc: "Path to output file."
    inputBinding:
      position: 101
      prefix: --out-path
  - id: section
    type:
      - 'null'
      - string
    doc: "Name of section to output from the log file."
    inputBinding:
      position: 202
  - id: logfile
    type: File
    doc: "Stacks log or distribs file"
    inputBinding:
      position: 201
outputs:
  - id: extracted
    type:
      - 'null'
      - File
    doc: Extracted section (when --out-path is given)
    outputBinding:
      glob: '${ return inputs.out_path ? inputs.out_path : []; }'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_stacks-dist-extract.out
