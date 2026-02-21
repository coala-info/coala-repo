cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bakta
  - db
label: bakta_bakta_db
doc: "Bakta database management tool. (Note: The provided input text was an error
  log and did not contain usage information or argument definitions.)\n\nTool homepage:
  https://github.com/oschwengers/bakta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakta:1.12.0--pyhdfd78af_0
stdout: bakta_bakta_db.out
