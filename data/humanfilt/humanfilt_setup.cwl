cwlVersion: v1.2
class: CommandLineTool
baseCommand: humanfilt setup
label: humanfilt_setup
doc: "Setup humanfilt references.\n\nTool homepage: https://github.com/jprehn-lab/humanfilt"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Destination directory for references
    default: user cache
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: force
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humanfilt:1.0.0--pyhdfd78af_0
stdout: humanfilt_setup.out
