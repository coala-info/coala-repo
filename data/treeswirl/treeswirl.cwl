cwlVersion: v1.2
class: CommandLineTool
baseCommand: treeswirl
label: treeswirl
doc: "The provided text is a system error log regarding a failed container build/execution
  and does not contain help text or usage information for the 'treeswirl' command.\n
  \nTool homepage: https://bitbucket.org/wegmannlab/treeswirl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treeswirl:2.0.0--h778a338_0
stdout: treeswirl.out
