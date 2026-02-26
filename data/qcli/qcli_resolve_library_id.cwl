cwlVersion: v1.2
class: CommandLineTool
baseCommand: id
label: qcli_resolve_library_id
doc: "Print user and group information for the specified USER, or (when USER omitted)
  for the current user.\n\nTool homepage: https://github.com/xyOz-dev/LogiQCLI"
inputs:
  - id: user
    type:
      - 'null'
      - string
    doc: User to get information for (defaults to current user)
    inputBinding:
      position: 1
  - id: context
    type:
      - 'null'
      - boolean
    doc: print only the security context of the process
    inputBinding:
      position: 102
      prefix: --context
  - id: group
    type:
      - 'null'
      - boolean
    doc: print only the effective group ID
    inputBinding:
      position: 102
      prefix: --group
  - id: groups
    type:
      - 'null'
      - boolean
    doc: print all group IDs
    inputBinding:
      position: 102
      prefix: --groups
  - id: ignore_compatibility
    type:
      - 'null'
      - boolean
    doc: ignore, for compatibility with other versions
    inputBinding:
      position: 102
      prefix: -a
  - id: name
    type:
      - 'null'
      - boolean
    doc: print a name instead of a number, for -ugG
    inputBinding:
      position: 102
      prefix: --name
  - id: real
    type:
      - 'null'
      - boolean
    doc: print the real ID instead of the effective ID, with -ugG
    inputBinding:
      position: 102
      prefix: --real
  - id: user_id
    type:
      - 'null'
      - boolean
    doc: print only the effective user ID
    inputBinding:
      position: 102
      prefix: --user
  - id: zero
    type:
      - 'null'
      - boolean
    doc: delimit entries with NUL characters, not whitespace; not permitted in 
      default format
    inputBinding:
      position: 102
      prefix: --zero
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qcli:v0.1.1-3-deb-py2_cv1
stdout: qcli_resolve_library_id.out
