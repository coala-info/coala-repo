cwlVersion: v1.2
class: CommandLineTool
baseCommand: neobio
label: neobio
doc: "A library for biological sequence alignment. (Note: The provided text is a container
  runtime error log and does not contain help information or argument definitions.)\n
  \nTool homepage: https://github.com/mlus-asuka/NeoBiosphere"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/neobio:v0.0.20030929-4-deb_cv1
stdout: neobio.out
