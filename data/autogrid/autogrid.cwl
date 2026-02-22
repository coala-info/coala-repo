cwlVersion: v1.2
class: CommandLineTool
baseCommand: autogrid
label: autogrid
doc: "The provided text is a system log indicating a container build failure and does
  not contain help information or argument definitions for the autogrid tool.\n\n\
  Tool homepage: http://autodock.scripps.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/autogrid:v4.2.6-6-deb_cv1
stdout: autogrid.out
