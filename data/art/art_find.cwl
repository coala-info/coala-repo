cwlVersion: v1.2
class: CommandLineTool
baseCommand: art_find
label: art_find
doc: "A tool to search for and list files within a directory structure, specifically
  tailored for identifying 'art' related project files and documentation.\n\nTool
  homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: path
    type:
      - 'null'
      - Directory
    doc: The starting directory path for the search.
    default: .
    inputBinding:
      position: 1
  - id: name_pattern
    type:
      - 'null'
      - string
    doc: Filter files by a specific name pattern (e.g., 'art').
    inputBinding:
      position: 102
      prefix: --name
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search through subdirectories recursively.
    inputBinding:
      position: 102
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_find.out
