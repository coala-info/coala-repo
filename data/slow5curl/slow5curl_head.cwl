cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5curl
  - head
label: slow5curl_head
doc: "Prints the header for a remote BLOW5 file.\n\nTool homepage: https://github.com/BonsonW/slow5curl"
inputs:
  - id: slow5_file
    type:
      - 'null'
      - File
    doc: Remote BLOW5 file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
stdout: slow5curl_head.out
