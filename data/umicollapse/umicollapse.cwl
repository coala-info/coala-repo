cwlVersion: v1.2
class: CommandLineTool
baseCommand: umicollapse
label: umicollapse
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a container build failure.\n\nTool homepage: https://github.com/Daniel-Liu-c0deb0t/UMICollapse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umicollapse:1.1.0--hdfd78af_0
stdout: umicollapse.out
