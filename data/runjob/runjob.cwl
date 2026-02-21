cwlVersion: v1.2
class: CommandLineTool
baseCommand: runjob
label: runjob
doc: "The provided text appears to be a container build log rather than CLI help text.
  No arguments or usage information could be extracted from the input.\n\nTool homepage:
  https://github.com/yodeng/runjob"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/runjob:2.10.9--pyhdfd78af_0
stdout: runjob.out
