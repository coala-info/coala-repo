cwlVersion: v1.2
class: CommandLineTool
baseCommand: runjob_runsge
label: runjob_runsge
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be an error log from a container build process.\n\nTool homepage:
  https://github.com/yodeng/runjob"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/runjob:2.10.9--pyhdfd78af_0
stdout: runjob_runsge.out
