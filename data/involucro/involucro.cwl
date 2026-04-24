cwlVersion: v1.2
class: CommandLineTool
baseCommand: involucro
label: involucro
doc: "v1.1.2\n\nTool homepage: https://github.com/involucro/involucro"
inputs:
  - id: control_file
    type:
      - 'null'
      - string
    doc: Set the control file
    inputBinding:
      position: 101
      prefix: -f
  - id: docker_url
    type:
      - 'null'
      - string
    doc: Set the URL of the Docker instance
    inputBinding:
      position: 101
      prefix: --host
  - id: evaluate_script
    type:
      - 'null'
      - string
    doc: Evaluate the given script directly, not evaluating the control file
    inputBinding:
      position: 101
      prefix: -e
  - id: set_vars
    type:
      - 'null'
      - type: array
        items: string
    doc: Used as KEY=VALUE, makes VAR[KEY] available with value VALUE in Lua 
      script
    inputBinding:
      position: 101
      prefix: --set
  - id: tasks
    type:
      - 'null'
      - boolean
    doc: Shorthand for --tasks
    inputBinding:
      position: 101
      prefix: --tasks
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set verbosity, 3 logs everything, 2 shows standard output
    inputBinding:
      position: 101
      prefix: -v
  - id: working_dir
    type:
      - 'null'
      - string
    doc: Set working dir, being the base for all operations. Also settable via 
      environment variable $INVOLUCRO_WORKDIR
    inputBinding:
      position: 101
      prefix: -w
  - id: wrap_task
    type:
      - 'null'
      - string
    doc: Execute encoded wrap task
    inputBinding:
      position: 101
      prefix: -wrap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/involucro:1.1.2--0
stdout: involucro.out
