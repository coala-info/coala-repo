cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_manage_db.rb
label: protk_manage_db.rb
doc: "A tool for managing protein databases within the Protk framework. (Note: The
  provided help text contains container runtime error logs and does not list specific
  arguments.)\n\nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_manage_db.rb.out
