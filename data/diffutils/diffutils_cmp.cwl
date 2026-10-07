cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmp
label: diffutils_cmp
doc: "Compare two files byte by byte.\n\nTool homepage: https://www.gnu.org/software/diffutils/"
inputs:
  - id: file1
    type: File
    doc: First file to compare
    inputBinding:
      position: 1
  - id: file2
    type:
      - 'null'
      - File
    doc: Second file to compare
    inputBinding:
      position: 2
  - id: skip1
    type:
      - 'null'
      - int
    doc: Number of bytes to skip from the beginning of FILE1
    inputBinding:
      position: 3
  - id: skip2
    type:
      - 'null'
      - int
    doc: Number of bytes to skip from the beginning of FILE2
    inputBinding:
      position: 4
  - id: bytes_limit
    type:
      - 'null'
      - int
    doc: Compare at most LIMIT bytes
    inputBinding:
      position: 105
      prefix: --bytes
  - id: ignore_initial
    type:
      - 'null'
      - string
    doc: Skip first SKIP bytes of both inputs, or SKIP1:SKIP2 to skip SKIP1 
      bytes of FILE1 and SKIP2 bytes of FILE2
    inputBinding:
      position: 105
      prefix: --ignore-initial
  - id: print_bytes
    type:
      - 'null'
      - boolean
    doc: Print differing bytes
    inputBinding:
      position: 105
      prefix: --print-bytes
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Suppress all normal output
    inputBinding:
      position: 105
      prefix: --silent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output byte numbers and differing byte values
    inputBinding:
      position: 105
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diffutils:3.10
stdout: diffutils_cmp.out
successCodes:
  - 0
  - 1
