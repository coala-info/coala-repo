cwlVersion: v1.2
class: CommandLineTool
baseCommand: slow5curl_reads
label: slow5curl_reads
doc: "Prints the reads in a remote BLOW5 file.\n\nTool homepage: https://github.com/BonsonW/slow5curl"
inputs:
  - id: slow5_file
    type:
      - 'null'
      - File
    doc: Remote BLOW5 file
    inputBinding:
      position: 1
  - id: cache
    type:
      - 'null'
      - File
    doc: save the downloaded index to the specified file path
    default: 'false'
    inputBinding:
      position: 102
      prefix: --cache
  - id: index
    type:
      - 'null'
      - File
    doc: specify path to a custom slow5 index
    inputBinding:
      position: 102
      prefix: --index
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
stdout: slow5curl_reads.out
