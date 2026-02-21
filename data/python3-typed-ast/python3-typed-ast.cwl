cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-typed-ast
label: python3-typed-ast
doc: "A Python package that provides a typed Abstract Syntax Tree (AST). Note: The
  provided text appears to be a container build log rather than CLI help text, so
  no arguments could be extracted.\n\nTool homepage: https://github.com/pexip/os-python3-typed-ast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-typed-ast:v0.6.3-1-deb_cv1
stdout: python3-typed-ast.out
