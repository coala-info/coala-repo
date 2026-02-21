cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambitcore
label: gambitcore
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages related to a container execution failure.\n
  \nTool homepage: https://github.com/gambit-suite/gambitcore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambitcore:0.0.2--py310h1fe012e_0
stdout: gambitcore.out
