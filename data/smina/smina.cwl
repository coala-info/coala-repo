cwlVersion: v1.2
class: CommandLineTool
baseCommand: smina
label: smina
doc: "smina is a fork of AutoDock Vina that is customized to better support scoring
  function development and user-specified scoring functions. (Note: The provided text
  is a container runtime error log and does not contain help information or argument
  definitions).\n\nTool homepage: https://sourceforge.net/projects/smina/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smina:2017.11.9--0
stdout: smina.out
