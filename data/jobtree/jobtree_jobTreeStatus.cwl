cwlVersion: v1.2
class: CommandLineTool
baseCommand: jobTreeStatus
label: jobtree_jobTreeStatus
doc: "A tool to check the status of a jobTree execution. (Note: The provided help
  text contains only system error logs and no argument definitions.)\n\nTool homepage:
  https://github.com/benedictpaten/jobTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jobtree:09.04.2017--py_2
stdout: jobtree_jobTreeStatus.out
