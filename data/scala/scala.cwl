cwlVersion: v1.2
class: CommandLineTool
baseCommand: scala
label: scala
doc: "Run Scala scripts, classes, objects, or jars, or start the interactive shell.\n\
  \nTool homepage: https://github.com/binhnguyennus/awesome-scalability"
inputs:
  - id: script_file
    type:
      - 'null'
      - File
    doc: A Scala script or source file, or a runnable jar file, to run.
    inputBinding:
      position: 101
  - id: class_name
    type:
      - 'null'
      - string
    doc: Name of a compiled class or object to run (use instead of script_file).
    inputBinding:
      position: 101
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to the script, class, object, or jar.
    inputBinding:
      position: 102
  - id: execute_string
    type:
      - 'null'
      - string
    doc: execute <string> as if entered in the repl
    inputBinding:
      position: 50
      prefix: -e
  - id: howtorun
    type:
      - 'null'
      - string
    doc: what to run <script|object|jar|guess>
    inputBinding:
      position: 50
      prefix: -howtorun
  - id: java_arg
    type:
      - 'null'
      - string
    doc: Passed to java as-is (written as -J<arg>).
    inputBinding:
      position: 50
      prefix: -J
      separate: false
  - id: no_compilation_daemon
    type:
      - 'null'
      - boolean
    doc: 'no compilation daemon: do not use the fsc offline compiler'
    inputBinding:
      position: 50
      prefix: -nc
  - id: nobootcp
    type:
      - 'null'
      - boolean
    doc: do not put the scala jars on the boot classpath (slower)
    inputBinding:
      position: 50
      prefix: -nobootcp
  - id: preload_file
    type:
      - 'null'
      - File
    doc: preload <file> before starting the repl
    inputBinding:
      position: 50
      prefix: -i
  - id: save
    type:
      - 'null'
      - boolean
    doc: save the compiled script in a jar for future use
    inputBinding:
      position: 50
      prefix: -save
  - id: system_property
    type:
      - 'null'
      - string
    doc: Passed directly to java to set a system property, written as name=prop.
    inputBinding:
      position: 50
      prefix: -D
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scala:2.11.8--1
stdout: scala.out
