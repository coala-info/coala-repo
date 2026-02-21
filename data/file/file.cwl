cwlVersion: v1.2
class: CommandLineTool
baseCommand: file
label: file
doc: "Determine file type\n\nTool homepage: https://github.com/microsoft/markitdown"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The list of files to be examined
    inputBinding:
      position: 1
  - id: brief
    type:
      - 'null'
      - boolean
    doc: Do not prepend filenames to output lines (brief mode).
    inputBinding:
      position: 102
      prefix: --brief
  - id: dereference
    type:
      - 'null'
      - boolean
    doc: Follow symbolic links.
    inputBinding:
      position: 102
      prefix: --dereference
  - id: magic_file
    type:
      - 'null'
      - File
    doc: Specify an alternate list of matches in compiled format for magic numbers.
    inputBinding:
      position: 102
      prefix: --magic-file
  - id: mime
    type:
      - 'null'
      - boolean
    doc: Causes the file command to output mime type strings rather than the more
      traditional human readable ones.
    inputBinding:
      position: 102
      prefix: --mime
  - id: preserve_date
    type:
      - 'null'
      - boolean
    doc: On systems that support utime(2) or utimes(2), attempt to preserve the access
      time of files analyzed.
    inputBinding:
      position: 102
      prefix: --preserve-date
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/file:5.39
stdout: file.out
