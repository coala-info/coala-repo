cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/runMegaPath-Amplicon.sh
label: megapath_runMegaPath-Amplicon.sh
doc: "Run MegaPath for amplicon sequencing.\n\nTool homepage: https://github.com/edwwlui/MegaPath"
inputs:
  - id: database_directory
    type:
      - 'null'
      - Directory
    doc: Database directory
    default: /usr/local/MegaPath/db
    inputBinding:
      position: 101
      prefix: -d
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Maximum read length
    default: 250
    inputBinding:
      position: 101
      prefix: -L
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    default: megapath-amplicon
    inputBinding:
      position: 101
      prefix: -p
  - id: read1
    type: File
    doc: First read file
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read2
    type: File
    doc: Second read file
    inputBinding:
      position: 101
      prefix: '-2'
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 45
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath:2--h43eeafb_4
stdout: megapath_runMegaPath-Amplicon.sh.out
