cwlVersion: v1.2
class: CommandLineTool
baseCommand: jobtree
label: jobtree
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the 'jobtree' command.\n\nTool homepage:
  https://github.com/benedictpaten/jobTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jobtree:09.04.2017--py_2
stdout: jobtree.out
