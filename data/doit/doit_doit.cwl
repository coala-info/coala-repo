cwlVersion: v1.2
class: CommandLineTool
baseCommand: doit
label: doit_doit
doc: "Run tasks defined in a dodo.py file (doit run is the default command).\n\
  \nTool homepage: https://pydoit.org"
inputs:
  - id: dodo_file
    type: File
    doc: Specify the dodo file name. Defaults to 'dodo.py'. The file is staged 
      in the working directory, because doit writes its .doit.db and the task 
      targets next to the dodo file.
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: $(self.basename)
  - id: tasks
    type:
      - 'null'
      - type: array
        items: string
    doc: Tasks or targets to run (default all default tasks)
    inputBinding:
      position: 102
  - id: always_execute
    type:
      - 'null'
      - boolean
    doc: always execute tasks even if up-to-date
    inputBinding:
      position: 101
      prefix: --always-execute
  - id: continue_on_failure
    type:
      - 'null'
      - boolean
    doc: continue executing tasks even after a failure
    inputBinding:
      position: 101
      prefix: --continue
  - id: backend
    type:
      - 'null'
      - string
    doc: 'Select dependency file backend: dbm, json, sqlite3'
    inputBinding:
      position: 101
      prefix: --backend=
      separate: false
  - id: check_file_uptodate
    type:
      - 'null'
      - string
    doc: "Choose how to check if files have been modified: 'md5' or 'timestamp'"
    inputBinding:
      position: 101
      prefix: --check_file_uptodate=
      separate: false
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 0 capture (do not print) stdout/stderr from task, 1 capture stdout 
      only, 2 do not capture anything
    inputBinding:
      position: 101
      prefix: --verbosity=
      separate: false
  - id: reporter
    type:
      - 'null'
      - string
    doc: 'Choose output reporter: console, executed-only, json, zero'
    inputBinding:
      position: 101
      prefix: --reporter=
      separate: false
  - id: process
    type:
      - 'null'
      - int
    doc: number of subprocesses
    inputBinding:
      position: 101
      prefix: --process=
      separate: false
  - id: parallel_type
    type:
      - 'null'
      - string
    doc: "Tasks can be executed in parallel: 'process' or 'thread'"
    inputBinding:
      position: 101
      prefix: --parallel-type=
      separate: false
  - id: single
    type:
      - 'null'
      - boolean
    doc: Execute only specified tasks ignoring their task_dep
    inputBinding:
      position: 101
      prefix: --single
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: task_files
    type:
      type: array
      items: File
    doc: Files in the working directory after the run, including the targets 
      written by the tasks
    outputBinding:
      glob: '*'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.dodo_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/doit:0.29.0--py27_0
stdout: doit_doit.out
