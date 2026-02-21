cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe_hp_demo
label: haphpipe_hp_demo
doc: "HAplotype Reconstruction PHyloPIPEline demo tool. (Note: The provided text contains
  container runtime error logs and does not list specific command-line arguments or
  usage instructions).\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_hp_demo.out
