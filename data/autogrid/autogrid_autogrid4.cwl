cwlVersion: v1.2
class: CommandLineTool
baseCommand: autogrid4
label: autogrid_autogrid4
doc: "The provided text is a system error message regarding a container image conversion
  failure and does not contain help documentation or command-line argument definitions
  for the tool.\n\nTool homepage: http://autodock.scripps.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/autogrid:v4.2.6-6-deb_cv1
stdout: autogrid_autogrid4.out
