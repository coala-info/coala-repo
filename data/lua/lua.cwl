cwlVersion: v1.2
class: CommandLineTool
baseCommand: lua
label: lua
doc: "Execute Lua scripts or enter interactive mode\n\nTool homepage: https://github.com/luanti-org/luanti"
inputs:
  - id: script
    type:
      - 'null'
      - string
    doc: The Lua script to execute
    inputBinding:
      position: 1
  - id: script_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to the script
    inputBinding:
      position: 2
  - id: execute_string
    type:
      - 'null'
      - string
    doc: Execute the given string as Lua code
    inputBinding:
      position: 103
      prefix: -e
  - id: ignore_environment
    type:
      - 'null'
      - boolean
    doc: Ignore environment variables
    inputBinding:
      position: 103
      prefix: -E
  - id: interactive_mode
    type:
      - 'null'
      - boolean
    doc: Enter interactive mode after executing 'script'
    inputBinding:
      position: 103
      prefix: -i
  - id: require_library
    type:
      - 'null'
      - string
    doc: Require the specified Lua library
    inputBinding:
      position: 103
      prefix: -l
  - id: stop_handling_options_double_dash
    type:
      - 'null'
      - boolean
    doc: Stop handling options
    inputBinding:
      position: 103
      prefix: --
  - id: stop_handling_options_single_dash
    type:
      - 'null'
      - boolean
    doc: Stop handling options and execute stdin
    inputBinding:
      position: 103
      prefix: '-'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lua:5.3.4
stdout: lua.out
