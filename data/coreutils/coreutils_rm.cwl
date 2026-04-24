cwlVersion: v1.2
class: CommandLineTool
baseCommand: rm
label: coreutils_rm
doc: "Remove (unlink) the FILE(s).\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: File(s) to remove
    inputBinding:
      position: 1
  - id: dir
    type:
      - 'null'
      - boolean
    doc: remove empty directories
    inputBinding:
      position: 102
      prefix: --dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: ignore nonexistent files and arguments, never prompt
    inputBinding:
      position: 102
      prefix: --force
  - id: interactive
    type:
      - 'null'
      - string
    doc: 'prompt according to WHEN: never, once (-I), or always (-i); without WHEN,
      prompt always'
    inputBinding:
      position: 102
      prefix: --interactive
  - id: no_preserve_root
    type:
      - 'null'
      - boolean
    doc: do not treat '/' specially
    inputBinding:
      position: 102
      prefix: --no-preserve-root
  - id: one_file_system
    type:
      - 'null'
      - boolean
    doc: when removing a hierarchy recursively, skip any directory that is on a file
      system different from that of the corresponding command line argument
    inputBinding:
      position: 102
      prefix: --one-file-system
  - id: preserve_root
    type:
      - 'null'
      - string
    doc: do not remove '/' (default); with 'all', reject any command line argument
      on a separate device from its parent
    inputBinding:
      position: 102
      prefix: --preserve-root
  - id: prompt_always
    type:
      - 'null'
      - boolean
    doc: prompt before every removal
    inputBinding:
      position: 102
      prefix: -i
  - id: prompt_once
    type:
      - 'null'
      - boolean
    doc: prompt once before removing more than three files, or when removing recursively
    inputBinding:
      position: 102
      prefix: -I
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: remove directories and their contents recursively
    inputBinding:
      position: 102
      prefix: --recursive
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: explain what is being done
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_rm.out
