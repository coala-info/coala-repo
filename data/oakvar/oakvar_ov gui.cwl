cwlVersion: v1.2
class: CommandLineTool
baseCommand: ov_gui
label: oakvar_ov gui
doc: "OakVar graphical user interface\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: result
    type:
      - 'null'
      - File
    doc: Path to a OakVar result SQLite file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Console echoes exceptions written to log file.
    inputBinding:
      position: 102
      prefix: --debug
  - id: headless
    type:
      - 'null'
      - boolean
    doc: do not open the OakVar web page
    inputBinding:
      position: 102
      prefix: --headless
  - id: http_only
    type:
      - 'null'
      - boolean
    doc: Force not to accept https connection
    inputBinding:
      position: 102
      prefix: --http-only
  - id: multiuser
    type:
      - 'null'
      - boolean
    doc: Runs in multiuser mode
    inputBinding:
      position: 102
      prefix: --multiuser
  - id: noguest
    type:
      - 'null'
      - boolean
    doc: Disables guest mode
    inputBinding:
      position: 102
      prefix: --noguest
  - id: port
    type:
      - 'null'
      - int
    doc: Port number for OakVar graphical user interface
    inputBinding:
      position: 102
      prefix: --port
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: run quietly
    inputBinding:
      position: 102
      prefix: --quiet
  - id: webapp
    type:
      - 'null'
      - string
    doc: Name of OakVar webapp module to run
    inputBinding:
      position: 102
      prefix: --webapp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov gui.out
