cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg_download
label: ufcg_download
doc: "List or download resources\n\nTool homepage: https://ufcg.steineggerlab.com"
inputs:
  - id: check_status
    type:
      - 'null'
      - boolean
    doc: Check download status
    inputBinding:
      position: 101
      prefix: -c
  - id: developer
    type:
      - 'null'
      - boolean
    doc: Activate developer mode (For testing or debugging)
    inputBinding:
      position: 101
      prefix: --developer
  - id: download_directory
    type:
      - 'null'
      - Directory
    doc: Download directory
    inputBinding:
      position: 101
      prefix: -d
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Remove ANSI escapes from standard output
    inputBinding:
      position: 101
      prefix: --nocolor
  - id: no_time
    type:
      - 'null'
      - boolean
    doc: Remove timestamp in front of the prompt string
    inputBinding:
      position: 101
      prefix: --notime
  - id: target
    type:
      type: array
      items: string
    doc: Target to download (full, minimum, config, core, busco, sample)
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Make program verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
stdout: ufcg_download.out
