cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtftk
label: pygtftk_gtftk
doc: "A toolbox to handle GTF files.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: bash_comp
    type:
      - 'null'
      - boolean
    doc: Get a script to activate bash completion.
    default: false
    inputBinding:
      position: 101
      prefix: --bash-comp
  - id: list_plugins
    type:
      - 'null'
      - boolean
    doc: Get the list of plugins.
    default: false
    inputBinding:
      position: 101
      prefix: --list-plugins
  - id: plugin_path
    type:
      - 'null'
      - boolean
    doc: Print plugin path
    default: false
    inputBinding:
      position: 101
      prefix: --plugin-path
  - id: plugin_tests
    type:
      - 'null'
      - boolean
    doc: Display bats tests for all plugin.
    default: false
    inputBinding:
      position: 101
      prefix: --plugin-tests
  - id: plugin_tests_no_conn
    type:
      - 'null'
      - boolean
    doc: Display bats tests for plugins not relying on server conn.
    default: false
    inputBinding:
      position: 101
      prefix: --plugin-tests-no-conn
  - id: system_info
    type:
      - 'null'
      - boolean
    doc: Display some info about the system.
    default: false
    inputBinding:
      position: 101
      prefix: --system-info
  - id: update_plugins
    type:
      - 'null'
      - boolean
    doc: Read the ~/.gtftk folder and update the plugin list.
    default: false
    inputBinding:
      position: 101
      prefix: --update-plugins
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
stdout: pygtftk_gtftk.out
