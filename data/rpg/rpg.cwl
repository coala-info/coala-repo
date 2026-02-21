cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpg
label: rpg
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the 'rpg' tool.\n\nTool homepage:
  https://github.com/jynew/jynew"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rpg:v1.1.0_cv1
stdout: rpg.out
