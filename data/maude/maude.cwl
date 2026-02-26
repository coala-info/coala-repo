cwlVersion: v1.2
class: CommandLineTool
baseCommand: maude
label: maude
doc: "Maude interpreter\n\nTool homepage: https://github.com/maude-lang/Maude"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: string
    doc: Files to process
    inputBinding:
      position: 1
  - id: always_advise
    type:
      - 'null'
      - boolean
    doc: Always show advisories regardless
    inputBinding:
      position: 102
      prefix: --always-advise
  - id: ansi_color
    type:
      - 'null'
      - boolean
    doc: Use ANSI control sequences
    inputBinding:
      position: 102
      prefix: --ansi-color
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Run in batch mode
    inputBinding:
      position: 102
      prefix: --batch
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Run in interactive mode
    inputBinding:
      position: 102
      prefix: --interactive
  - id: no_advise
    type:
      - 'null'
      - boolean
    doc: No advisories on startup
    inputBinding:
      position: 102
      prefix: --no-advise
  - id: no_ansi_color
    type:
      - 'null'
      - boolean
    doc: Do not use ANSI control sequences
    inputBinding:
      position: 102
      prefix: --no-ansi-color
  - id: no_banner
    type:
      - 'null'
      - boolean
    doc: Do not output banner on startup
    inputBinding:
      position: 102
      prefix: --no-banner
  - id: no_mixfix
    type:
      - 'null'
      - boolean
    doc: Do not use mixfix notation for output
    inputBinding:
      position: 102
      prefix: --no-mixfix
  - id: no_prelude
    type:
      - 'null'
      - boolean
    doc: Do not read in the standard prelude
    inputBinding:
      position: 102
      prefix: --no-prelude
  - id: no_tecla
    type:
      - 'null'
      - boolean
    doc: Do not use tecla command line editing
    inputBinding:
      position: 102
      prefix: --no-tecla
  - id: no_wrap
    type:
      - 'null'
      - boolean
    doc: Do not automatic line wrapping for output
    inputBinding:
      position: 102
      prefix: --no-wrap
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Set seed for random number generator
    inputBinding:
      position: 102
      prefix: --random-seed
  - id: tecla
    type:
      - 'null'
      - boolean
    doc: Use tecla command line editing
    inputBinding:
      position: 102
      prefix: --tecla
  - id: xml_log
    type:
      - 'null'
      - File
    doc: Set file in which to produce an xml log
    inputBinding:
      position: 102
      prefix: --xml-log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maude:v2.7-2b1-deb_cv1
stdout: maude.out
