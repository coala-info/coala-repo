cwlVersion: v1.2
class: CommandLineTool
baseCommand: kodoja_kodoja_build.py
label: kodoja_kodoja_build.py
doc: "The provided text does not contain help information for the tool; it contains
  log messages and a fatal error regarding container execution and disk space.\n\n
  Tool homepage: https://github.com/abaizan/kodoja/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kodoja:0.0.10--0
stdout: kodoja_kodoja_build.py.out
