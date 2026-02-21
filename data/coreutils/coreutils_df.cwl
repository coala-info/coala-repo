cwlVersion: v1.2
class: CommandLineTool
baseCommand: df
label: coreutils_df
doc: "Show information about the file system on which each FILE resides, or all file
  systems by default.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to check for file system information
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: include pseudo, duplicate, inaccessible file systems
    inputBinding:
      position: 102
      prefix: --all
  - id: block_size
    type:
      - 'null'
      - string
    doc: scale sizes by SIZE before printing them; e.g., '-BM' prints sizes in units
      of 1,048,576 bytes
    inputBinding:
      position: 102
      prefix: --block-size
  - id: block_size_1k
    type:
      - 'null'
      - boolean
    doc: like --block-size=1K
    inputBinding:
      position: 102
      prefix: -k
  - id: exclude_type
    type:
      - 'null'
      - string
    doc: limit listing to file systems not of type TYPE
    inputBinding:
      position: 102
      prefix: --exclude-type
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: print sizes in powers of 1024 (e.g., 1023M)
    inputBinding:
      position: 102
      prefix: --human-readable
  - id: ignored
    type:
      - 'null'
      - boolean
    doc: (ignored)
    inputBinding:
      position: 102
      prefix: -v
  - id: inodes
    type:
      - 'null'
      - boolean
    doc: list inode information instead of block usage
    inputBinding:
      position: 102
      prefix: --inodes
  - id: local
    type:
      - 'null'
      - boolean
    doc: limit listing to local file systems
    inputBinding:
      position: 102
      prefix: --local
  - id: no_sync
    type:
      - 'null'
      - boolean
    doc: do not invoke sync before getting usage info (default)
    inputBinding:
      position: 102
      prefix: --no-sync
  - id: output
    type:
      - 'null'
      - string
    doc: use the output format defined by FIELD_LIST, or print all fields if FIELD_LIST
      is omitted.
    inputBinding:
      position: 102
      prefix: --output
  - id: portability
    type:
      - 'null'
      - boolean
    doc: use the POSIX output format
    inputBinding:
      position: 102
      prefix: --portability
  - id: print_type
    type:
      - 'null'
      - boolean
    doc: print file system type
    inputBinding:
      position: 102
      prefix: --print-type
  - id: si
    type:
      - 'null'
      - boolean
    doc: print sizes in powers of 1000 (e.g., 1.1G)
    inputBinding:
      position: 102
      prefix: --si
  - id: sync
    type:
      - 'null'
      - boolean
    doc: invoke sync before getting usage info
    inputBinding:
      position: 102
      prefix: --sync
  - id: total
    type:
      - 'null'
      - boolean
    doc: elide all entries insignificant to available space, and produce a grand total
    inputBinding:
      position: 102
      prefix: --total
  - id: type
    type:
      - 'null'
      - string
    doc: limit listing to file systems of type TYPE
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_df.out
