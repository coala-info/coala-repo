cwlVersion: v1.2
class: CommandLineTool
baseCommand: savont download
label: savont_download
doc: "Download reference databases for savont (EMU or SILVA)\n\nTool homepage: https://github.com/bluenote-1577/savont"
inputs:
  - id: emu_db
    type:
      - 'null'
      - boolean
    doc: Download EMU database
    inputBinding:
      position: 101
      prefix: --emu-db
  - id: location
    type: Directory
    doc: Download location directory
    inputBinding:
      position: 101
      prefix: --location
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging verbosity level
    inputBinding:
      position: 101
      prefix: --log-level
  - id: silva_db
    type:
      - 'null'
      - boolean
    doc: Download SILVA database
    inputBinding:
      position: 101
      prefix: --silva-db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savont:0.3.2--h3ab6199_0
stdout: savont_download.out
