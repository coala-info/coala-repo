cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextclade
label: nextclade_js_nextclade
doc: "Viral genome alignment, mutation calling, clade assignment, quality checks and
  phylogenetic placement.\n\nTool homepage: https://github.com/nextstrain/nextclade"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: completions, run, dataset, sort,
      read-annotation, schema, help-markdown, help'
    inputBinding:
      position: 1
  - id: color
    type:
      - 'null'
      - string
    doc: Control when to use colored output
    inputBinding:
      position: 102
      prefix: --color
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable colored output (shorthand for --color=never)
    inputBinding:
      position: 102
      prefix: --no-color
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Make console output more quiet. Add multiple occurrences to make output
      even more quiet
    inputBinding:
      position: 102
      prefix: --quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Disable all console output. Same as --verbosity=off
    inputBinding:
      position: 102
      prefix: --silent
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Make console output more verbose. Add multiple occurrences to increase 
      verbosity further
    inputBinding:
      position: 102
      prefix: --verbose
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set verbosity level of console output
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
stdout: nextclade_js_nextclade.out
