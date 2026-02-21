cwlVersion: v1.2
class: CommandLineTool
baseCommand: retry_decorator
label: retry_decorator
doc: "A tool or library for retrying function execution with decorators.\n\nTool homepage:
  https://github.com/pnpnpn/retry-decorator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/retry_decorator:1.1.1--py_0
stdout: retry_decorator.out
