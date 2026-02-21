cwlVersion: v1.2
class: CommandLineTool
baseCommand: pm_which
label: perl-module-util_pm_which
doc: "Returns the path to the given module(s)\n\nTool homepage: http://metacpan.org/pod/Module::Util"
inputs:
  - id: modules
    type:
      type: array
      items: string
    doc: Module(s) to find paths for
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: Print all paths, not just the first one found
    inputBinding:
      position: 102
      prefix: --all
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Dump paths that would be searched (@INC by default)
    inputBinding:
      position: 102
      prefix: --dump
  - id: include_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Add a path to search (like perl -I)
    inputBinding:
      position: 102
      prefix: -I
  - id: module_names_only
    type:
      - 'null'
      - boolean
    doc: Only print module names, not paths
    inputBinding:
      position: 102
      prefix: -m
  - id: namespace
    type:
      - 'null'
      - boolean
    doc: Print all modules in the given namespace
    inputBinding:
      position: 102
      prefix: --namespace
  - id: paths
    type:
      - 'null'
      - boolean
    doc: Just convert the module name into a relative path
    inputBinding:
      position: 102
      prefix: --paths
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Just print paths
    inputBinding:
      position: 102
      prefix: --quiet
  - id: read_stdin
    type:
      - 'null'
      - boolean
    doc: Read modules from stdin, one per line
    inputBinding:
      position: 102
      prefix: '-'
  - id: show_version
    type:
      - 'null'
      - boolean
    doc: Show module version
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-util:1.09--pl526_0
stdout: perl-module-util_pm_which.out
