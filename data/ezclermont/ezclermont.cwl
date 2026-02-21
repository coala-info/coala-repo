cwlVersion: v1.2
class: CommandLineTool
baseCommand: ezclermont
label: ezclermont
doc: "A tool for Clermont phylotyping of Escherichia coli. (Note: The provided text
  contains system error messages regarding container execution and does not include
  the tool's help documentation; therefore, no arguments could be extracted.)\n\n
  Tool homepage: https://github.com/nickp60/ezclermont"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezclermont:0.7.0--pyhdfd78af_0
stdout: ezclermont.out
