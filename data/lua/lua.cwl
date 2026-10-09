cwlVersion: v1.2
class: CommandLineTool
baseCommand: lua
label: lua
doc: "Execute Lua scripts or enter interactive mode\n\nTool homepage: https://www.lua.org"
inputs:
  - id: script
    type:
      - 'null'
      - File
    doc: The Lua script to execute
    inputBinding:
      position: 10
  - id: script_args
    type:
      - 'null'
      - type: array
        items:
          - string
          - File
    doc: Arguments to pass to the script (strings, or Files that are staged and passed by path)
    inputBinding:
      position: 11
  - id: execute_string
    type:
      - 'null'
      - string
    doc: Execute the given string as Lua code
    inputBinding:
      position: 1
      prefix: -e
  - id: ignore_environment
    type:
      - 'null'
      - boolean
    doc: Ignore environment variables
    inputBinding:
      position: 1
      prefix: -E
  - id: interactive_mode
    type:
      - 'null'
      - boolean
    doc: Enter interactive mode after executing 'script'
    inputBinding:
      position: 1
      prefix: -i
  - id: require_library
    type:
      - 'null'
      - string
    doc: Require the specified Lua library
    inputBinding:
      position: 1
      prefix: -l
  - id: stop_handling_options_double_dash
    type:
      - 'null'
      - boolean
    doc: Stop handling options
    inputBinding:
      position: 1
      prefix: --
  - id: stop_handling_options_single_dash
    type:
      - 'null'
      - boolean
    doc: Stop handling options and execute stdin
    inputBinding:
      position: 1
      prefix: '-'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lua:5.3.4
stdout: lua.out
