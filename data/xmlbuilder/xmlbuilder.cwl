cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmlbuilder
label: xmlbuilder
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be an error log from a container execution environment (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/oozcitak/xmlbuilder-js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlbuilder:1.0--py36_1
stdout: xmlbuilder.out
