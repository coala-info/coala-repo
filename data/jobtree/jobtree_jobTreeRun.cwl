cwlVersion: v1.2
class: CommandLineTool
baseCommand: jobTreeRun
label: jobtree_jobTreeRun
doc: "The provided text contains system error messages (FATAL: Unable to handle docker
  uri, no space left on device) rather than the help documentation for the tool. As
  a result, no arguments or tool descriptions could be extracted from this specific
  input.\n\nTool homepage: https://github.com/benedictpaten/jobTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jobtree:09.04.2017--py_2
stdout: jobtree_jobTreeRun.out
