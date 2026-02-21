cwlVersion: v1.2
class: CommandLineTool
baseCommand: ln
label: art_ln
doc: "Create a link LINK or DIR/TARGET to the specified TARGET(s)\n\nTool homepage:
  https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: targets
    type:
      type: array
      items: File
    doc: The source file(s) or directory to link
    inputBinding:
      position: 1
  - id: link_or_dir
    type: string
    doc: The destination link name or directory
    inputBinding:
      position: 2
  - id: backup
    type:
      - 'null'
      - boolean
    doc: Make a backup of the target (if exists) before link operation
    inputBinding:
      position: 103
      prefix: -b
  - id: force
    type:
      - 'null'
      - boolean
    doc: Remove existing destinations
    inputBinding:
      position: 103
      prefix: -f
  - id: no_dereference
    type:
      - 'null'
      - boolean
    doc: Don't dereference symlinks - treat like normal file
    inputBinding:
      position: 103
      prefix: -n
  - id: no_target_directory
    type:
      - 'null'
      - boolean
    doc: Treat LINK as a file, not DIR
    inputBinding:
      position: 103
      prefix: -T
  - id: suffix
    type:
      - 'null'
      - string
    doc: Use suffix instead of ~ when making backup files
    inputBinding:
      position: 103
      prefix: -S
  - id: symbolic
    type:
      - 'null'
      - boolean
    doc: Make symlinks instead of hardlinks
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_ln.out
