cwlVersion: v1.2
class: CommandLineTool
baseCommand: mypy
label: mypy
doc: "Mypy is an optional static type checker for Python that aims to combine the
  benefits of dynamic (or \"duck\") typing and static typing.\n\nTool homepage: https://github.com/python/mypy"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Type-check given files or directories
    inputBinding:
      position: 1
  - id: command
    type:
      - 'null'
      - string
    doc: Type-check the given string of Python code
    inputBinding:
      position: 102
      prefix: --command
  - id: config_file
    type:
      - 'null'
      - File
    doc: Read configuration from FILE
    inputBinding:
      position: 102
      prefix: --config-file
  - id: follow_imports
    type:
      - 'null'
      - string
    doc: How to treat imports (normal, silent, skip, error)
    inputBinding:
      position: 102
      prefix: --follow-imports
  - id: ignore_missing_imports
    type:
      - 'null'
      - boolean
    doc: Silence error messages about imports that cannot be resolved
    inputBinding:
      position: 102
      prefix: --ignore-missing-imports
  - id: module
    type:
      - 'null'
      - type: array
        items: string
    doc: Type-check the given module
    inputBinding:
      position: 102
      prefix: --module
  - id: package
    type:
      - 'null'
      - type: array
        items: string
    doc: Type-check the given package
    inputBinding:
      position: 102
      prefix: --package
  - id: python_version
    type:
      - 'null'
      - string
    doc: Type-check code assuming it will be run on Python of a specific version
    inputBinding:
      position: 102
      prefix: --python-version
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Strict mode; enables several additional checks
    inputBinding:
      position: 102
      prefix: --strict
  - id: warn_unused_configs
    type:
      - 'null'
      - boolean
    doc: Warn about unused [mypy-<pattern>] config sections
    inputBinding:
      position: 102
      prefix: --warn-unused-configs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mypy:v0.670-2-deb-py3_cv1
stdout: mypy.out
