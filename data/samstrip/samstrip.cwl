cwlVersion: v1.2
class: CommandLineTool
baseCommand: samstrip
label: samstrip
doc: "Reads a SAM file from stdin, and prints the equivalent stripped file to stdout.
  A stripped file has the SEQ and QUAL fields removed, and auxiliary tags depending
  on the setting. Barring any aligner-specific auxiliary tags, a stripped SAM file
  contain the same alignment information as a full file, but takes up less disk space.\n\
  \nTool homepage: https://github.com/jakobnissen/samstrip"
inputs:
  - id: keep_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of aux tags to keep in file (default: NM)'
    inputBinding:
      position: 101
      prefix: --keep
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: Allow input without SAM header
    inputBinding:
      position: 101
      prefix: --noheader
  - id: remove_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: List of aux tags to remove (incompatible with --keep)
    inputBinding:
      position: 101
      prefix: --remove
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samstrip:0.2.1--h4349ce8_0
stdout: samstrip.out
