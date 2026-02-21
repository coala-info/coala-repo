cwlVersion: v1.2
class: CommandLineTool
baseCommand: dotter
label: dotter
doc: "A graphical dot-plot program for comparing two sequences. (Note: The provided
  text contains system error logs and does not list command-line arguments.)\n\nTool
  homepage: https://github.com/pymumu/smartdns"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dotter:v4.44.1dfsg-3-deb_cv1
stdout: dotter.out
