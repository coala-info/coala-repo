cwlVersion: v1.2
class: CommandLineTool
baseCommand: staden
label: staden_docker
doc: "The Staden Package is a set of tools for DNA sequence assembly, editing, and
  analysis. (Note: The provided text appears to be a container build error log rather
  than CLI help text; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/oshikiri/staden-outliner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden:v2.0.0b11-4-deb_cv1
stdout: staden_docker.out
