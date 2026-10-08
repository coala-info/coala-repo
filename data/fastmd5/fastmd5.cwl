cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastmd5
label: fastmd5
doc: "Print or check MD5 checksums.\n\nTool homepage: https://github.com/moold/fastMD5"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Files to checksum, or MD5 sum files when --check is used.
    inputBinding:
      position: 101
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the MD5 sum files when --check is used; staged in the working directory so the names resolve.
  - id: check
    type:
      - 'null'
      - boolean
    doc: Read MD5 sums from the FILEs and check them.
    inputBinding:
      position: 1
      prefix: --check
  - id: speed
    type:
      - 'null'
      - int
    doc: 'Speed level from 0 (slowest, full computation) to 9 (fastest, approximate checksums) [default: 5].'
    inputBinding:
      position: 1
      prefix: --speed
  - id: thread
    type:
      - 'null'
      - int
    doc: 'Number of threads [default: 3].'
    inputBinding:
      position: 1
      prefix: --thread
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: When the input is a directory, do not ignore hidden files.
    inputBinding:
      position: 1
      prefix: --hidden
  - id: link
    type:
      - 'null'
      - boolean
    doc: When the input is a directory, do not ignore symbolic links.
    inputBinding:
      position: 1
      prefix: --link
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print OK for each successfully verified file.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: status
    type:
      - 'null'
      - boolean
    doc: Do not output anything, the status code shows success.
    inputBinding:
      position: 1
      prefix: --status
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.listed_files ? inputs.listed_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastmd5:1.0.0--h3ab6199_0
stdout: fastmd5.out
