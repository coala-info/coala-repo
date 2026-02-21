cwlVersion: v1.2
class: CommandLineTool
baseCommand: srst2
label: srst2
doc: "Short Read Sequence Typer (Note: The provided text is a container execution
  error log and does not contain CLI help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/katholt/srst2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/srst2:v0.2.0-6-deb_cv1
stdout: srst2.out
