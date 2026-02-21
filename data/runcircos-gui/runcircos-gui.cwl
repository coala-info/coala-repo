cwlVersion: v1.2
class: CommandLineTool
baseCommand: runcircos-gui
label: runcircos-gui
doc: "A graphical user interface for the Circos visualization tool.\n\nTool homepage:
  https://github.com/narunlifescience/runcircos-gui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/runcircos-gui:v0.0git20180828.97703b9-1-deb_cv1
stdout: runcircos-gui.out
