cwlVersion: v1.2
class: CommandLineTool
baseCommand: spyder
label: spyder
doc: "Spyder is a free and open-source Scientific Python Development Environment\n\
  \nTool homepage: https://github.com/spyder-ide/spyder"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to open
    inputBinding:
      position: 1
  - id: defaults
    type:
      - 'null'
      - boolean
    doc: Reset configuration settings to defaults
    inputBinding:
      position: 102
      prefix: --defaults
  - id: hide_console
    type:
      - 'null'
      - boolean
    doc: Hide parent console window (Windows)
    inputBinding:
      position: 102
      prefix: --hide-console
  - id: multithread
    type:
      - 'null'
      - boolean
    doc: Internal console is executed in another thread (separate from main 
      application thread)
    inputBinding:
      position: 102
      prefix: --multithread
  - id: new_instance
    type:
      - 'null'
      - boolean
    doc: Run a new instance of Spyder, even if the single instance mode has been
      turned on (default)
    inputBinding:
      position: 102
      prefix: --new-instance
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Optimize Spyder bytecode (this may require administrative privileges)
    inputBinding:
      position: 102
      prefix: --optimize
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Profile mode (internal test, not related with Python profiling)
    inputBinding:
      position: 102
      prefix: --profile
  - id: project
    type:
      - 'null'
      - File
    doc: Path that contains an Spyder project
    inputBinding:
      position: 102
      prefix: --project
  - id: reset
    type:
      - 'null'
      - boolean
    doc: Remove all configuration files!
    inputBinding:
      position: 102
      prefix: --reset
  - id: show_console
    type:
      - 'null'
      - boolean
    doc: (Deprecated) Does nothing, now the default behavior is to show the 
      console
    inputBinding:
      position: 102
      prefix: --show-console
  - id: window_title
    type:
      - 'null'
      - string
    doc: String to show in the main window title
    inputBinding:
      position: 102
      prefix: --window-title
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: Default working directory
    inputBinding:
      position: 102
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spyder:3.3.1--py35_1
stdout: spyder.out
