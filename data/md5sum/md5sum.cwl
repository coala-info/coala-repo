cwlVersion: v1.2
class: CommandLineTool
baseCommand: md5sum
label: md5sum
doc: "Print or check MD5 (128-bit) checksums.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to compute MD5 checksums for. With no FILE, or when FILE is -, 
      read standard input.
    inputBinding:
      position: 1
  - id: binary
    type:
      - 'null'
      - boolean
    doc: read in binary mode
    inputBinding:
      position: 102
      prefix: --binary
  - id: check
    type:
      - 'null'
      - boolean
    doc: read checksums from the FILEs and check them
    inputBinding:
      position: 102
      prefix: --check
  - id: ignore_missing
    type:
      - 'null'
      - boolean
    doc: don't fail or report status for missing files
    inputBinding:
      position: 102
      prefix: --ignore-missing
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: don't print OK for each successfully verified file
    inputBinding:
      position: 102
      prefix: --quiet
  - id: status
    type:
      - 'null'
      - boolean
    doc: don't output anything, status code shows success
    inputBinding:
      position: 102
      prefix: --status
  - id: strict
    type:
      - 'null'
      - boolean
    doc: exit non-zero for improperly formatted checksum lines
    inputBinding:
      position: 102
      prefix: --strict
  - id: tag
    type:
      - 'null'
      - boolean
    doc: create a BSD-style checksum
    inputBinding:
      position: 102
      prefix: --tag
  - id: text
    type:
      - 'null'
      - boolean
    doc: read in text mode (default)
    inputBinding:
      position: 102
      prefix: --text
  - id: warn
    type:
      - 'null'
      - boolean
    doc: warn about improperly formatted checksum lines
    inputBinding:
      position: 102
      prefix: --warn
  - id: zero
    type:
      - 'null'
      - boolean
    doc: end each output line with NUL, not newline, and disable file name 
      escaping
    inputBinding:
      position: 102
      prefix: --zero
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
stdout: md5sum.out
