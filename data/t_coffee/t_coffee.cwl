cwlVersion: v1.2
class: CommandLineTool
baseCommand: t_coffee
label: t_coffee
doc: "T-Coffee is a multiple sequence alignment package. (Note: The provided text
  contains container runtime error logs rather than tool help text; therefore, no
  arguments could be extracted.)\n\nTool homepage: https://github.com/jashkenas/coffee-script-tmbundle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t-coffee:13.46.2.7c9e712d--pl5321hb2a3317_0
stdout: t_coffee.out
