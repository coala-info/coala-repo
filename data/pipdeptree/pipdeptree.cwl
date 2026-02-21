cwlVersion: v1.2
class: CommandLineTool
baseCommand: pipdeptree
label: pipdeptree
doc: "Dependency tree of the installed python packages\n\nTool homepage: https://github.com/tox-dev/pipdeptree"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: list all deps at top level
    inputBinding:
      position: 101
      prefix: --all
  - id: exclude
    type:
      - 'null'
      - string
    doc: Comma separated list of select packages to exclude from the output. If set,
      --all will be ignored.
    inputBinding:
      position: 101
      prefix: --exclude
  - id: freeze
    type:
      - 'null'
      - boolean
    doc: Print names so as to write freeze files
    inputBinding:
      position: 101
      prefix: --freeze
  - id: graph_output
    type:
      - 'null'
      - string
    doc: 'Print a dependency graph in the specified output format. Available are all
      formats supported by GraphViz, e.g.: dot, jpeg, pdf, png, svg'
    inputBinding:
      position: 101
      prefix: --graph-output
  - id: json
    type:
      - 'null'
      - boolean
    doc: Display dependency tree as json. This will yield "raw" output that may be
      used by external tools. This option overrides all other options.
    inputBinding:
      position: 101
      prefix: --json
  - id: json_tree
    type:
      - 'null'
      - boolean
    doc: Display dependency tree as json which is nested the same way as the plain
      text output printed by default. This option overrides all other options (except
      --json).
    inputBinding:
      position: 101
      prefix: --json-tree
  - id: local_only
    type:
      - 'null'
      - boolean
    doc: If in a virtualenv that has global access do not show globally installed
      packages
    inputBinding:
      position: 101
      prefix: --local-only
  - id: packages
    type:
      - 'null'
      - string
    doc: Comma separated list of select packages to show in the output. If set, --all
      will be ignored.
    inputBinding:
      position: 101
      prefix: --packages
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Shows the dependency tree in the reverse fashion ie. the sub-dependencies
      are listed with the list of packages that need them under them.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: user_only
    type:
      - 'null'
      - boolean
    doc: Only show installations in the user site dir
    inputBinding:
      position: 101
      prefix: --user-only
  - id: warn
    type:
      - 'null'
      - string
    doc: Warning control. "suppress" will show warnings but return 0 whether or not
      they are present. "silence" will not show warnings at all and always return
      0. "fail" will show warnings and return 1 if any are present.
    default: suppress
    inputBinding:
      position: 101
      prefix: --warn
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pipdeptree:v0.13.2-1-deb-py3_cv1
stdout: pipdeptree.out
