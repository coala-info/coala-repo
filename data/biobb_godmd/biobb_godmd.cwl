cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_godmd
label: biobb_godmd
doc: "The provided text does not contain help information for the tool, but rather
  an error log indicating a failure to build the container image due to lack of disk
  space. No arguments or tool descriptions could be extracted from the input.\n\n
  Tool homepage: https://github.com/bioexcel/biobb_godmd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_godmd:5.2.0--pyhdfd78af_0
stdout: biobb_godmd.out
