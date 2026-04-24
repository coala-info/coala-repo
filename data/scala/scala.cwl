cwlVersion: v1.2
class: CommandLineTool
baseCommand: scala
label: scala
doc: "Run Scala scripts, classes, objects, or jars, or start the interactive shell.\n\
  \nTool homepage: https://github.com/binhnguyennus/awesome-scalability"
inputs:
  - id: script_class_object_jar
    type:
      - 'null'
      - string
    doc: The script, class, object, or jar to run. If not provided, the 
      interactive shell (REPL) is started.
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to the script, class, object, or jar.
    inputBinding:
      position: 2
  - id: execute_string
    type:
      - 'null'
      - string
    doc: execute <string> as if entered in the repl
    inputBinding:
      position: 103
      prefix: -e
  - id: howtorun
    type:
      - 'null'
      - string
    doc: what to run <script|object|jar|guess>
    inputBinding:
      position: 103
  - id: java_arg
    type:
      - 'null'
      - string
    doc: -J is stripped and <arg> passed to java as-is.
    inputBinding:
      position: 103
      prefix: -J<arg>
  - id: no_compilation_daemon
    type:
      - 'null'
      - boolean
    doc: 'no compilation daemon: do not use the fsc offline compiler'
    inputBinding:
      position: 103
      prefix: -nc
  - id: nobootcp
    type:
      - 'null'
      - boolean
    doc: do not put the scala jars on the boot classpath (slower)
    inputBinding:
      position: 103
      prefix: -nobootcp
  - id: preload_file
    type:
      - 'null'
      - File
    doc: preload <file> before starting the repl
    inputBinding:
      position: 103
      prefix: -i
  - id: save
    type:
      - 'null'
      - boolean
    doc: save the compiled script in a jar for future use
    inputBinding:
      position: 103
      prefix: -save
  - id: system_property
    type:
      - 'null'
      - string
    doc: Passed directly to java to set system properties.
    inputBinding:
      position: 103
      prefix: -Dname=prop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scala:2.11.8--1
stdout: scala.out
