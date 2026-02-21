cwlVersion: v1.2
class: CommandLineTool
baseCommand: art_du
label: art_du
doc: "Summarize disk usage of the set of FILEs, recursively for directories.\n\nTool
  homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: File or directory to check disk usage for
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: write counts for all files, not just directories
    inputBinding:
      position: 102
      prefix: --all
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: print sizes in human readable format (e.g., 1K 234M 2G)
    inputBinding:
      position: 102
      prefix: --human-readable
  - id: max_depth
    type:
      - 'null'
      - int
    doc: print the total for a directory (or file, with --all) only if it is N or
      fewer levels below the command line argument
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: display only a total for each argument
    inputBinding:
      position: 102
      prefix: --summarize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_du.out
