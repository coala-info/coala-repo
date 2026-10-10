cwlVersion: v1.2
class: CommandLineTool
baseCommand: errno
label: moreutils_errno
doc: "Look up errno names and descriptions by name, number or text keyword, or
  list all of them.\n\nTool homepage: https://github.com/madx/moreutils"
inputs:
  - id: keyword
    type:
      - 'null'
      - string
    doc: An errno name (ENOENT), an errno number, or a keyword to search for.
    inputBinding:
      position: 2
  - id: list
    type:
      - 'null'
      - boolean
    doc: List all errno names, numbers and descriptions.
    inputBinding:
      position: 1
      prefix: -l
  - id: search
    type:
      - 'null'
      - boolean
    doc: Search for the keyword in the descriptions.
    inputBinding:
      position: 1
      prefix: -s
  - id: search_all_locales
    type:
      - 'null'
      - boolean
    doc: Search for the keyword in the descriptions of all locales.
    inputBinding:
      position: 1
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_errno.out
