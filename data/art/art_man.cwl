cwlVersion: v1.2
class: CommandLineTool
baseCommand: man
label: art_man
doc: "Display manual page\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: section_positional
    type:
      - 'null'
      - string
    doc: Manual section
    inputBinding:
      position: 1
  - id: manpage
    type:
      type: array
      items: string
    doc: Manual page name and optional section extension
    inputBinding:
      position: 2
  - id: all_pages
    type:
      - 'null'
      - boolean
    doc: Display all pages
    inputBinding:
      position: 103
      prefix: -a
  - id: show_locations
    type:
      - 'null'
      - boolean
    doc: Show page locations
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_man.out
