cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybda
label: pybda
doc: "Python Big Data Analytics tool. (Note: The provided text is a system error log
  from a container build process and does not contain CLI usage instructions or argument
  definitions.)\n\nTool homepage: https://github.com/cbg-ethz/pybda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybda:0.1.0--pyh5ca1d4c_0
stdout: pybda.out
