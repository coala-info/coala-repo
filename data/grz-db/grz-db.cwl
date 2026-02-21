cwlVersion: v1.2
class: CommandLineTool
baseCommand: grz-db
label: grz-db
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments or tool descriptions could be
  extracted from the input.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-db:1.2.0--pyhdfd78af_0
stdout: grz-db.out
