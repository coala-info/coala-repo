cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgv download
label: tgv_download
doc: "Download command\n\nTool homepage: https://github.com/zeqianli/tgv"
inputs:
  - id: reference
    type: string
    doc: Name to download
    inputBinding:
      position: 1
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Cache directory
    inputBinding:
      position: 102
      prefix: --cache-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgv:0.1.0--h521fa98_0
stdout: tgv_download.out
