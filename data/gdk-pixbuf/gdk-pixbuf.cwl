cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdk-pixbuf
label: gdk-pixbuf
doc: "The provided text does not contain help information for gdk-pixbuf; it contains
  system error messages related to a container runtime failure.\n\nTool homepage:
  https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdk-pixbuf:2.32.2--0
stdout: gdk-pixbuf.out
