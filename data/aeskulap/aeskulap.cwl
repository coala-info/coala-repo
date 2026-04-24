cwlVersion: v1.2
class: CommandLineTool
baseCommand: Gio::Settings init
label: aeskulap
doc: "Initialize Gio settings.\n\nTool homepage: https://github.com/pipelka/aeskulap"
inputs:
  - id: datadir
    type:
      - 'null'
      - Directory
    doc: Data directory for settings.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aeskulap:v0.2.2-beta2git20180219.8787e95-2-deb_cv1
stdout: aeskulap.out
