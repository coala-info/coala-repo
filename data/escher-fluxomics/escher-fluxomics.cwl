cwlVersion: v1.2
class: CommandLineTool
baseCommand: cp
label: escher-fluxomics
doc: "Copy SOURCE(s) to DEST\n\nTool homepage: https://escher.github.io"
inputs:
  - id: sources
    type:
      type: array
      items: File
    doc: Source file(s) to copy
    inputBinding:
      position: 1
  - id: destination
    type: File
    doc: Destination file or directory
    inputBinding:
      position: 2
  - id: archive
    type:
      - 'null'
      - boolean
    doc: Same as -dpR
    inputBinding:
      position: 103
      prefix: -a
  - id: copy_only_newer
    type:
      - 'null'
      - boolean
    doc: Copy only newer files
    inputBinding:
      position: 103
      prefix: -u
  - id: create_links
    type:
      - 'null'
      - boolean
    doc: Create (sym)links
    inputBinding:
      position: 103
      prefix: -s
  - id: follow_all_symlinks
    type:
      - 'null'
      - boolean
    doc: Follow all symlinks
    inputBinding:
      position: 103
      prefix: -L
  - id: follow_command_line_symlinks
    type:
      - 'null'
      - boolean
    doc: Follow symlinks on command line
    inputBinding:
      position: 103
      prefix: -H
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite
    inputBinding:
      position: 103
      prefix: -f
  - id: preserve_attributes
    type:
      - 'null'
      - boolean
    doc: Preserve file attributes if possible
    inputBinding:
      position: 103
      prefix: -p
  - id: preserve_symlinks
    type:
      - 'null'
      - boolean
    doc: Preserve symlinks (default if -R)
    inputBinding:
      position: 103
      prefix: -P
  - id: prompt_before_overwrite
    type:
      - 'null'
      - boolean
    doc: Prompt before overwrite
    inputBinding:
      position: 103
      prefix: -i
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recurse
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/escher-fluxomics:phenomenal-v1.6.0-beta.4_cv1.1.20
stdout: escher-fluxomics.out
