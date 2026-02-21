cwlVersion: v1.2
class: CommandLineTool
baseCommand: dotter
label: acedb-other-dotter
doc: 'A graphical dot-plot program for comparing two sequences. (Note: The provided
  help text contains only system error logs and no command-line argument definitions.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/acedb-other-dotter:v4.9.39dfsg.02-4-deb_cv1
stdout: acedb-other-dotter.out
