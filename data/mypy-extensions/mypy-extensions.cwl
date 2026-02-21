cwlVersion: v1.2
class: CommandLineTool
baseCommand: mypy-extensions
label: mypy-extensions
doc: "The provided text is a system error log regarding a container runtime failure
  and does not contain help documentation or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/python/mypy_extensions"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mypy-extensions:v0.4.1-1-deb-py3_cv1
stdout: mypy-extensions.out
